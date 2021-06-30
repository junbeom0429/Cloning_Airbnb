//
//  MapViewController.swift
//  airbnb
//
//  Created by JB on 2021/06/05.
//

import UIKit
import GoogleMaps
import FloatingPanel

class MapViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        fpcConfig()
        googleMapConfig()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    //MARK: - 프로퍼티
    var fpc: FloatingPanelController!
    var tableViewInMapVC: TableViewInMapViewController!
    var mvc: MapViewController!
    
    
    //var tabvc: UITabBarController =
    
//    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
//
//    var currentPosition: Position = .middle
//    enum Position {
//        case top
//        case middle
//        case bottom
//    }
    
    //MARK: - 아웃렛
    @IBOutlet weak var filterBtnOutlet: UIButton!
    @IBOutlet weak var headerBarContainerOutlet: UIView!
    @IBOutlet var mainView: UIView!
    
    
    //MARK: - 액션
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - 함수
    func config() {
        filterBtnOutlet.layer.cornerRadius = 20
        headerBarContainerOutlet.layer.cornerRadius = 20
        
    }
    
    func fpcConfig() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        guard let contentVC = storyboard?.instantiateViewController(identifier: "contentVC") as? TableViewInMapViewController else {
            return }
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableViewPanel)
        fpc.addPanel(toParent: self)
        fpc.layout = MyFloatingPanelLayout()
        fpc.behavior = CustomPanelBehavior()
    }
    
    
    func googleMapConfig() {
        //Google Map
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
}

// MARK: - FloatingPanelControllerDelegate
extension MapViewController: FloatingPanelControllerDelegate {
    func floatingPanelWillBeginDragging(_ fpc: FloatingPanelController) {
        <#code#>
    }
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        var initialPoint: CGPoint = .zero
        var currentPoint: CGPoint = .zero
        var currentTabCGPoint: CGPoint = tabBarController!.tabBar.frame.origin
        print("currentTabCGPoint = \(currentTabCGPoint)")
        var difference: CGFloat = 0
        
        
        if fpc.state == FloatingPanelState.tip {
            if fpc.panGestureRecognizer.translation(in: mainView).y < 0 {
                
            }
        } else if fpc.state == FloatingPanelState.half {
            if fpc.panGestureRecognizer.state == .began {
                initialPoint = fpc.panGestureRecognizer.translation(in: mainView)
                currentTabCGPoint = tabBarController!.tabBar.frame.origin
                print("tabBarController.origin = \(currentPoint.x), \(currentPoint.y)")
                
            } else if fpc.panGestureRecognizer.state == .changed {
                currentPoint = fpc.panGestureRecognizer.translation(in: mainView)
                difference = initialPoint.y - currentPoint.y
                if currentPoint.y > 0 {
                    print("Draging Panel")
                    tabBarController?.tabBar.frame = CGRect(
                        x: 0,
                        y: currentTabCGPoint.y - difference / 4,
                        width: tabBarController!.tabBar.frame.width,
                        height: tabBarController!.tabBar.frame.height)
                    print("tabbar y = \(currentTabCGPoint.y - difference / 4)")
                    
                }
            }
        }
    }
}
    

// MARK: - class MyFloatingPanelLayout: FloatingPanelLayout
// Change the initial layout
class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
// MARK: - class CustomPanelBehavior: FloatingPanelBehavior
class CustomPanelBehavior: FloatingPanelBehavior {
    
    
}
