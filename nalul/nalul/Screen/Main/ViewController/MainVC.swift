//
//  MainViewController.swift
//  nalul
//
//  Created by 김민희 on 2021/03/24.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: Variable Part
    
    var partNameArray: [String] = ["left\neye","left\nhand","mole","right\nhand","ear","lips","cheek","right\neye","nose"]
    var shuffleData: [String]?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var userBackImageView: UIImageView!
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var todayQuestionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var homeAlbumCollectionView: UICollectionView!
    
    @IBOutlet weak var shakeButton: UIButton!
    
    @IBOutlet weak var middleSubView: UIView!
    
    @IBOutlet weak var subPopUpView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var explainLabel: UILabel!
    
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    @IBOutlet weak var constraintToTop: NSLayoutConstraint!
    
    // MARK: IBAction
    
    @IBAction func settingButtonDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Setting", bundle: nil)
        guard let settingView = storyboard.instantiateViewController(identifier: "SettingListVC") as? SettingListVC else {
            return
        }
        self.navigationController?.pushViewController(settingView, animated: true)
        
    }
    
    @IBAction func shuffleButtonDidTap(_ sender: Any) {
        // 섞어 버튼 클릭 시 Event
        
        if let jwt = UserDefaults.standard.string(forKey: "accessToken") {
            
            APIService.shared.shuffle(jwt) { [self] result in
                switch result {
                case .success(let data):
                    // 셔플 성공
                    
                    shuffleData = data.toArray()
                    UserDefaults.standard.setValue(shuffleData, forKey: "MainShuffleData")
                    // 배열로 데이터 받아오기
                    homeAlbumCollectionView.reloadData()
                    
                case .failure(let error):
                    
                    if error == 400 {
                        // 사진이 하나도 없을 때
                        UserDefaults.standard.removeObject(forKey: "MainShuffleData")
                        homeAlbumCollectionView.reloadData()
                        setExplainLabel()
                    } else {
                        
                        print("데이터 오류")
                        
                    }
                }
            }
        } else {
            // 토큰이 만료되었거나 없는 것
            
            print("앱 다시 실행해주세요 하고 다시 켜기")
        }
        
    }
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        // 엑스 버튼 클릭 시 플로팅 팝업 제거
        
        self.closeButton.isSelected = false
        self.closeButton.isHidden = true
        
        let transition = CATransition()
        transition.duration = 1
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromBottom
        subPopUpView.layer.add(transition, forKey: CATransitionType.push.rawValue)
        self.subPopUpView.isHidden = true
        // 밑으로 떨어지는 효과와 함께 플로팅 팝업 숨기기
        
    }
    
    
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLabel()
        setButton()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillLayoutSubviews() {
        shakeButton.makeRounded(cornerRadius: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 배경화면 설정
        
        let uniqueFileName: String = "UserBackgroundImage"
        if let image = ImageFileManager.shared.getSavedImage(named: uniqueFileName) {
            userBackImageView.image = image
        } else {
            userBackImageView.image = UIImage(named: "testBlackImage")
        }
        
        shuffleButtonDidTap(self)
    }
    
}

// MARK: Extension

extension MainVC {
    
    // MARK: View Style Function
    
    func setView() {
        // 뷰 관련 Style 설정
        
        subPopUpView.backgroundColor = .nalulDarkGray
        subPopUpView.alpha = 0.6
        subPopUpView.setRounded(radius: 32.5)
        
        homeAlbumCollectionView.delegate = self
        homeAlbumCollectionView.dataSource = self
        homeAlbumCollectionView.backgroundColor = .none
        
        if !UIScreen.main.hasNotch {
            // 노치가 없으면 간격 줄여주기
            constraintToBottom.constant = 20
            constraintToTop.constant = 20
        }
    }
    
    // MARK: Label Style Function
    
    func setLabel() {
        // Label 관련 Style 설정
        
        todayQuestionLabel.numberOfLines = 0
        todayQuestionLabel.text = "nalul\n오늘은 어떤 부분을 기록하고 싶으세요?"
        todayQuestionLabel.font = UIFont.threeLight(size: 14)
        todayQuestionLabel.textColor = .white
        
        if let text = todayQuestionLabel.text {
            // 첫째줄만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.threeLight(size: 12), range: (text as NSString).range(of: "nalul"))
            
            todayQuestionLabel.attributedText = attributedStr
        }
        
        todayQuestionLabel.lineSetting(kernValue: 0, lineSpacing: 14)
        
        dateLabel.text = Date().mainDatePickerToString()
        dateLabel.font = UIFont.twoExLight(size: 11)
        dateLabel.textColor = .white
        setExplainLabel()
        
    }
    
    // MARK: Button Style Function
    
    func setButton() {
        // Button 관련 Style 설정
        
        settingButton.setImage(UIImage(named: "btnSettings"), for: .normal)
        settingButton.tintColor = .white
        
        shakeButton.setBorder(borderColor: .white, borderWidth: 1)
        shakeButton.backgroundColor = .none
        shakeButton.setTitle("섞어", for: .normal)
        shakeButton.tintColor = .white
        
    }
    
    func setExplainLabel() {
        
        explainLabel.numberOfLines = 0
        explainLabel.font = UIFont.threeLight(size: 14)
        explainLabel.textColor = .white
        
        explainLabel.text = "각 부위를 눌러 사진을 추가해보세요.\n당신의 부분들을 랜덤으로 모아서 보여드려요."
        if let text = explainLabel.text {
            // 두번째줄만 폰트를 다르게 설정
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.twoExLight(size: 11), range: (text as NSString).range(of: "당신의 부분들을 랜덤으로 모아서 보여드려요."))
            
            explainLabel.attributedText = attributedStr
        }
        
        explainLabel.lineSetting(kernValue: 0, lineSpacing: 12)
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: (collectionView.frame.width-10)/3, height: (collectionView.frame.width-10)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 위아래 간격
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 오른쪽 간격
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
}

extension MainVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAlbumCell.identifier, for: indexPath) as? MainAlbumCell else {
            return UICollectionViewCell()
        }
        
        if let data = UserDefaults.standard.stringArray(forKey: "MainShuffleData") {
            
            if data[indexPath.row] != "" {
                cell.setimage(imageURL: data[indexPath.row])
            } else {
                cell.configure(name: partNameArray[indexPath.row])
                cell.userImage.image = nil
            }
        } else {
            cell.configure(name: partNameArray[indexPath.row])
            cell.userImage.image = nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell 클릭 시
        
        let storyboard = UIStoryboard.init(name: "Gallery", bundle: nil)
        guard let galleryTab = storyboard.instantiateViewController(identifier: "GalleryListVC") as? GalleryListVC else {
            return
        }
        
        let titleNameArray: [String] = ["왼쪽 눈","왼쪽 손","점","오른쪽 손","귀","입술","볼","오른쪽 눈","코"]
        
        galleryTab.titleName = titleNameArray[indexPath.row]
        galleryTab.indexs = indexPath.row + 1
        
        self.navigationController?.pushViewController(galleryTab, animated: true)
        // 갤러리로 이동
        
    }
    
    
}
