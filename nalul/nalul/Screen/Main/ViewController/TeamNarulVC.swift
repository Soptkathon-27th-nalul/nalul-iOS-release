//
//  TeamNarulVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/13.
//

import UIKit

class TeamNarulVC: UIViewController {

    // MARK: Variable Part
    
    var clickEvent: Bool = false
    var memberImage: [String] = ["syImage","hjImage","saImage","jmImage","mhImage","sjImage"]
    var memberName: [String] = ["PM_정수연\n\n@instgram","PM_노희지\n\n@instgram","Designer_최선아\n\n@instgram","Designer_김재민\n\n@instgram","iOS_김민희\n\n@xdmini_","Server_이수진\n\n@instgram"]
    
    // MARK: IBOutlet
    
    @IBOutlet weak var planBox: UIView!
    @IBOutlet weak var designBox: UIView!
    @IBOutlet weak var developerBox: UIView!
    @IBOutlet weak var memberCollectionView: UICollectionView!
    @IBOutlet weak var clickButton: UIButton!
    
    @IBOutlet weak var collectionToButton: NSLayoutConstraint!
    @IBOutlet weak var buttonToLabel: NSLayoutConstraint!
    
    // MARK: IBAction
    
    @IBAction func clickButtonDidTap(_ sender: Any) {
        if clickEvent {
            clickEvent = false
        } else {
            clickEvent = true
        }
        memberCollectionView.reloadData()
    }
    
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        clickButton.makeRounded(cornerRadius: nil)
        if view.safeAreaInsets.bottom == 0.0 {
            collectionToButton.constant = 40
            buttonToLabel.constant = 30
        }
    }


}

// MARK: Extension

extension TeamNarulVC {
    
    // MARK: Function
    
    func setView() {
        
        planBox.backgroundColor = .none
        designBox.backgroundColor = .none
        developerBox.backgroundColor = .none
        
        planBox.setBorder(borderColor: .white, borderWidth: 1)
        designBox.setBorder(borderColor: .white, borderWidth: 1)
        developerBox.setBorder(borderColor: .white, borderWidth: 1)
        
        memberCollectionView.backgroundColor = .clear
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
    }
    
    func setButton() {
        
        clickButton.backgroundColor = .none
        clickButton.setTitle("눌러", for: .normal)
        clickButton.titleLabel?.font = UIFont.threeLight(size: 12)
        clickButton.tintColor = .white
        clickButton.setBorder(borderColor: .white, borderWidth: 1)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension TeamNarulVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 88, height: 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 위아래 간격
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 오른쪽 간격
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

// MARK: UICollectionViewDataSource

extension TeamNarulVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamNarulCell.identifier, for: indexPath) as? TeamNarulCell else {
            return UICollectionViewCell()
        }
        cell.configure(name: memberName[indexPath.row], image: memberImage[indexPath.row], click: clickEvent)
        return cell
    }
    
    
}
