//
//  MapViewController.swift
//  airbnb
//
//  Created by JB on 2021/06/05.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    //MARK: - 프로퍼티
    
    //MARK: - 아웃렛
    @IBOutlet weak var filterBtnOutlet: UIButton!
    @IBOutlet weak var headerBarContainerOutlet: UIView!
    
    //MARK: - 액션
    
    //MARK: - 함수
    func config() {
        filterBtnOutlet.layer.cornerRadius = 20
        headerBarContainerOutlet.layer.cornerRadius = 20
    }
}
