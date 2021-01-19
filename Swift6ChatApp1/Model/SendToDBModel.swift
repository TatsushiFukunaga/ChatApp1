//
//  SendToDBModel.swift
//  Swift6ChatApp1
//
//  Created by Tatsushi Fukunaga on 2021/01/06.
//

import Foundation
import FirebaseStorage

class sendToDBModel {
    init() {
        
    }
    
    func sendprofileImageData(data:Data){
        
        let image = UIImage(data: data)
        let profileImage = image?.jpegData(compressionQuality: 0.1)
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpeg")
        
        imageRef.putData(Data(profileImage!), metadata:nil)  {(metaData, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            imageRef.downloadURL { (url, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
            }
        }
    }
    
}
