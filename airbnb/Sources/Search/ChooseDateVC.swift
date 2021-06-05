//
//  ChooseDateVC.swift
//  airbnb
//
//  Created by JB on 2021/06/03.
//

import UIKit

class ChooseDateVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    // MARK: - 프로퍼티
    var dayCount = 1
    var subDayCount = 1
    var isStartExsited = false
    var isEndExsited = false
    var isitFirst = true
    
    var monthMaxDay = 30
    
    var startDay: Int = -1
    var endDay: Int = -1
    
    var startDayIndex: IndexPath = IndexPath(item: 0, section: 0)
    var endDayIndex: IndexPath = IndexPath(item: 0, section: 0)
    
    // MARK: - 아웃렛
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var startDayOutlet: UILabel!
    @IBOutlet weak var EndDayOutlet: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var headSearchOutlet: UILabel!
    
    // MARK: - 액션
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 함수
    func config() {
        containerView.layer.cornerRadius = 20
        nextBtn.layer.cornerRadius = 10
        headSearchOutlet.text = SearchInform.text
    }
    
    // 셀 초기 컨피그
    func initConfigCell(index: IndexPath, startPosition: Int, cell: CalendarCollectionViewCell) {
        let dC = dayCount
        
        let num = dC - (startPosition - 1)
        if num <= 0 {
            cell.day.isHidden = true
//            cell.day.isUserInteractionEnabled = false
        } else if num >= 31 {
            cell.day.isHidden = true
//            cell.day.isUserInteractionEnabled = false
        } else {
            cell.day.text = "\(num)"
        }
        cell.dayValue = num
        cell.dayIndex = index
        dayCount += 1
        
        if dayCount == 36 {
            isitFirst = false
            print("isitFirst == false")
        }
    }
    
    // 셀 상태 변경
    func changeCellState(dayIndex: IndexPath) {
        let dayValue = makeCell(dayIndex).dayValue
        if isStartExsited == true && isEndExsited == true {
            reset()
        } else if isStartExsited == true {
            if dayValue > 0 && dayValue < startDay {
                let tempDayIndex = dayIndex
                let tempDayValue = dayValue
                reset()
                addStart(index: tempDayIndex, day: tempDayValue)
            } else if dayValue == startDay {
                print("same Day")
            } else if dayValue <= 0 {
                print("dayValue: \(dayValue)")
            } else if dayValue > monthMaxDay {
                print("dayValue: \(dayValue)")
            } else {
                addEnd(index: dayIndex,day: dayValue)
                addBetween()
                btnActiveSwitch()
            }
        } else if isStartExsited == false {
            if dayValue <= 0 {
                print("dayValue: \(dayValue)")
            } else if dayValue > monthMaxDay {
                print("dayValue: \(dayValue)")
            } else {
                addStart(index: dayIndex, day:  dayValue)
            }
            
        }
    }
    
    // 초기값으로 변경
    func reset() {
        // 각 셀 초기화
        var indexArr: [IndexPath] = []
        if isEndExsited == false {
            let index = startDayIndex
            makeCell(index).bottomLine.isHidden = true
            makeCell(index).isStart = false
            makeCell(index).isEnd = false
            makeCell(index).isBetween = false
            makeCell(index).changeCell()
            indexArr.append(index)
            print("reset - isisEndExsited: false")
        } else {
            let startSection = startDayIndex.section
            let endSection = endDayIndex.section
            var index = IndexPath(item: Int(), section: Int())
            for i in startSection...endSection {
                for j in 0...6 {
                    index = IndexPath(item: j, section: i)
                    makeCell(index).bottomLine.isHidden = true
                    makeCell(index).isStart = false
                    makeCell(index).isEnd = false
                    makeCell(index).isBetween = false
                    makeCell(index).changeCell()
                    indexArr.append(index)
                }
            }
            print("reset - isisEndExsited: true")
        }
        
        // 전역변수 초기화
        startDay = -1
        endDay = -1
        dayCount = 1
        subDayCount = 1
        isEndExsited = false
        isStartExsited = false
        startDayIndex = IndexPath(item: 0, section: 0)
        endDayIndex = IndexPath(item: 0, section: 0)
        giveEndDayToLabel()
        giveStartDayToLabel()
        btnActiveSwitch()
    }
    
    func addStart(index: IndexPath, day: Int) {
        makeCell(index).isStart = true
        makeCell(index).isEnd = false
        startDayIndex = index
        isStartExsited = true
        startDay = day
        SearchInform.startDay = day
        subDayCount = startDay
        makeCell(index).changeCell()
        giveStartDayToLabel()
        print("addStart: \(index), \(day)")
    }
    func addEnd(index: IndexPath, day: Int) {
        makeCell(index).isStart = false
        makeCell(index).isEnd = true
        endDayIndex = index
        isEndExsited = true
        endDay = day
        SearchInform.endDay = day
        makeCell(index).changeCell()
        giveEndDayToLabel()
        print("addEnd: \(index), \(day)")
    }
    func addBetween() {
        let startItem = startDayIndex.item
        let startSection = startDayIndex.section
        let endItem = endDayIndex.item
        let endSection = endDayIndex.section
        var indexArr: [IndexPath] = []
        
        for i in startSection...endSection {
            if startSection == endSection {
                for m in startItem...endItem {
                    let index = IndexPath(item: m, section: i)
                    makeCell(index).isBetween = true
                    makeCell(index).changeCell()
                    indexArr.append(index)
                    print("addBetween: \(index)")
                }
            } else if i == startSection {
                for j in startItem...6 {
                    let index = IndexPath(item: j, section: i)
                    makeCell(index).isBetween = true
                    makeCell(index).changeCell()
                    indexArr.append(index)
                    print("addBetween: \(index)")
                }
            } else if i == endSection {
                for k in 0...endItem {
                    let index = IndexPath(item: k, section: i)
                    makeCell(index).isBetween = true
                    makeCell(index).changeCell()
                    indexArr.append(index)
                    print("addBetween: \(index)")
                }
            } else {
                for l in 0...6 {
                    let index = IndexPath(item: l, section: i)
                    makeCell(index).isBetween = true
                    makeCell(index).changeCell()
                    indexArr.append(index)
                    print("addBetween: \(index)")
                }
            }
//            collectionView.performBatchUpdates {
//                self.collectionView?.reloadItems(at: indexArr)
//            } completion: { _ in
//                indexArr = []
//            }
        }
    }
    
    func makeCell(_ index: IndexPath) -> CalendarCollectionViewCell {
        let cell = collectionView.cellForItem(at: index) as! CalendarCollectionViewCell
        return cell
    }
    
    func giveStartDayToLabel() {
        if startDay <= 0 {
            startDayOutlet.text = ""
        } else {
            startDayOutlet.text = String(startDay)
        }
    }
    func giveEndDayToLabel() {
        if endDay <= 0 {
            EndDayOutlet.text = ""
        } else {
            EndDayOutlet.text = String(endDay)
        }
    }
    func btnActiveSwitch() {
        if startDay == -1 || endDay == -1 {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .lightGray
        } else {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = .black
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ChooseDateVC: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt - sec:\(indexPath.section), item:\(indexPath.item)")
        
        changeCellState(dayIndex: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension ChooseDateVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 5 {
            return 4
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CalendarCollectionViewCell else {return UICollectionViewCell()}
        if isitFirst == true {
            initConfigCell(index: indexPath, startPosition: 3, cell: cell)
        } else if isitFirst == false {
            changeCellState(dayIndex: indexPath)
            print("cellForItemAt: isitFirst == false -> call changeCellState")
        }
        return cell
    }
    
    
}

// MARK: - CalenderCollectionViewCell
class CalendarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var bottomLine: UIView!
    
    var isStart = false
    var isEnd = false
    var isBetween = false
    
    var dayValue = Int()
    var dayIndex = IndexPath()
    
    // 상태에 따라 외형 변경
    func changeCell() {
        if isEnd == true || isBetween == true || isStart == true {
            bottomLine.isHidden = false
        } else {
            bottomLine.isHidden = true
        }
        
        print("changeCell")
    }
}
