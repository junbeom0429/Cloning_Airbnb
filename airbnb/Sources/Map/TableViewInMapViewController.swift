//
//  TableViewInMapViewController.swift
//  airbnb
//
//  Created by JB on 2021/06/07.
//

import UIKit
import Kingfisher

class TableViewInMapViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
    }
    // MARK: - 프로퍼티
    var items: [result] = []
//    result(idx: String(), hostName: String(), hostImg: [hosting](), hostType: String(), state: String(), avaliableReservation: String(), price: String(), hostGuestCnt: String(), registerDate: String(), rating: String(), ReviewCnt: String())
    var numOfPages = Int()
    
    
    // MARK: - 아웃렛

    
    // MARK: - 액션
    
    // MARK: - 함수
    func config() {
        
    }
    
}
extension TableViewInMapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
}

extension TableViewInMapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewInMapCell else { return UITableViewCell() }
        cell.configScrollView(num: numOfPages)
        for i in 0..<numOfPages {
            let page = UIView()
            page.translatesAutoresizingMaskIntoConstraints = false
            page.backgroundColor = .systemGray6
            page.frame = CGRect(x: 414 * CGFloat(i), y: 0, width: 414, height: 220)
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.frame = page.bounds
            cell.scrollView.addSubview(page)
            page.addSubview(imageView)
            let imageURL = URL(string: items[indexPath.row].hostImg[i].imgPath)
            imageView.kf.setImage(with: imageURL)
            
            imageView.layer.cornerRadius = 10
        }
        return cell
    }
    
    
}

class TableViewInMapCell: UITableViewCell {
    // MARK: - 프로퍼티
    var numOfPages = 0
    let scrollView = UIScrollView()
    
    // MARK: - 아웃렛
    @IBOutlet weak var pageControlOutlet: UIPageControl!
    @IBOutlet weak var typeAndRegionOutlet: UILabel!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var priceOutlet: UILabel!
    @IBOutlet weak var totalPriceOutlet: UILabel!

    
    // MARK: - 함수
    func configScrollView(num: Int) {
        scrollView.frame = CGRect(x: 0, y: 0, width: 414, height: 220)
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: 414 * CGFloat(num), height: 220)
        self.addSubview(scrollView)
    }
}

extension TableViewInMapCell: UIScrollViewDelegate {
    
}
