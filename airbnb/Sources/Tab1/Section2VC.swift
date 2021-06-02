//
//  Section2VC.swift
//  airbnb
//
//  Created by JB on 2021/06/03.
//

import UIKit

class Section2VC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    // MARK: - 프로퍼티
    struct ThemeStruct {
        var image: UIImage
        var title: String
    }
    let theme: [ThemeStruct] = [
        ThemeStruct(image: UIImage(named: "tap1Sec2Item3.png")!, title: "집전체"),
        ThemeStruct(image: UIImage(named: "tap1Sec2Item2.png")!, title: "독특한 공간"),
        ThemeStruct(image: UIImage(named: "tap1Sec2Item4.png")!, title: "반려동물 동반 가능")
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
extension Section2VC: UICollectionViewDelegate {
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
extension Section2VC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Section2CollectionViewCell else { return UICollectionViewCell() }
        cell.section2Image.image = theme[indexPath.row].image
        cell.section2Label.text = theme[indexPath.row].title
        
        return cell
    }
    
}

// MARK: - Section1CollectionViewCell
class Section2CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var section2Image: UIImageView!
    @IBOutlet weak var section2Label: UILabel!
    
}
