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
    
    func tabbarAnimation(state: FloatingPanelState) {
        if state == FloatingPanelState.half {
            print("tabbarAnimation - to half")
            tabBarController?.tabBar.frame = CGRect(
            x: 0,
            y: tabYWhenShowing,
            width: tabbarWidth,
            height: tabbarHeight)
        } else if state == FloatingPanelState.tip {
            print("tabbarAnimation - to tip")
            tabBarController?.tabBar.frame = CGRect(
            x: 0,
            y: tabYWhenHiding,
            width: tabbarWidth,
            height: tabbarHeight)
        }
    }
    
    func tabbarAnimator(state: FloatingPanelState) {
        // 내가 원하는 건 현재 탭의 y값에서 오픈클로즈시 탭의 y값으로 애니메이션이 진행되는것
        // 지금 상황은 오픈클로즈시 탭의 y값에서 현재값으로 애니메이션 진행됨
        
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: [], animations: {
            self.tabbarAnimation(state: state)
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
        difference = initialPoint.y - currentPoint.y
        
        if currentTabPoint.y >= tabYWhenShowing && currentTabPoint.y <= tabYWhenHiding {
            switch currentTabPoint.y {
            case tabYWhenShowing:
                if calcPanGestureDirection() == .Up {
                    print("case tabYWhenShowing - \(fpc.panGestureRecognizer.translation(in: mainView).y)")
                    break
                } else {
                    moveFloatingPanel(difference: difference)
                }
            case tabYWhenHiding:
                if calcPanGestureDirection() == .Down {
                    print("case tabYWhenHiding - \(fpc.panGestureRecognizer.translation(in: mainView).y)")
                    break
                } else {
                    moveFloatingPanel(difference: difference)
                }
            default:
                moveFloatingPanel(difference: difference)
            }
        }
    }
    
    func floatingPanelWillEndDragging(_ fpc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        if isChangedState() == false {
            tabbarAnimator(state: fpc.state)
        }
    }
    
//    func floatingPanelDidEndDragging(_ fpc: FloatingPanelController, willAttract attract: Bool) {
//        let state = fpc.state
//
//        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: [], animations: {
//            self.tabbarAnimation(state: state)
//        }, completion: { end in
//            print("animation complete")
//        })
//    }
    
//    func floatingPanelWillBeginAttracting(_ fpc: FloatingPanelController, to state: FloatingPanelState) {
//        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: [], animations: {
//            self.tabbarAnimation(state: state)
//        }, completion: { end in
//            print("animation complete")
//        })
//
//    }
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
