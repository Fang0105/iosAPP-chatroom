//
//  registerViewController.swift
//  finalProject
//
//  Created by student on 2020/6/19.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import Firebase

class registerViewController: UIViewController {
    @IBOutlet weak var txtRegisterAccount: UITextField!
    @IBOutlet weak var txtRegisterPassword: UITextField!
    @IBOutlet weak var txtUsersName: UITextField!
    @IBAction func btnSentRegister(_ sender: Any) {
        let db = Firestore.firestore()
        var ref:DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "account":txtRegisterAccount.text!,
            "password":txtRegisterPassword.text!,
            "usersName":txtUsersName.text!
        ]){err in
            if let err = err{
                print("Error adding document: \(err)")
            }else{
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        txtRegisterAccount.text = ""
        txtRegisterPassword.text = ""
        txtUsersName.text = ""
    }
    
   
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   

}
