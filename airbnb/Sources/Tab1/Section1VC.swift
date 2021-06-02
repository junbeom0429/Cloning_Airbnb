//
//  Section1VC.swift
//  airbnb
//
//  Created by JB on 2021/06/02.
//

import UIKit

class Section1VC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    // MARK: - 프로퍼티
    struct CityStruct {
        var city1Image: UIImage
        var city2Image: UIImage
        var city1Name: String
        var city2Name: String
        var city1Hour: String
        var city2Hour: String
    }
    let cityInform: [CityStruct] = [
        CityStruct(city1Image: UIImage(named: "city1.png")!, city2Image: UIImage(named: "city2.png")!, city1Name: "서울", city2Name: "수원시", city1Hour: "차로 1시간 거리", city2Hour: "차로 30분 거리"),
        CityStruct(city1Image: UIImage(named: "city3.png")!, city2Image: UIImage(named: "city4.png")!, city1Name: "인천", city2Name: "의정부시", city1Hour: "차로 1시간 거리", city2Hour: "차로 1시간 거리"),
        CityStruct(city1Image: UIImage(named: "city5.png")!, city2Image: UIImage(named: "city6.png")!, city1Name: "대전", city2Name: "대구", city1Hour: "차로 2시간 거리", city2Hour: "차로 3시간 거리")
    ]
    
    // MARK: - 아웃렛
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - 액션
    
    
    // MARK: - 함수
    func config() {
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
    }
    
}
// MARK: - UICollectionViewDelegate
extension Section1VC: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
            let index: Int
            if velocity.x > 0 {
                index = Int(ceil(estimatedIndex))
            } else if velocity.x < 0 {
                index = Int(floor(estimatedIndex))
            } else {
                index = Int(round(estimatedIndex))
            }
            
            targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
        }
}

// MARK: - UICollectionViewDataSource
extension Section1VC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Section1CollectionViewCell else { return UICollectionViewCell() }
        cell.city1Image.image = cityInform[indexPath.row].city1Image
        cell.city1Name.text = cityInform[indexPath.row].city1Name
        cell.city1Hour.text = cityInform[indexPath.row].city1Hour
        
        cell.city2Image.image = cityInform[indexPath.row].city2Image
        cell.city2Name.text = cityInform[indexPath.row].city2Name
        cell.city2Hour.text = cityInform[indexPath.row].city2Hour
        
        return cell
    }
    
}

// MARK: - Section1CollectionViewCell
class Section1CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var city1Image: UIImageView!
    @IBOutlet weak var city2Image: UIImageView!
    
    @IBOutlet weak var city1Name: UILabel!
    @IBOutlet weak var city1Hour: UILabel!
    
    @IBOutlet weak var city2Name: UILabel!
    @IBOutlet weak var city2Hour: UILabel!
    
}
