//
//  ChooseGuestVC.swift
//  airbnb
//
//  Created by JB on 2021/06/03.
//

import UIKit


class ChooseGuestVC: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        callAnimator()
    }
    // MARK: - 프로퍼티
    var adultNum = Int()
    var childNum = Int()
    var babyNum = Int()
    var guestNum: Int = 0 { didSet {
        SearchBtnActiveSwitch()
    }}
    var animator: UIViewPropertyAnimator?
    
    
    
    // MARK: - 아웃렛
    @IBOutlet weak var HeadSearchTextOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var guestNumOutlet: UILabel!
    
    @IBOutlet weak var adultNumOutlet: UILabel!
    @IBOutlet weak var adultMinusBtnOutelt: UIButton!
    
    @IBOutlet weak var childNumOutlet: UILabel!
    @IBOutlet weak var childMinusBtnOutlet: UIButton!
    
    @IBOutlet weak var badyNumOutlet: UILabel!
    @IBOutlet weak var badyMinusBtnOutlet: UIButton!
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var headerText: UITextField!
    
    
    // MARK: - 액션
    @IBAction func backBtn(_ sender: Any) {
        dateOutlet.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func adultMinus(_ sender: UIButton) {
        sender.pulsate()
        clickMinus(adultNumOutlet)
    }
    @IBAction func adultPlus(_ sender: UIButton) {
        sender.pulsate()
        clickPlus(adultNumOutlet)
    }
    
    @IBAction func childMinus(_ sender: UIButton) {
        sender.pulsate()
        clickMinus(childNumOutlet)
    }
    @IBAction func childPlus(_ sender: UIButton) {
        sender.pulsate()
        clickPlus(childNumOutlet)
    }
    
    @IBAction func badyMinus(_ sender: UIButton) {
        sender.pulsate()
        clickMinus(badyNumOutlet)
    }
    @IBAction func badyPlus(_ sender: UIButton) {
        sender.pulsate()
        clickPlus(badyNumOutlet)
    }
    
    @IBAction func searchBtnTouch(_ sender: UIButton) {
        Flag.fromSearch = true
        dismiss(animated: false) 
    
    }
    
    // MARK: - 함수
    func config() {
        searchBtn.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 20
        dateOutlet.text = "6월 \(SearchInform.startDay) ~ \(SearchInform.endDay)"
        HeadSearchTextOutlet.text = SearchInform.text
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func clickMinus(_ label: UILabel) {
        if label == adultNumOutlet {
            if adultNum == 1 {
                adultNum -= 1
                showNum(adultNumOutlet)
                showNum(guestNumOutlet)
                btnActiveSwitch(adultMinusBtnOutelt)
            } else {
                adultNum -= 1
                showNum(adultNumOutlet)
                showNum(guestNumOutlet)
            }
        } else if label == childNumOutlet {
            if childNum == 1 {
                childNum -= 1
                showNum(childNumOutlet)
                showNum(guestNumOutlet)
                btnActiveSwitch(childMinusBtnOutlet)
            } else {
                childNum -= 1
                showNum(childNumOutlet)
                showNum(guestNumOutlet)
            }
        } else if label == badyNumOutlet {
            if babyNum == 1 {
                babyNum -= 1
                showNum(badyNumOutlet)
                showNum(guestNumOutlet)
                btnActiveSwitch(badyMinusBtnOutlet)
            } else {
                babyNum -= 1
                showNum(badyNumOutlet)
                showNum(guestNumOutlet)
            }
        } else {
            print("clickMinus Error")
        }
    }
    
    func clickPlus(_ label: UILabel) {
        if label == adultNumOutlet {
            if adultNum == 0 {
                adultNum += 1
                showNum(adultNumOutlet)
                showNum(guestNumOutlet)
                btnActiveSwitch(adultMinusBtnOutelt)
            } else {
                adultNum += 1
                showNum(adultNumOutlet)
                showNum(guestNumOutlet)
            }
        } else if label == childNumOutlet {
            if childNum == 0 {
                childNum += 1
                showNum(childNumOutlet)
                showNum(guestNumOutlet)
                btnActiveSwitch(childMinusBtnOutlet)
            } else {
                childNum += 1
                showNum(childNumOutlet)
                showNum(guestNumOutlet)
            }
        } else if label == badyNumOutlet {
            if babyNum == 0 {
                babyNum += 1
                showNum(badyNumOutlet)
                showNum(guestNumOutlet)
                btnActiveSwitch(badyMinusBtnOutlet)
            } else {
                babyNum += 1
                showNum(badyNumOutlet)
                showNum(guestNumOutlet)
            }
        } else {
            print("clickPlus Error")
        }
    }
    
    func btnActiveSwitch(_ btn: UIButton) {
        if btn.isEnabled == true {
            btn.isEnabled = false
            btn.tintColor = .systemGray2
        } else {
            btn.isEnabled = true
            btn.tintColor = .darkGray
        }
    }
    
    func SearchBtnActiveSwitch() {
        if guestNum == 0 {
            searchBtn.isEnabled = false
            searchBtn.backgroundColor = .lightGray
        } else {
            searchBtn.isEnabled = true
            searchBtn.backgroundColor = .black
        }
    }
    
    func calcGuestNum() -> Int {
        guestNum = adultNum + childNum + babyNum
        return guestNum
    }
    
    func showNum(_ label: UILabel) {
        if label == guestNumOutlet {
            guestNumOutlet.text = "\(calcGuestNum()) 명의 게스트"
        } else if label == adultNumOutlet {
            adultNumOutlet.text = String(adultNum)
        } else if label == childNumOutlet {
            childNumOutlet.text = String(childNum)
        } else if label == badyNumOutlet {
            badyNumOutlet.text = String(babyNum)
        } else {
            print("showNum Error")
        }
    }
    
    func setSearchData() -> SearchRequest {
        let sD: String = "2021-06-\(SearchInform.startDay)"
        let eD: String = "2021-06-\(SearchInform.endDay)"
        let searchRequest = SearchRequest(state: SearchInform.text, startDate: sD, endDate: eD, guest: SearchInform.guest)
        return searchRequest
    }
    
    func goToMap() {
        let sb = UIStoryboard(name: "Map", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() as? MapViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    func addMapTab1Navi() {
        
    }

    func callAnimator() {
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: [], animations: {
            self.textMovingAnimation()
        }, completion: { end in
            
        })
    }
    
    func textMovingAnimation() {
        headerText.frame = CGRect(x: 25, y: 30, width: 204, height: headerText.frame.size.height)
        headerText.alpha = 1
    }
}
