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
    }
}
