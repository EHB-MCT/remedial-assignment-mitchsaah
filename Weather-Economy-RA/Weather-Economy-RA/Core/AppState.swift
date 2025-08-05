import Foundation
import FirebaseAuth
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
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
        }
    }
    
    deinit {
        if let h = handle {
            Auth.auth().removeStateDidChangeListener(h)
        }
    }

}
