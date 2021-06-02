//
//  Section4VC.swift
//  airbnb
//
//  Created by JB on 2021/06/03.
//

import UIKit

class Section4VC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    // MARK: - 프로퍼티
    struct InformStruct {
        var title1: String
        var title2: String
        var title3: String
        var title4: String
        var body1: String
        var body2: String
        var body3: String
        var body4: String
    }
    
    let inform: [InformStruct] = [
        InformStruct(title1: "게스트를 위한 정보", title2: "에어비앤비의 코로나19 대응 방안", title3: "예약 취소 옵션", title4: "도움말 센터", body1: "", body2: "보건 안전 관련 업데이트", body3: "취소 가능 대상 및 환불 범위 알아보기", body4: "필요한 도움받기"),
        InformStruct(title1: "기타", title2: "에어비앤비 뉴스룸", title3: "호스트 분들이 있기에 가능합니다", title4: "", body1: "", body2: "최근 발표한 사항", body3: "에어비앤비 여행에 관한 동영상", body4: "")
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
extension Section4VC: UICollectionViewDelegate {
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
extension Section4VC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Section4CollectionViewCell else { return UICollectionViewCell() }
        cell.body1.text = inform[indexPath.row].body1
        cell.body2.text = inform[indexPath.row].body2
        cell.body3.text = inform[indexPath.row].body3
        cell.body4.text = inform[indexPath.row].body4
        cell.title1.text = inform[indexPath.row].title1
        cell.title2.text = inform[indexPath.row].title2
        cell.title3.text = inform[indexPath.row].title3
        cell.title4.text = inform[indexPath.row].title4
        
        return cell
    }
    
}

// MARK: - Section1CollectionViewCell
class Section4CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var body1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var body2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var body3: UILabel!
    @IBOutlet weak var title4: UILabel!
    @IBOutlet weak var body4: UILabel!
    
}
