import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    static let shared = AuthService()
    private init () {}
}

extension AuthService {
    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    private func saveUserProfile(user: User) {
        let db = Firestore.firestore()
        let profileData: [String: Any] = [
            "uid": user.uid,
            "email": user.email ?? ""
        ]
        db.collection("users").document(user.uid).setData(profileData) { error in
            if let error = error {
                print("[AuthService] Error saving user profile: \(error.localizedDescription)")
            } else {
                print("[AuthService] User profile saved for uid: \(user.uid)")
            }
        }
    }
}

extension AuthService {
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
}

extension AuthService {
    func signOut() {
        try? Auth.auth().signOut()
    }
}
