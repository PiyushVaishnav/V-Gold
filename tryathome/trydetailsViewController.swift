//
//  trydetailsViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 4/3/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class trydetailsViewController: UIViewController {
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    
    
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    
    }
    
    
    @IBOutlet weak var tryscroll: UIScrollView!
    @IBOutlet weak var myviewll: UIView!
    @IBOutlet weak var myviewl: UIView!
    @IBOutlet weak var myview: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var fullnameView: UITextField!
   
    @IBOutlet weak var pincodeView: UITextField!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var fulladdressView: UITextField!
    
    @IBAction func datePickerchange(_ sender: UIDatePicker) {
    
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.full
       let strDate = dateFormatter.string(from: datePicker.date)
        dateLabel.text = strDate
    
    
    }
   
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func timePickerchange(_ sender: UIDatePicker) {
   
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.full
        let strDate = dateFormatter.string(from: timePicker.date)
        timeLabel.text = strDate
    
    }
    
    @IBAction func Done(_ sender: UIButton) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "select_time=\(timeLabel.text!)&select_date=\(dateLabel.text!)&full_name=\(fullnameView.text!)&pin_code=\(pincodeView.text!)&address=\(fulladdressView.text!)"
        request.httpBody = postString.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            
            guard let data = data, error == nil else{
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {// check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            print("Booking Successful!")
            
            
            DispatchQueue.main.sync {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as!  ViewController
                self.navigationController?.pushViewController(storyboard, animated: true)
                
                self.timeLabel.text = ""
                self.dateLabel.text = ""
                self.fullnameView.text = ""
                self.pincodeView.text = ""
                self.fulladdressView.text = ""
                
            }
            
        }
        task.resume()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tryscroll.contentSize = CGSize(width: self.view.frame.width, height: 1008)
        datePicker.datePickerMode = UIDatePickerMode.date
        timePicker.datePickerMode = UIDatePickerMode.time
        myview.layer.shadowColor = UIColor.black.cgColor
        myview.layer.shadowRadius = 1.7
        myview.layer.shadowOpacity = 0.2
       
        myviewl.layer.shadowColor = UIColor.black.cgColor
        myviewl.layer.shadowRadius = 1.7
        myviewl.layer.shadowOpacity = 0.2
 
        myviewll.layer.shadowColor = UIColor.black.cgColor
        myviewll.layer.shadowRadius = 1.7
        myviewll.layer.shadowOpacity = 0.2
        
        
        url = URL(string: WEB_URL.TRYHOMEDETAIL_URL)
        urlRequest = NSMutableURLRequest(url: url as URL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                print("Successfully connected..")
            }
        }
        task.resume()
    }

   
}
