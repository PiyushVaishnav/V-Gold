//
//  mapkitViewController.swift
//  gold
//
//  Created by Akash Padhiyar on 3/30/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit
import MapKit
class mapkitViewController: UIViewController {

    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocationCoordinate2D(latitude: 23.021694,
                                              longitude:  72.590030)
        
        // 2
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "V Gold Jewels"
        annotation.subtitle = "Ahmedabad,Gujarat"
        mapView.addAnnotation(annotation)
   
    }

   
}
