//
//  Section3VC.swift
//  airbnb
//
//  Created by JB on 2021/06/03.
//

import UIKit

class Section3VC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    // MARK: - 프로퍼티
    struct ActivityStruct {
        var image: UIImage
        var title: String
        var body: String
    }
    
    let activity: [ActivityStruct] = [
        ActivityStruct(image: UIImage(named: "tap1Sec3Item1.png")!, title: "추천 컬렉션: 여행 본능을 깨우는 체험", body: "온라인 체험으로 집에서 랜선 여행을 즐기세요."),
        ActivityStruct(image: UIImage(named: "tap1Sec3Item2.png")!, title: "온라인 체험", body: "호스트와 실시간으로 소통하면서 액티비티를 즐겨보세요."),
        ActivityStruct(image: UIImage(named: "tap1Sec3Item3.png")!, title: "체험", body: "어디에서든 세계 각지의 매력을 만나실 수 있습니다.")
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
extension Section3VC: UICollectionViewDelegate {
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
extension Section3VC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Section3CollectionViewCell else { return UICollectionViewCell() }
        cell.image.image = activity[indexPath.row].image
        cell.title.text = activity[indexPath.row].title
        cell.body.text = activity[indexPath.row].body
        
        return cell
    }
    
}

// MARK: - Section1CollectionViewCell
class Section3CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
}
