import Foundation
import FirebaseAuth
import Combine

final class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var user: User?
}
