import Foundation

struct UserProfile: Identifiable {
    var id: String { uid }
    
    let uid: String
    let email: String
    var firstName: String?
    var lastName: String?
    var createdAt: Date?
}
