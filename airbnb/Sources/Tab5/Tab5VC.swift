//
//  Tab5VC.swift
//  airbnb
//
//  Created by JB on 2021/05/23.
//

import UIKit

protocol Tab5TableViewVCellDelegate {
    func didTapBtn(section: Int, row: Int, sender: UIButton)
}

class Tab5VC: BaseViewController {
    override func viewDidLoad() {
       config()
    }
    // MARK: - 프로퍼티
    let headerTitle = [
        "계정 관리",
        "호스팅",
        "법률"
    ]

    
    struct TableViewCellStruct {
        var title = String()
        var img = UIImage()
    }
    let accountSection: [TableViewCellStruct] = [
        TableViewCellStruct(title: "개인 정보", img: UIImage(named: "personalInform.png")!),
        TableViewCellStruct(title: "결제 및 대금 수령", img: UIImage(named: "payment.png")!),
        TableViewCellStruct(title: "알림", img: UIImage(named: "noti.png")!)
    ]
    let hostingSection: [TableViewCellStruct] = [
        TableViewCellStruct(title: "숙소 등록하기", img: UIImage(named: "hosting.png")!),
        TableViewCellStruct(title: "체험 호스팅하기", img: UIImage(named: "activityHosting.png")!)
    ]
    let legalSection: [TableViewCellStruct] = [
        TableViewCellStruct(title: "이용 약관", img: UIImage(named: "whiteBGImage.png")!),
        TableViewCellStruct(title: "로그아웃", img: UIImage(named: "whiteBGImage.png")!)
    ]
    
    // MARK: - 아웃렛
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    // MARK: - 액션
    @IBAction func profileTouch(_ sender: Any) {
        performSegue(withIdentifier: ProfileViewController.identifier, sender: nil)
    }
    
    // MARK: - 함수
    func config() {
        profileLabel.textColor = UIColor.mainEmerald
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        self.navigationController?.navigationBar.isTransparent = true
    }
}

// MARK: - UITableViewDelegate
extension Tab5VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Clicked")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 80
        }
        return 60
    }
}

// MARK: - UITableViewDataSource
extension Tab5VC: UITableViewDataSource {
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Tab5TableViewCell else {return UITableViewCell()}
        if indexPath.section == 0 {
            cell.cellTitle.text = accountSection[indexPath.row].title
            cell.cellImage.image = accountSection[indexPath.row].img
        } else if indexPath.section == 1 {
            cell.cellTitle.text = hostingSection[indexPath.row].title
            cell.cellImage.image = hostingSection[indexPath.row].img
        } else if indexPath.section == 2 {
            cell.cellTitle.text = legalSection[indexPath.row].title
            cell.cellImage.image = legalSection[indexPath.row].img
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            cell.cellTitle.textColor = UIColor.mainEmerald
        }
        cell.section = indexPath.section
        cell.row = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    // Header
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return accountSection.count
        } else if section == 1 {
            return hostingSection.count
        } else if section == 2 {
            return legalSection.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
}

// MARK: - Tab5TableViewCell
class Tab5TableViewCell: UITableViewCell {
    var section: Int = Int()
    var row: Int = Int()
    var delegate: Tab5TableViewVCellDelegate?
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellBtn: UIButton!
    
    @IBAction func cellBtnTouch(_ sender: UIButton) {
        delegate?.didTapBtn(section: section, row: row, sender: sender)
    }
    
}

extension Tab5VC: Tab5TableViewVCellDelegate {
    func didTapBtn(section: Int, row: Int, sender: UIButton) {
        print("section: \(section), row: \(row)")
        switch section {
        case 0:
            switch row {
            case 0:
                print("개인 정보")
                performSegue(withIdentifier: PersonalInformViewController.identifier, sender: nil)
            case 1:
                print("결제 및 대금 수령")
                performSegue(withIdentifier: PaymentViewController.identifier, sender: nil)
            case 2:
                print("알림")
                performSegue(withIdentifier: NotiViewController.identifier, sender: nil)
            default:
                print("row error")
            }
        case 1:
            switch row {
            case 0:
                print("숙소 등록하기")
            case 1:
                print("체험 호스팅하기")
            default:
                print("row error")
            }
        case 2:
            switch row {
            case 0:
                print("이용 약관")
            case 1:
                print("로그아웃")
            default:
                print("row error")
            }
        default:
            print("sec error")
        }
    }
}
