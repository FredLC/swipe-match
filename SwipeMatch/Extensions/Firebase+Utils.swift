//
//  Firebase+Utils.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-01-27.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import Foundation
import Firebase

extension Firestore {
    func fetchCurrentUser(completion: @escaping (User?, Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user, nil)
        }
    }
}
