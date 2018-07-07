//
//  loginViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 4/18/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
var loginStatus = Int()
    var status = Int()
    
    @IBOutlet weak var emailView: UITextField!
    
    @IBOutlet weak var passwordView: UITextField!
    
    @IBOutlet weak var singinView: UIButton!
    
    @IBAction func btnsingin(_ sender: UIButton) {
        print("clicked")
        let email = emailView.text
        let pass = passwordView.text
        
        if emailView.text == ""
        {
            SKToast.show(withMessage: "Please Enter Email..!")
        }
        else if passwordView.text == ""
        {
            SKToast.show(withMessage: "Please Enter Password..!")
        }
        else if email != "" && pass != ""
        {
            self.loginData()
        }
    
    }
    
    @IBAction func btnfpass(_ sender: UIButton) {
        let signup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "forgetViewController") as! forgetViewController
        navigationController?.pushViewController(signup, animated: true)
        
    
    
    }
    
    @IBAction func btnsingup(_ sender: UIButton) {
    
        let signup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signupViewController") as! signupViewController
        navigationController?.pushViewController(signup, animated: true)
        
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        singinView.layer.cornerRadius = 15.0
        
     }
    func loginData()
    {
        let url = URL(string: WEB_URL.LOGIN_URL)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "email_id=\(emailView.text!)&password=\(passwordView.text!)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse,
                httpStatus.statusCode != 200{
                print("statusCode  should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    as! [String:AnyObject]
                
                self.status = json["success"] as! Int
                print("Status \(self.loginStatus)")
                
                self.loginStatus = self.status
                print("loginStatus: \(self.loginStatus)")
                DispatchQueue.main.async
                    {
                        if self.loginStatus == 1
                        {
                            print("Status:=\(self.status)")
                            //SKToast.show(withMessage: "Login successfull!")
                            let alert = UIAlertController(title: "Login", message: "Login Successfully", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                
                                let Home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                self.navigationController?.pushViewController(Home, animated: true)
                                
                                self.emailView.text = ""
                                self.passwordView.text = ""
                            })
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else if self.loginStatus == 0
                        {
                            self.emailView.becomeFirstResponder()
                            SKToast.show(withMessage: "Login Fails..!")
                        }
                }
                
            }
            catch
            {
                print(error)
            }
        }
        task.resume()
        if loginStatus == 1
        {
            self.emailView.text = ""
            self.passwordView.text = ""
            print("Welcome V Gold")
        }
    }
    
    
}
