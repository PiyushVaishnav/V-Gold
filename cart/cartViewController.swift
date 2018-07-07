//
//  cartViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 4/14/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class cartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var select_productDetails = String()
    var select_product = String()
    var qty = "1"
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    var TotalPrice : Int = 0
    @IBOutlet weak var totalprice: UILabel!
    
    var jsonPrice = String()
    var jsonQnty = String()
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.tabBarController?.tabBar.isHidden = false
        
        self.tableview.tableFooterView = UIView()
        fetch_categories_details()
        
        url = URL(string: WEB_URL.ORDERCANCEL_URL)
        urlRequest = NSMutableURLRequest(url: url as URL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest as URLRequest)
        {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Successfully connected..")
            }
        }
        task.resume()
        //fetch_categories_details()
    
    }
    
    
    @IBAction func checkout(_ sender: UIButton) {
        let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "orderaddViewController") as! orderaddViewController
        self.navigationController?.pushViewController(welcomeVC, animated: true)
        
    }
    
    
    @IBAction func Goback(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btncancel(_ sender: UIButton) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = "cart_id"
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
            
            
            DispatchQueue.main.sync {
                
              }
            
        }
        task.resume()
        
        
        JSONFIED.cat_id.remove(at: 0)
        let indexPath = IndexPath(item: 0, section: 0)
        tableview.deleteRows(at: [indexPath], with: .fade)
    
    }
    
    @IBOutlet weak var tableview: UITableView!
    
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONFIED.cat_id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")as! CartCell
        cell.productView.text = JSONFIED.productname[indexPath.row]
        cell.priceView.text = JSONFIED.productprice[indexPath.row]
        cell.qtyView.text = JSONFIED.productqty[indexPath.row]
       
        return cell
    }
    
    //for the fetch the category details
    func fetch_categories_details()
    {
        JSONFIED.cat_id.removeAll()
        JSONFIED.productqty.removeAll()
        JSONFIED.productprice.removeAll()
        JSONFIED.productname.removeAll()
        
        let url = URL(string:WEB_URL.ORDERDESPLAY_URL)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                for index in 0...(adata["subcategory"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let proIdJson = (object["cart_id"]as! String)
                    JSONFIED.cat_id.append(proIdJson)
                    // print("product_id=\(proIdJson)")
                    
                    let proimageJson = (object["product_name"]as! String)
                    JSONFIED.productname.append(proimageJson)
                    // print("product_image=\(proimageJson)")
                    
                    let pronameJson = (object["qty"]as! String)
                    JSONFIED.productqty.append(pronameJson)
                    //print("product_image=\(pronameJson)")
                    
                    let propriceJson = (object["product_price"]as! String)
                    JSONFIED.productprice.append(propriceJson)
                    //print("product_image=\(propriceJson)")
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
   

}
