//
//  ViewController.swift
//  finalProject
//
//  Created by student on 2020/6/19.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var users = [QueryDocumentSnapshot]()
    @IBOutlet weak var txtLogInAccount: UITextField!
    @IBOutlet weak var txtLogInPassword: UITextField!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sg"{
            let vc = segue.destination as! roomViewController
            //print("$$$$$$$",userName)
            vc.username = self.userName
            
        }
        
    }
    var userName = String()
    @IBAction func btnLogIn(_ sender: Any) {
        
        let userAccount = txtLogInAccount.text!
        let userPassword = txtLogInPassword.text!
        var logIn = false
        for user in users {
            //print("\(user.data()["account"] )")
            if user.data()["account"] as! String == userAccount && user.data()["password"] as! String == userPassword {
                userName = user.data()["usersName"] as! String
                logIn = true
            }
        }
        if !logIn {
            let alertController = UIAlertController(title: "錯誤", message: "無此帳密", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "sg", sender: self)

        }
     
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        db.collection("users").addSnapshotListener {
            (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                return
            }
            
            self.users = querySnapshot.documents
        }
    }
}

