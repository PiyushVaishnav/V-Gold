//
//  detailViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 3/27/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class detailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var urlRequest: NSMutableURLRequest!
    var url: URL!
    var select_product = String()
    var select_productDetails = String()
    
    
    @IBAction func btnbuynow(_ sender: UIButton) {
        
        let tryhomer = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cartViewController")as! cartViewController
        
        select_productDetails = select_product
        
        tryhomer.select_productDetails = select_productDetails

        self.navigationController?.pushViewController(tryhomer , animated: true)
        
        
        
        
    }
    
    
    
    
    @IBAction func btntryhome(_ sender: UIButton) {
        
        
        let tryhomer = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tryhomeViewController")as! tryhomeViewController
        navigationController?.pushViewController(tryhomer , animated: true)
        
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch_categories_details()
    
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

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 434
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONFIED.pd_id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")as! detailCell
        cell.PnameView.text = JSONFIED.pd_name[indexPath.row]
        cell.PpriceView.text = JSONFIED.pd_price[indexPath.row]
        cell.Pdetailview.text = JSONFIED.pd_detail[indexPath.row]
        cell.PcodeView.text = JSONFIED.pd_code[indexPath.row]
        cell.PweightView.text = JSONFIED.pd_weight[indexPath.row]
        cell.PhightView.text =  JSONFIED.pd_height[indexPath.row]
        cell.PwidthView.text = JSONFIED.pd_width[indexPath.row]
        cell.PsizeView.text =  JSONFIED.pd_size[indexPath.row]
        cell.PmetalView.text = JSONFIED.pd_metal[indexPath.row]
        cell.PstoneView.text = JSONFIED.pd_stone[indexPath.row]
        
        if let imageURL = URL(string: JSONFIED.pd_image[indexPath.row])
        {
            print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.PimageView.image = image
                        }
                    }
            }
        }
        
        
        return cell
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
                    
                    let prwidthJson = (object["width"]as!		 String)
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
        

    }
    
}
