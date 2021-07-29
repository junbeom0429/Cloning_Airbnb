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
    let tabYWhenShowing: CGFloat = 761
    let tabYWhenHiding: CGFloat = 841
    let tabbarHeight: CGFloat = 83
    let tabbarWidth: CGFloat = 390
    var currentTabPoint: CGPoint = .zero
    var animator: UIViewPropertyAnimator?
    
    var initialTapPointY: CGFloat = 0
    
    var initialSurfaceLocationY: CGFloat = 0
    var currentSurfaceLocationY: CGFloat = 0
    
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
        var temp: CGFloat = 0
        
        if fpc.state == FloatingPanelState.half {
            tabY = tabYWhenShowing
        } else if fpc.state == FloatingPanelState.tip {
            tabY = tabYWhenHiding
        }
        
        temp = tabY - (dif / 1.65)
        
        if temp < tabYWhenShowing {
            resultY = tabYWhenShowing
        } else if temp > tabYWhenHiding {
            resultY = tabYWhenHiding
        } else {
            resultY = temp
        }
        
        return resultY
    }
    
    func tabbarAnimation() {
        tabBarController?.tabBar.frame = CGRect(
            x: 0,
            y: calcY(),
            width: tabBarController!.tabBar.frame.width,
            height: tabBarController!.tabBar.frame.height)
        loadViewIfNeeded()
    }
    
    func tabbarAnimator() {
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.01, delay: 0, options: [], animations: {
            self.tabbarAnimation()
        }, completion: { end in
            print("animation complete")
        })
    }
    
    func isChangedState() -> Bool {
        return fpc.state == fpc.nearbyState ? false : true
    }
    
    func moveFloatingPanel(difference: CGFloat) {
        currentPoint = fpc.panGestureRecognizer.translation(in: mainView)
        tabBarController?.tabBar.frame = CGRect(
            x: 0,
            y: calcResultY(dif: difference),
            width: tabBarController!.tabBar.frame.width,
            height: tabBarController!.tabBar.frame.height)
    }
    
    func calcPanGestureDirection() -> Direction {
        let velocity = fpc.panGestureRecognizer.velocity(in: mainView).y
        switch velocity {
        case velocity where velocity < 0:
            return .Up
        case velocity where velocity > 0:
            return .Down
        default:
            return .zero
        }
    }
    
    func calcY() -> CGFloat {
        var result: CGFloat = 0
        if initialSurfaceLocationY < 404 {
            result = tabYWhenShowing
            return result
        } else {
            let dif = currentSurfaceLocationY - initialSurfaceLocationY
            result = initialTapPointY + (dif / 3.9125)
            if result > tabYWhenHiding {
                result = tabYWhenHiding
            } else if result < tabYWhenShowing {
                result = tabYWhenShowing
            }
            return result
        }
    }
}

// MARK: - FloatingPanelControllerDelegate
extension MapViewController: FloatingPanelControllerDelegate {
    func floatingPanelWillBeginDragging(_ fpc: FloatingPanelController) {
        initialTapPointY = tabBarController!.tabBar.frame.origin.y
        initialSurfaceLocationY = fpc.surfaceLocation.y
        
    }
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        currentTabPoint = tabBarController!.tabBar.frame.origin
        currentSurfaceLocationY = fpc.surfaceLocation.y
        
        print("currentTabPoint.y : \(currentTabPoint.y)")
        print("surfaceLocation : \(fpc.surfaceLocation)")
        print("calcY : \(calcY())")
        
        
        tabBarController?.tabBar.frame = CGRect(
            x: 0,
            y: calcY(),
            width: tabBarController!.tabBar.frame.width,
            height: tabBarController!.tabBar.frame.height)
        loadViewIfNeeded()
        
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
