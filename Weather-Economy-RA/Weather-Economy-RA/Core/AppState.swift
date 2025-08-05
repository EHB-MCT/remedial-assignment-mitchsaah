import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

final class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var user: User? = Auth.auth().currentUser {
        didSet {
            print("[AppState] user changed", user?.uid ?? "nil")
        }
    }
    
    @Published var didFinishSetup: Bool = false {
        didSet {
            print("[AppState] didFinishSetup", didFinishSetup)
        }
    }
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    private init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in guard let self = self else {return}
            self.user = user
            
            if let uid = user?.uid {
                self.checkUserProfileExists(uid: uid)
            } else {
                self.didFinishSetup = false
            }
        }
    }
    
    private func checkUserProfileExists(uid: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .getDocument { [weak self] document, _ in
                guard let self = self else { return }
                self.didFinishSetup = document?.exists ?? false
            }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.didFinishSetup = false
        } catch {
            print("[AppState] Sign-out error: \(error.localizedDescription)")
        }
    }
    
    deinit {
        if let h = handle {
            Auth.auth().removeStateDidChangeListener(h)
        }
    }

}
