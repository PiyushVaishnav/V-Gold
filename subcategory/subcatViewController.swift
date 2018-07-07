//
//  subcatViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 3/21/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class subcatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var select_cat_id = String()
    var select_subcat_id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
fetch_subcategory_details()
        
        tableview.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let table = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "productViewController")as! productViewController
        select_subcat_id = JSONFIED.sub_subcat_id[indexPath.row]
        
        table.select_subcat_id = select_subcat_id
        navigationController?.pushViewController(table , animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JSONFIED.sub_subcat_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! subcatCell
        cell.subcategoryview.layer.cornerRadius = cell.subcategoryview.frame.height / 1
        
        cell.subcategoryview.text = JSONFIED.sub_subcat_name[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var tableview: UITableView!

    
    @IBAction func Goback(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func fetch_subcategory_details() {
        let url = URL(string: WEB_URL.SUBCATEGORY_URL + select_cat_id)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["subcategory"] as? NSArray
            {
                
                JSONFIED.sub_subcat_id.removeAll()
                JSONFIED.sub_subcat_name.removeAll()
                
                for index in 0...(adata["subcategory"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let catIdJson = (object["subcategory_id"]as! String)
                    JSONFIED.sub_subcat_id.append(catIdJson)
                    
                    let catNameJson = (object["subcategory_name"]as! String)
                    JSONFIED.sub_subcat_name.append(catNameJson)
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
    
}
