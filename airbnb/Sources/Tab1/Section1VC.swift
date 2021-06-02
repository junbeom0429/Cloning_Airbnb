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