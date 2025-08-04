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
}
