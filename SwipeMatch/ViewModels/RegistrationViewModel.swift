//
//  RegistrationViewModel.swift
//  SwipeMatch
//
//  Created by Fred Lefevre on 2021-01-25.
//  Copyright © 2021 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    var password: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let err = err {
                print("Failed to register user: ", err)
                completion(err)
                return
            }
            
            print("Successfully registered user with id: ", res?.user.uid ?? "")
            
            let filename = UUID().uuidString
            let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            ref.putData(imageData, metadata: nil) { (_, err) in
                
                if let err = err {
                    completion(err)
                    return
                }
                
                print("Finished uploading image to storage.")
                ref.downloadURL { (url, err) in
                    
                    if let err = err {
                        completion(err)
                        return
                    }
                    
                    self.bindableIsRegistering.value = false
                    print("Download url of image: ", url?.absoluteString ?? "")
                }
            }
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
}
