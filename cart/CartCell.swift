//
//  CartCell.swift
//  gold
//
//  Created by Akash Padhiyar on 4/14/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var productView: UILabel!
    @IBOutlet weak var qtyView: UILabel!
    @IBOutlet weak var priceView: UILabel!
   
    @IBOutlet weak var removeqty: UIButton!
    @IBOutlet weak var addqty: UIButton!
    
    
    
    @IBAction func btnRemove(_ sender: UIButton) {
        if (self.qtyView.text == "1") {
            self.qtyView.text = String( 1)
            
        }else
        {
            let cur = Int(qtyView.text!)!
            self.qtyView.text = String(cur - 1)
            let str = self.qtyView.text!
            
            
        }
        
        
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        
          let  cur = Int(qtyView.text!)!
        self.qtyView.text = String(cur + 1)
        
        let str = self.qtyView.text!

    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    
}
