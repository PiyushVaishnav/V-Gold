//
//  orderaddViewController.swift
//  V Gold
//
//  Created by Akash Padhiyar on 4/26/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class orderaddViewController: UIViewController {

    @IBAction func Goback(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func payment(_ sender: UIButton) {
        
        let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "succfullViewController") as! succfullViewController
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

   
}
