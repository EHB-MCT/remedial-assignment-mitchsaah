import Foundation
import Combine
import UIKit
import FirebaseCore
import GoogleSignIn

final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLogin = true
    @Published var errorMessage: String?
    @Published var confirmPassword = ""   // For registering only
    @Published var isLoading = false
       
    private let authService = AuthService.shared
    
    func submit() {
        errorMessage = nil
        
        guard !email.isEmpty else { errorMessage = "Insert your e‑mail"; return }
        guard !password.isEmpty else { errorMessage = "Insert your password"; return }
        if !isLogin {
            guard password == confirmPassword else {
                errorMessage = "Passwords do not match"
                return
            }
        }
        
        if isLogin {
            AuthService.shared.signIn(email: email, password: password) { [weak self] error in
                if let e = error { DispatchQueue.main.async { self?.errorMessage = e.localizedDescription } }
            }
        } else {
            AuthService.shared.signUp(email: email, password: password) { [weak self] error in
                if let e = error { DispatchQueue.main.async { self?.errorMessage = e.localizedDescription } }
            }
        }
    }
    
    @MainActor
    func googleSignIn() {
        errorMessage = nil
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            errorMessage = "Missing Firebase client ID"
            return
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        
        guard
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootVC = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController
        else {
            errorMessage = "Could not find a window to present Google Sign-In."
            return
        }
        
        isLoading = true
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let gUser = result?.user,
                  let idToken = gUser.idToken?.tokenString else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Google sign-in failed (no token)."
                }
                return
            }
            
            let accessToken = gUser.accessToken.tokenString
            
            self.authService.signInWithGoogle(idToken: idToken, accessToken: accessToken) { err in
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let err = err { self.errorMessage = err.localizedDescription }
                }
            }
        }
    }
}
