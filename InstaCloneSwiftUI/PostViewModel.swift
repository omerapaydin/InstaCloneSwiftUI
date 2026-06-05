import FirebaseFirestore
import SwiftUI
import Combine



class PostViewModel: ObservableObject {

    @Published var posts: [Post] = []

    private var db = Firestore.firestore()

    func fetchPosts() {

        db.collection("Posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in

                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                self.posts = snapshot?.documents.map { doc in

                    let data = doc.data()

                    return Post(
                        id: doc.documentID,
                        description: data["description"] as? String ?? "",
                        userid: data["userid"] as? String ?? "",
                        username: data["username"] as? String ?? "user"
                    )

                } ?? []
            }
    }
    
    func fetchUsername(uid: String, completion: @escaping (String) -> Void) {

        Firestore.firestore()
            .collection("Users")
            .whereField("userid", isEqualTo: uid)
            .getDocuments { snapshot, error in

                let username = snapshot?.documents.first?["username"] as? String ?? "user"
                completion(username)
            }
    }
}
