import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    static let shared = AuthService()
    private init () {}
}

extension AuthService {
    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                self.saveUserProfile(user: user)
            }
            completion(error)
        }
    }
    
    private func saveUserProfile(user: User) {
        let db = Firestore.firestore()
        let profile = UserProfile(uid: user.uid, email: user.email ?? "")
        db.collection("users").document(user.uid)
            .setData(profile.asDict, merge: true) { error in
            if let error = error {
                print("[AuthService] Error saving user profile: \(error.localizedDescription)")
            } else {
                print("[AuthService] User profile saved for uid: \(user.uid)")
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
    
    func signInWithGoogle(idToken: String,
                          accessToken: String,
                          completion: @escaping (Error?) -> Void) {
        
        let cred = GoogleAuthProvider.credential(withIDToken: idToken, accessToken:accessToken)

        Auth.auth().signIn(with: cred) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let user = result?.user else {
              completion(NSError(domain: "AuthService",
                                 code: -1,
                                 userInfo: [NSLocalizedDescriptionKey: "No user after Google sign-in"]))
              return
            }
            
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(user.uid)
            docRef.getDocument { snap, _ in
                if snap?.exists == true {
                    completion(nil)
                    return
                }
                let profile = UserProfile(uid: user.uid, email: user.email ?? "")
                docRef.setData(profile.asDict, merge: true) { setErr in
                    completion(setErr)
                }
            }
        }
    }
}
