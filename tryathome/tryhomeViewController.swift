//
//  tryhomeViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 3/29/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class tryhomeViewController: UIViewController {

    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBOutlet weak var tryscroll: UIScrollView!
    @IBOutlet weak var mobileView: UITextField!
    @IBOutlet weak var btnschedule: UIButton!
    @IBAction func btnSchedule(_ sender: UIButton) {
        if mobileView.text == ""
        {
            SKToast.show(withMessage: "Plesss Enter Mobile Number..!")
        }
        else if(mobileView.text! == "")
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
        
        let postString = "mobile=\(mobileView.text!)"
        
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
                      let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "trydetailsViewController") as! trydetailsViewController
                        self.navigationController?.pushViewController(welcomeVC, animated: true)
                    self.mobileView.text = ""
                             }
            
        }
        task.resume()
    }
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tryscroll.contentSize = CGSize(width: self.view.frame.width, height: 760)
        
        url = URL(string:WEB_URL.TRYHOME_URL)
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
