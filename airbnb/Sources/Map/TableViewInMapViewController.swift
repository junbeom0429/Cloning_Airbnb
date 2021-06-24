//
//  TableViewInMapViewController.swift
//  airbnb
//
//  Created by JB on 2021/06/07.
//

import UIKit
import Kingfisher

protocol PanningDelegate: AnyObject {
    func panning(sender: UIPanGestureRecognizer)
    func printSomething(string: String)
}

class TableViewInMapViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    // MARK: - 프로퍼티
    weak var delegate: PanningDelegate?
    var items: [result] = []
    var numOfPages = Int()
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    var currentPosition: Position = .middle
    enum Position {
        case top
        case middle
        case bottom
    }
    
    // MARK: - 아웃렛
   
    @IBOutlet weak var tableViewPanel: UITableView!
    
    
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
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewInMapCell else { return UITableViewCell() }
        cell.configScrollView(num: numOfPages, items: items, indexPath: indexPath)
        cell.configLable(items: items, indexPath: indexPath)
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
    @IBOutlet weak var starRatingOutlet: UILabel!
    
    
    // MARK: - 함수
    func configScrollView(num: Int, items: [result], indexPath: IndexPath) {
        pageControlOutlet.numberOfPages = num
        scrollView.frame = CGRect(x: 0, y: 0, width: 414, height: 220)
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: 414 * CGFloat(num), height: 220)
        self.addSubview(scrollView)
        
        for i in 0..<numOfPages {
            let page = UIView()
            page.translatesAutoresizingMaskIntoConstraints = false
            page.backgroundColor = .systemGray6
            page.frame = CGRect(x: 414 * CGFloat(i), y: 0, width: 414, height: 220)
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.frame = page.bounds
            scrollView.addSubview(page)
            page.addSubview(imageView)
            let imageURL = URL(string: items[indexPath.row].hostImg[i].imgPath)
            imageView.kf.setImage(with: imageURL)
            
            imageView.layer.cornerRadius = 10
        }
    }
    
    func configLable(items: [result], indexPath: IndexPath) {
        
    }
}

extension TableViewInMapCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControlOutlet.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
