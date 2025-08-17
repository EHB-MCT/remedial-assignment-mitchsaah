import Foundation
import FirebaseAuth
import FirebaseFirestore

enum UserPrefsService {
    private static var db: Firestore { Firestore.firestore() }
    
    // Location
    static func saveLocation(_ sel: LocationSelection, completion: ((Error?) -> Void)? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?(nil)
            return
        }
        let doc = db.collection("users").document(uid).collection("preferences").document("location")
        do {
            let data = try JSONSerialization.jsonObject(with: try JSONEncoder().encode(sel)) as? [String: Any] ?? [:]
            var dict = data; dict["updatedAt"] = FieldValue.serverTimestamp()
            doc.setData(dict, merge: true, completion: completion)
        } catch { completion?(error) }
    }
    
    static func loadLocation(completion: @escaping (LocationSelection?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { completion(nil); return }
        db.collection("users").document(uid).collection("preferences").document("location")
            .getDocument { snap, _ in
                guard let d = snap?.data() else { return completion(nil) }
                do {
                    let json = try JSONSerialization.data(withJSONObject: d)
                    let sel = try JSONDecoder().decode(LocationSelection.self, from: json)
                    completion(sel)
                } catch { completion(nil) }
            }
    }
}
