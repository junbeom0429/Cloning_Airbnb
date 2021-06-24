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
 
    
    //MARK: - 액션
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
//    @IBAction func mapViewPan(_ sender: UIPanGestureRecognizer) {
//
//        if sender.state == .began {
//            print("Map.state.began")
//
//        } else if sender.state == .changed {
//            print("Map.state.changed")
//            let translation = sender.translation(in: tableViewContainer)
//
//            self.tableViewContainer.frame = CGRect(x:tableViewContainer.frame.origin.x + translation.x, y:tableViewContainer.frame.origin.y + translation.y, width: self.tableViewContainer.frame.size.width, height: tableViewContainer.frame.size.height)
//
//            sender.setTranslation(CGPoint.zero, in: tableViewContainer)
//
//        } else if sender.state == .ended || sender.state == .cancelled {
//            print("Map.state.ended")
//        }
//    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let tableViewController = destination as? TableViewInMapViewController {
            tableViewInMapVC = tableViewController
            tableViewController.delegate = self
        }
    }
}

// MARK: - PanningDelegate
extension MapViewController: PanningDelegate {
    func printSomething(string: String) {
        print("\(string)")
    }
    
    func panning(sender: UIPanGestureRecognizer) {
        
    }
}

// MARK: - FloatingPanelControllerDelegate
extension MapViewController: FloatingPanelControllerDelegate {
    
    
    
    
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
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        case .full, .half:
            return 0.7
        default:
            return 0
        }
    }
    
    
}

class CustomPanelBehavior: FloatingPanelBehavior {
        // Modify your floating panel's interaction
    let springDecelerationRate = UIScrollView.DecelerationRate.fast.rawValue + 0.02
    let springResponseTime = 0.4
    func shouldProjectMomentum(_ fpc: FloatingPanelController,
                to proposedTargetPosition: FloatingPanelState) -> Bool {
        return true
    }

        // Activate the rubber-band effect on panel edges
    func allowsRubberBanding(for edge: UIRectEdge) -> Bool {
        return true
    }
        
        // Manage the projection of a pan gesture momentum
        func shouldProjectMomentum(_ fpc: FloatingPanelController,
                to proposedTargetPosition: FloatingPanelPosition) -> Bool {
        return true
    }
    
    
}
