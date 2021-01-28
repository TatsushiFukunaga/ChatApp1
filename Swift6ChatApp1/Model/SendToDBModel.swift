//
//  SendToDBModel.swift
//  Swift6ChatApp1
//
//  Created by Tatsushi Fukunaga on 2021/01/06.
//

import Foundation
import FirebaseStorage

protocol SendProfileOKDelegate {
    func sendProfileOKDelegate(url:String)
}

class sendToDBModel {
    
    var sendProfileOKDelegate: SendProfileOKDelegate?
    
    init() {
        
    }
    
    func sendprofileImageData(data:Data){
        
        let image = UIImage(data: data)
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpeg")
        
        imageRef.putData(Data(profileImageData!), metadata:nil)  {(metaData, error) in
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
                self.sendProfileOKDelegate?.sendProfileOKDelegate(url: url!.absoluteString)
            }
        }
    }
    
}
