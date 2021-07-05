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
    var initialPoint: CGPoint = .zero
    var currentPoint: CGPoint = .zero
    var originTabY: CGFloat = 761
    var currentTabPoint: CGPoint = .zero
    var beforeState: FloatingPanelState = .half
    var currentState: FloatingPanelState = .half
    
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
    
    func calcResultY(dif: CGFloat) -> CGFloat {
        var resultY: CGFloat = 0
        var tabY: CGFloat = 0
        
        return resultY
    }
}

// MARK: - FloatingPanelControllerDelegate
extension MapViewController: FloatingPanelControllerDelegate {
    func floatingPanelWillBeginDragging(_ fpc: FloatingPanelController) {
        initialPoint = fpc.panGestureRecognizer.translation(in: mainView)
    }
    
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        var difference = CGFloat()
        currentTabPoint = tabBarController!.tabBar.frame.origin
        print("currentTabPoint.y : \(currentTabPoint.y)")
        
        if currentTabPoint.y >= originTabY && currentTabPoint.y <= 897 {
            if fpc.panGestureRecognizer.state == .changed {
                currentPoint = fpc.panGestureRecognizer.translation(in: mainView)
                difference = initialPoint.y - currentPoint.y
                
                tabBarController?.tabBar.frame = CGRect(
                    x: 0,
                    y: difference / 3.294,
                    width: tabBarController!.tabBar.frame.width,
                    height: tabBarController!.tabBar.frame.height)
            }
            
            
//            if fpc.state == FloatingPanelState.half && fpc.panGestureRecognizer.translation(in: mainView).y > 0 {
//                if fpc.panGestureRecognizer.state == .changed {
//                    currentPoint = fpc.panGestureRecognizer.translation(in: mainView)
//                    difference = initialPoint.y - currentPoint.y
//                    tabBarController?.tabBar.frame = CGRect(
//                        x: 0,
//                        y: currentTabPoint.y - difference / 4,
//                        width: tabBarController!.tabBar.frame.width,
//                        height: tabBarController!.tabBar.frame.height)
//
//                }
//            } else if fpc.state == FloatingPanelState.tip && fpc.panGestureRecognizer.translation(in: mainView).y < 0 {
//                if fpc.panGestureRecognizer.state == .changed {
//                    currentPoint = fpc.panGestureRecognizer.translation(in: mainView)
//                    difference = initialPoint.y - currentPoint.y
//                    tabBarController?.tabBar.frame = CGRect(
//                        x: 0,
//                        y: currentTabPoint.y - difference / 4,
//                        width: tabBarController!.tabBar.frame.width,
//                        height: tabBarController!.tabBar.frame.height)
//
//                }
//            }
            
        }
    }
    
 
    
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        beforeState = currentState
        currentState = fpc.state
        if currentState == FloatingPanelState.half {}
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
