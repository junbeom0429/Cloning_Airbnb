//
//  ChooseTypeVC.swift
//  airbnb
//
//  Created by JB on 2021/06/03.
//

import UIKit

class ChooseTypeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // MARK: - 아웃렛
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var headSearchOutlet: UILabel!
    
    // MARK: - 액션
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 함수
    func config() {
        containerView.layer.cornerRadius = 20
        headSearchOutlet.text = SearchInform.text
    }

}
