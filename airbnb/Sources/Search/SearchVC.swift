//
//  Map.swift
//  airbnb
//
//  Created by JB on 2021/05/23.
//

import UIKit

class SearchVC: BaseViewController {
    override func viewDidLoad() {
        reset()
    }
    // MARK: - 프로퍼티
    var list: [String] = ["서울 특별시"]
    
    // MARK: - 아웃렛
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var naviContainer: UIView!
    
    // MARK: - 액션
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - 함수
    func config() {
        naviContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        naviContainer.layer.cornerRadius = 20
    }
    func reset() {
        SearchInform.text = ""
        SearchInform.startDay = -1
        SearchInform.endDay = -1
        SearchInform.guest = 0
        SearchInform.startDate = Date()
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("\(textField.text!)")
        SearchInform.text = textField.text!
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "goToType", sender: nil)
        return true
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //SearchInform.text = list[indexPath.row]
        performSegue(withIdentifier: "goToType", sender: nil)
        
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchListCell else { return UITableViewCell() }
        cell.fixImage.image = UIImage(named: "fixImage.png")
        cell.placeName.text = list[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}

class SearchListCell: UITableViewCell {
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var fixImage: UIImageView!
    
}
