//
//  DetailMV.swift
//  V Gold
//
//  Created by Akash Padhiyar on 4/25/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class DetailMV: UIViewController {

    var urlRequest: NSMutableURLRequest!
    var url: URL!
    var select_product = String()
    var select_productDetails = String()
    
    @IBAction func Goback(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBOutlet weak var PimagelView: UIImageView!
    @IBOutlet weak var PimageView: UIImageView!
    @IBOutlet weak var PnameView: UILabel!
    @IBOutlet weak var PpriceView: UILabel!
    @IBOutlet weak var Pdetailview: UILabel!
    @IBOutlet weak var PcodeView: UILabel!
    @IBOutlet weak var PweightView: UILabel!
    @IBOutlet weak var PhightView: UILabel!
    @IBOutlet weak var PwidthView: UILabel!
    @IBOutlet weak var PsizeView: UILabel!
    @IBOutlet weak var PmetalView: UILabel!
    @IBOutlet weak var PstoneView: UILabel!
    
    var qty = "1"
    
    @IBAction func btnbuynow(_ sender: UIButton) {
        
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let postString = "product_name=\(PnameView.text!)&qty=\(qty)&product_price=\(PpriceView.text!)"
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
                    
                        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cartViewController") as!  cartViewController
                        self.navigationController?.pushViewController(storyboard, animated: true)
                   
                    self.PnameView.text = ""
                    self.PpriceView.text = ""
                    self.qty = ""
                  }
                
            }
            task.resume()
        
    }
    
    @IBAction func btntryhome(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tryhomeViewController") as!  tryhomeViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        fetch_categories_details()
        fetch_subcategory_details()
        //imgae_fun()
     
     //   print("hiii im piyush")
        url = URL(string: WEB_URL.ORDERINSER_URL)
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
    
    
    //for the fetch the category details
    func fetch_categories_details()
    {
        JSONFIED.pd_id.removeAll()
        JSONFIED.pd_name.removeAll()
        JSONFIED.pd_price.removeAll()
        JSONFIED.pd_detail.removeAll()
        JSONFIED.pd_code.removeAll()
        JSONFIED.pd_width.removeAll()
        JSONFIED.pd_weight.removeAll()
        JSONFIED.pd_height.removeAll()
        JSONFIED.pd_stone.removeAll()
        JSONFIED.pd_size.removeAll()
        JSONFIED.pd_metal.removeAll()
        JSONFIED.pd_image.removeAll()
        
        let url = URL(string:WEB_URL.DETAIL_URL + select_product)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["product"] as? NSArray
            {
                for index in 0...(adata["product"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let proIdJson = (object["product_id"]as! String)
                    JSONFIED.pd_id.append(proIdJson)
                    // print("product_id=\(proIdJson)")
                    
                    let proimageJson = (object["product_title"]as! String)
                    JSONFIED.pd_name.append(proimageJson)
                    // print("product_image=\(proimageJson)")
                    
                    let pronameJson = (object["product_image"]as! String)
                    JSONFIED.pd_image.append(pronameJson)
                    //print("product_image=\(pronameJson)")
                    
                    let propriceJson = (object["product_price"]as! String)
                    JSONFIED.pd_price.append(propriceJson)
                    //print("product_image=\(propriceJson)")
                    
                    let productdetailJson = (object["product_datails"]as! String)
                    JSONFIED.pd_detail.append(productdetailJson)
                    
                    let procodeJson = (object["product_code"]as! String)
                    JSONFIED.pd_code.append(procodeJson)
                    
                    let proweightJson = (object["product_weight"]as! String)
                    JSONFIED.pd_weight.append(proweightJson)
                    
                    let proheightJson = (object["height"]as! String)
                    JSONFIED.pd_height.append(proheightJson
                    )
                    
                    let prosizeJson = (object["size"]as! String)
                    JSONFIED.pd_size.append(prosizeJson
                    )
                    
                    let prwidthJson = (object["width"]as! String)
                    JSONFIED.pd_width.append(prwidthJson
                    )
                    
                    let prometalJson = (object["metal_id"]as! String)
                    JSONFIED.pd_metal.append(prometalJson
                    )
                    
                    let prostoneJson = (object["stones_id"]as! String)
                    JSONFIED.pd_stone.append(prostoneJson
                    )
                }
            }
        }
        catch
        {print("error=\(error)")
        }
        imgae_fun()
        name()
        
    }
    func imgae_fun()
    {
        
        
        
      if let imageURL = URL(string: JSONFIED.pd_image)
        {
            //print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.PimageView.image = image
                        }
                    }
            }
        }
        
    }
    func name()
    {
        self.PnameView.text = JSONFIED.pd_name
        self.Pdetailview.text = JSONFIED.pd_detail
        self.PweightView.text = JSONFIED.pd_weight
        self.PcodeView.text = JSONFIED.pd_code
        self.PsizeView.text = JSONFIED.pd_size
        self.PhightView.text = JSONFIED.pd_height
        self.PpriceView.text = JSONFIED.pd_price
        self.PmetalView.text = JSONFIED.pd_metal
        self.PwidthView.text = JSONFIED.pd_width
        self.PstoneView.text = JSONFIED.pd_stone
    }

    func fetch_subcategory_details() {
        let url = URL(string: WEB_URL.PRODUCTIMAGE_URL + select_product)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                print("arryJason=\(arrayJson)")
                
                JSONFIED.p_id.removeAll()
                JSONFIED.p_image.removeAll()
                
                for index in 0...(adata["subcategory"]?.count)! - 1
                {
                    
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let catIdJson = (object["productimage_id"]as! String)
                    JSONFIED.p_id.append(catIdJson)
                    
                    let catNameJson = (object["imagepath_url"]as! String)
                    JSONFIED.p_image.append(catNameJson)
                }
            }
        }
        catch
        {print("error=\(error)")
        }
        imageparth()
    }
    func imageparth()
    {
        if let ImageURL = URL(string: JSONFIED.p_image)
        {
            //print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: ImageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.PimagelView.image = image
                        }
                    }
            }
        }
    }
}
