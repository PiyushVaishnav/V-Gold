//
//  signupViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 4/18/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class signupViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    @objc func doneClicked() {
        genderView.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_gender = [gender[pickerView.selectedRow(inComponent: 0)]]
        genderView.text = gender[row]
    }


    var gender = ["Male","Female"]
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    var genderpickerView = UIPickerView()
    
    var selected_gender = [String]()
    
    
    
    @IBOutlet weak var nameView: UITextField!
    
    @IBOutlet weak var emailView: UITextField!
    
    @IBOutlet weak var passwordView: UITextField!
    
    @IBOutlet weak var genderView: UITextField!
    
    @IBAction func btngender(_ sender: UITextField) {
        genderpickerView.delegate = self
        genderView.inputView = genderpickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let btnClick = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(doneClicked))
        
        toolBar.setItems([cancelButton, spaceButton, btnClick], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        genderView.inputView = genderpickerView
        genderView.inputAccessoryView = toolBar

        
    }
    
    @IBOutlet weak var singupView: UIButton!
    
    @IBAction func btnsingup(_ sender: UIButton) {
        if nameView.text == ""
        {
            SKToast.show(withMessage: "Enter Valid Name..!")
        }
        else if emailView.text == ""
        {
            SKToast.show(withMessage: "Select the Gender..!")
        }
        else if passwordView.text == ""
        {
            SKToast.show(withMessage: "Enter Valid Address..!")
        }
        else if genderView.text == ""
        {
            SKToast.show(withMessage: "Select the Area..!")
        }
        else if(nameView.text! == "" || emailView.text! == "" || passwordView.text! == "" || genderView.text! == "")
        {
            SKToast.show(withMessage: "Enter Valid Details.....!")
        }
        else
        {
            self.RegistrationData()
        }
        
    
    
    }
    
    @IBAction func btnsingin(_ sender: UIButton) {
        let signup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        navigationController?.pushViewController(signup, animated: true)
        
    
    }
    
    
    func RegistrationData()
    {
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let postString = "user_name=\(nameView.text!)&gender=\(genderView.text!)&email_id=\(emailView.text!)&password=\(passwordView.text!)"
        
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
            print("Registration Successful!")
            
            DispatchQueue.main.sync
                {
                    let alert = UIAlertController(title: "", message: "Registration successfull !", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                        self.navigationController?.pushViewController(welcomeVC, animated: true)
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    self.nameView.text = ""
                    self.genderView.text = ""
                    self.emailView.text = ""
                    self.passwordView.text = ""
                   
            }
            
        }
        task.resume()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singupView.layer.cornerRadius = 15.0
        
        genderpickerView.delegate = self
        genderpickerView.dataSource =  self
        url = URL(string:WEB_URL.SINGUP_URL)
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
