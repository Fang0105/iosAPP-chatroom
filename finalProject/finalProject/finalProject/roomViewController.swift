//
//  roomViewController.swift
//  finalProject
//
//  Created by student on 2020/6/19.
//  Copyright © 2020 student. All rights reserved.
//






//TODO avoid empty string ＃OK


import UIKit
import Firebase
class roomViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvMessage.dequeueReusableCell(withIdentifier: "ha")as! messageTableViewCell
        
        cell.lbShowUserName.text = arrMessage[indexPath.row].data()["username"] as? String
        cell.lbShowContent.text = arrMessage[indexPath.row].data()["Message"] as? String
        return cell
        
    }
    
    var arrMessage = [QueryDocumentSnapshot]()
    var username = String()
    @IBOutlet weak var tvMessage: UITableView!
    @IBOutlet weak var txtSendMessage: UITextField!
    @IBAction func btnSendMeaage(_ sender: Any) {
        let db = Firestore.firestore()
        var ref:DocumentReference? = nil
        let str = txtSendMessage.text
        if str?.trimmingCharacters(in: .whitespaces) == ""{
            
        }else{
            
            ref = db.collection("room").addDocument(data: [
                "Message":txtSendMessage.text!,
                "time":FieldValue.serverTimestamp(),
                "username":self.username
            ]){err in
                if let err = err{
                    print("Error adding document: \(err)")
                }else{
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            txtSendMessage.text = ""
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
        db.collection("room").order(by:"time").addSnapshotListener { (qs, err) in
            guard let qs = qs else {
                return
            }
            // 遠端資料就已經和陣列同步
            self.arrMessage = qs.documents
            // 把tableview reload
            self.tvMessage.reloadData()
            self.scrollToBtm()
            //print("&％％％％％ㄎ&&&&",self.username)
            
        }
        /*
        var ref:DocumentReference? = nil
        ref = db.collection("room").addDocument(data: [
            "Message":"\(self.username) online!!",
            "time":FieldValue.serverTimestamp(),
            "username":"System"
        ]){err in
            if let err = err{
                print("Error adding document: \(err)")
            }else{
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        */
        tvMessage.dataSource = self
        tvMessage.delegate = self
    }
    func scrollToBtm() {
        // 非同步動作
        DispatchQueue.main.async {
            // 我要找到目前的tableview的最後一個indexpath
            let IP = IndexPath(row: self.arrMessage.count-1, section: 0)
            self.tvMessage.scrollToRow(at: IP, at: .bottom, animated: true)
        }
    }
}
