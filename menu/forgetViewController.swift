//
//  forgetViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 4/18/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class forgetViewController: UIViewController {
    
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    
    @IBOutlet weak var emailView: UITextField!
    
    @IBOutlet weak var sendView: UIButton!
    
    @IBAction func btnsendemail(_ sender: UIButton) {
        if emailView.text == ""
        {
            SKToast.show(withMessage: "Plesss Enter Email Address..!")
        }
        else if(emailView.text! == "")
        {
            SKToast.show(withMessage: "Enter Valid Number.....!")
        }
        else
        {
            self.RegistrationData()
        }
    }
    func RegistrationData()
    {
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "email_id=\(emailView.text!)"
        
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {// check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            print("Send This Mail.. ")
            
            DispatchQueue.main.sync
                {
                    let alert = UIAlertController(title: "", message: "Registration successfull !", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                        self.navigationController?.pushViewController(welcomeVC, animated: true)
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    self.emailView.text = ""
            }
            
        }
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url = URL(string:WEB_URL.FORGET_URL)
        urlRequest = NSMutableURLRequest(url: url as URL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest){
            (date, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if(statusCode == 200){
                
                print("Successfully Connected..")
            }
            
        }
        task.resume()

  
    }

   
}
