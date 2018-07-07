//
//  myaccountViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 4/4/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class myaccountViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    
    }
    
    
    @IBOutlet weak var nameView: UITextField!
    
    @IBOutlet weak var genderView: UITextField!
    @IBOutlet weak var addressView: UITextField!
    
    @IBOutlet weak var areaView: UITextField!
    @IBOutlet weak var phoneView: UITextField!
    @IBOutlet weak var myview: UIView!
   
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBAction func btnsave(_ sender: UIBarButtonItem) {
        if nameView.text == ""
        {
            SKToast.show(withMessage: "Enter Valid Name..!")
        }
        else if genderView.text == ""
        {
            SKToast.show(withMessage: "Select the Gender..!")
        }
        else if addressView.text == ""
        {
            SKToast.show(withMessage: "Enter Valid Address..!")
        }
        else if areaView.text == ""
        {
            SKToast.show(withMessage: "Select the Area..!")
        }
        else if phoneView.text == ""
        {
            SKToast.show(withMessage: "Enter Valid Phone..!")
        }
        else if(nameView.text! == "" || genderView.text! == "" || addressView.text! == "" || areaView.text! == "" || phoneView.text! == "")
        {
            SKToast.show(withMessage: "Enter Valid Details.....!")
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
        
        let postString = "user_name=\(nameView.text!)&gender=\(genderView.text!)&address=\(addressView.text!)&area_id=\(areaView.text!)&mobile=\(phoneView.text!)"
        
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
                        let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
                        self.navigationController?.pushViewController(welcomeVC, animated: true)
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    self.nameView.text = ""
                    self.genderView.text = ""
                    self.addressView.text = ""
                    self.areaView.text = ""
                    self.phoneView.text = ""
            }
            
        }
        task.resume()
    }
    
   
    var gender = ["Male","Female"]
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    var genderpickerView = UIPickerView()
    
    var selected_gender = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myview.layer.shadowColor = UIColor.black.cgColor
        myview.layer.shadowRadius = 1.7
        myview.layer.shadowOpacity = 0.2

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
  }



