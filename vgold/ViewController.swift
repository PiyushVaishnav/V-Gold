//
//  ViewController.swift
//  vgold
//
//  Created by Akash Padhiyar on 3/19/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBAction func call(_ sender: UIBarButtonItem) {
        
        UIApplication.shared.openURL(NSURL(string: "Dialing://9998667186") as! URL)
        
    }
    
    
    var select_cat_id = String()
    
    @IBOutlet weak var scrollerView: UIScrollView!
    
    @IBOutlet weak var page: UIPageControl!
    
    @IBOutlet weak var MyCollection: UICollectionView!
    
    var img = [String]()
    var frame = CGRect(x:0, y:0, width:0, height:0)
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetch_slider_images()
        fetch_subcategory_details()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        MyCollection.deselectItem(at: indexPath, animated: true)
        let collection = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "subcatViewController")as! subcatViewController
        select_cat_id = JSONFIED.coll_cat_id[indexPath.row]
        
        collection.select_cat_id = select_cat_id
        navigationController?.pushViewController(collection, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JSONFIED.coll_cat_name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! CollectionCell
        
        cell.ViewCategory.text = JSONFIED.coll_cat_name[indexPath.row]
       
        //displya the image
        
        if let imageURL = URL(string:WEB_URL.IMAGE_URL + JSONFIED.coll_cat_image[indexPath.row])
        {
          //  print("imagepath=\(imageURL)")
           // print(imageURL)
            DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.ViewImage.image = image
                        }
                    }
            }
        }
        return cell
    }
    
    func fetch_subcategory_details() {
        let url = URL(string: WEB_URL.CATEGORY_URL
        )
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            if let arrayJson = adata["category"] as? NSArray
            {
                
                JSONFIED.coll_cat_id.removeAll()
                JSONFIED.coll_cat_image.removeAll()
                JSONFIED.coll_cat_name.removeAll()
                
                
                for index in 0...(adata["category"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    
                    let catIdJson = (object["category_id"]as! String)
                    JSONFIED.coll_cat_id.append(catIdJson)
                  //  print("category_id=\(catIdJson)")
                    
                    let catNameJson = (object["category_name"]as! String)
                    JSONFIED.coll_cat_name.append(catNameJson)
                    //print("category_id=\(catNameJson)")
                    
                    
                    let catImageJson = (object["category_image"]as! String)
                    JSONFIED.coll_cat_image.append(catImageJson)
                   // print("category_id=\(catImageJson)")
                    
                }
            }
        }
        catch
        {print("error=\(error)")
        }
    }
    // Scroller View Start ------------------------------------------------
    
    @objc func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollerView.frame.width
        let maxWidth:CGFloat = pageWidth * 6
        let contentOffset:CGFloat = self.scrollerView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        scrollViewDidEndDecelerating(scrollerView)
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollerView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollerView.frame.height), animated: true)
    }
    
    // For Image JSON Serialization
    func fetch_slider_images()
    {
        let url = URL(string: WEB_URL.SCROLL_URL)
        do{
            let allmydata = try Data(contentsOf: url!)
            let adata = try JSONSerialization.jsonObject(with: allmydata, options:JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
            
            
        if let arrayJson = adata["scroller"] as? NSArray
            {
                for index in 0...(adata["scroller"]?.count)! - 1
                {
                    let object = arrayJson[index]as! [String:AnyObject]
                    let arr_slider_id = (object["scroll_id"]as! String)
                    JSONFIED.arr_slider_id.append(arr_slider_id)
                    
                    let arr_slider_img = (object["scroll_image"]as! String)
                    JSONFIED.arr_slider_img.append(arr_slider_img)
                }
            }
        }
        catch{print(error)
        }
        self.slider_images()
    }
    
    // For Slider Images
    func slider_images()
    {
        page.currentPage = JSONFIED.arr_slider_img.count
        self.page.numberOfPages = JSONFIED.arr_slider_img.count
        
        for index in 0..<JSONFIED.arr_slider_img.count
        {
            frame.origin.x = scrollerView.frame.size.width * CGFloat(index)
            frame.size = scrollerView.frame.size
            imageView = UIImageView(frame: frame)
            
            let imgPath = WEB_URL.main_url + JSONFIED.arr_slider_img[index]
            //print("IMAGE_URL : \(imgPath)")
            if URL(string: JSONFIED.arr_slider_img[index]) != nil
            {
                let sliderUrl = URL(string: imgPath)
             //   print("SLIDER: \(sliderUrl)")
                
                if let data = NSData(contentsOf: sliderUrl!)
                {
                    if data != nil{
                        imageView.image = UIImage(data: data as Data)
                    }
                    else{
               //         print("Error in ImageView")
                    }
                }
            }
            self.scrollerView.addSubview(self.imageView)
        }
        self.scrollerView.contentSize = CGSize(width: (scrollerView.frame.size.width * CGFloat(JSONFIED.arr_slider_img.count)), height: scrollerView.frame.size.height)
        self.scrollerView.delegate = self
    }
    
    // For Page View
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        self.page.numberOfPages = JSONFIED.arr_slider_img.count
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+2
        self.page.currentPage = Int(currentPage);
    //    print(" Current Page: \(currentPage)")
     //   print("Tatal Page: \(JSONFIED.arr_slider_img.count)")
    }
}

