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
    
    init?(uid: String, data: [String: Any]) {
        guard let email = data["email"] as? String else { return nil }
        self.uid = uid
        self.email = email
        self.firstName = data["firstName"] as? String
        self.lastName  = data["lastName"]  as? String
        
        if let ts = data["createdAt"] as? Timestamp {
            self.createdAt = ts.dateValue()
        } else {
            self.createdAt = nil
        }
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
        self.firstName = nil
        self.lastName  = nil
        self.createdAt = nil
    }
}
