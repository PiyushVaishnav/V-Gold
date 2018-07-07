//
//  productViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 3/22/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class productViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var select_subcat_id = String()
    var select_product = String()
    
    
    @IBAction func ViewBack(_ sender: Any) {
        
    navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        

    fetch_categories_details()
    tableview.tableFooterView = UIView()
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let table = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailMV")as! DetailMV
        select_product = JSONFIED.pro_id[indexPath.row]
        
        table.select_product = select_product
        navigationController?.pushViewController(table , animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONFIED.pro_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productcell")as! productCell
        cell.titelview.text = JSONFIED.pro_name[indexPath.row]
        cell.rupesview.text = JSONFIED.pro_price[indexPath.row]
        
        //displya the image
        if let imageURL = URL(string:WEB_URL.PROIMAGE_URL + JSONFIED.pro_image[indexPath.row])
        {
            print("imagepath=\(imageURL)")
            print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.imageview.image = image
                        }
                    }
            }
        }
        return cell
    }
    
    //for the fetch the category details
    func fetch_categories_details()
    {
        JSONFIED.pro_id.removeAll()
        JSONFIED.pro_image.removeAll()
        JSONFIED.pro_price.removeAll()
        JSONFIED.pro_name.removeAll()
        
        let url = URL(string:WEB_URL.PRODUCT_URL + select_subcat_id)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["product"] as? NSArray
            {
                for index in 0...(adata["product"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let proIdJson = (object["product_id"]as! String)
                    JSONFIED.pro_id.append(proIdJson)
                   // print("product_id=\(proIdJson)")
                    
                    let proimageJson = (object["product_image"]as! String)
                    JSONFIED.pro_image.append(proimageJson)
                   // print("product_image=\(proimageJson)")
                    
                    let pronameJson = (object["product_title"]as! String)
                    JSONFIED.pro_name.append(pronameJson)
                    //print("product_image=\(pronameJson)")
                    
                    let propriceJson = (object["product_price"]as! String)
                    JSONFIED.pro_price.append(propriceJson)
                //print("product_image=\(propriceJson)")
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }


    
}
    

