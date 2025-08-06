import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLogin = true
    @Published var errorMessage: String?
}
