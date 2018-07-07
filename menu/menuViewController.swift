//
//  menuViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 3/27/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class menuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    var arry = ["Login","My Account","Stores","about us","Share"]
    var image = ["user","My Account","Stores","user","share"]

    @IBAction func btnBack(_ sender: UIBarButtonItem) {
   
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.tableFooterView = UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview
            .dequeueReusableCell(withIdentifier: "mycell") as! menuCell
        
        cell.lblname.text = arry[indexPath.row]
        cell.imageicon.image = UIImage(named: image[indexPath.row])
        return cell
    }
    
   // let currentResponse
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arry[indexPath.row] == "My Account"
        {
            let Stores = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myaccountViewController")as! myaccountViewController
            self.navigationController?.pushViewController(Stores , animated: true)
            
        }else if arry[indexPath.row] == "Stores"
        {
            
            let Stores = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapkitViewController")as! mapkitViewController
            self.navigationController?.pushViewController(Stores , animated: true)
             print("mapkitViewController=\(Stores)")
        
        
        }else if arry[indexPath.row] == "Login"{
            let aboutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController")as! loginViewController
            self.navigationController?.pushViewController(aboutViewController, animated:true)
            
            
        }else if arry[indexPath.row] == "about us"{
            
            let aboutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "aboutViewController")as! aboutViewController
            self.navigationController?.pushViewController(aboutViewController, animated:true)
            print("aboutViewController=\(aboutViewController)")
        }else if arry[indexPath.row] == "Share" {
            
            let textToShare = "This is some text I want to Share." + "www.google.com"
            let objectsToShare = [ textToShare ]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                 activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
            
        }
       
         }
    
    
}
