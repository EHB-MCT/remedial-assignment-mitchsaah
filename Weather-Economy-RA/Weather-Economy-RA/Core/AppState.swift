import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

final class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var user: UserProfile? {
        didSet {
            print("[AppState] user changed", user?.uid ?? "nil")
        }
    }
    
    @Published var didFinishSetup: Bool = false {
        didSet {
            print("[AppState] didFinishSetup", didFinishSetup)
        }
    }
    
    private var profileListener: ListenerRegistration?
    private var handle: AuthStateDidChangeListenerHandle?
    
    private init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, authUser in guard let self = self else {return}
            
            if let authUser = authUser {
                self.fetchUserProfile(uid: authUser.uid)
            } else {
                self.user = nil
                self.didFinishSetup = false
            }
        }
    }
    
    private func attachProfileListener(uid: String) {
        
    }
    
    private func fetchUserProfile(uid: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .getDocument { [weak self] document, error in
                guard let self = self else { return }
                
                if let data = document?.data(),
                   let profile = UserProfile(uid: uid, data: data) {
                    self.user = profile
                    self.didFinishSetup = true
                } else {
                    self.user = nil
                    self.didFinishSetup = false
                }
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
