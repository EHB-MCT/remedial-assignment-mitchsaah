import Foundation
import FirebaseFirestore

struct UserProfile: Identifiable {
    var id: String { uid }
    
    let uid: String
    let email: String
    var firstName: String?
    var lastName: String?
    var createdAt: Date?
}

extension UserProfile {
    var asDict: [String: Any] {
        [
            "uid": uid,
            "email": email,
            "firstName": firstName as Any,
            "lastName": lastName as Any,
            "createdAt": FieldValue.serverTimestamp()
        ]
    }
}
