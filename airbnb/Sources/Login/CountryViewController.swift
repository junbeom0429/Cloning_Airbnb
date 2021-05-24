//
//  EmailViewController.swift
//  airbnb
//
//  Created by JB on 2021/05/24.
//

import UIKit

class CountryViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryTableViewCell else { return UITableViewCell()}
        cell.CountryNameAndNum.text = "\(Constant.countryList.sorted(by: < )[indexPath.row].key) (+\(Constant.countryList.sorted(by: < )[indexPath.row].value))"
        
        return cell
    }
    
    
}

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var CountryNameAndNum: UILabel!
    
}
