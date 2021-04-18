//
//  PopUpVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/27.
//

import UIKit

class PopUpVC: UIViewController {
    
    // MARK: Variable Part
    
    var questionMent: String?
    var explainMent: String?
    let yesButton = UIButton()
    let noButton = UIButton()
    var moment: Bool?
    var deleteIndex: Int?
    var simpleData: SimpleData?
    
    
    // MARK: IBOutlet
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var mentLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    // MARK: IBAction
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setView()
        setLabel()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        
        // 버튼 둥글게
        yesButton.layer.cornerRadius = self.buttonView.frame.height/2
        noButton.layer.cornerRadius = self.buttonView.frame.height/2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뒷 배경 클릭 시 Event
        
        super.touchesBegan(touches, with: event)
        if let touch = touches.first , touch.view == self.view {
            if moment == true {
                
                postYesButtonDidTap()
                // '그래' 버튼을 누른 것과 동일하게 작동
                
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
            
        }
    }
    
}

// MARK: Extension

extension PopUpVC {
    
    // MARK: View Style Function
    
    func setView() {
        
        self.popUpView.backgroundColor = .nalulBlack
        self.popUpView.backgroundColor?.withAlphaComponent(0.8)
        self.popUpView.setRounded(radius: 32.5)
        self.popUpView.setBorder(borderColor: .nalulLightGray, borderWidth: 1)
        
        buttonView.backgroundColor = .clear
        
    }
    
    // MARK: Label Style Function
    
    func setLabel() {
        
        if let question = questionMent,
           let explain = explainMent {
            mentLabel.numberOfLines = 0
            mentLabel.text = "\(question)\n\(explain)"
            mentLabel.textColor = .white
            mentLabel.font = .threeLight(size: 14)
            
            if let text = mentLabel.text {
                // 두번째줄만 style을 다르게 설정하기
                
                let attributedStr = NSMutableAttributedString(string: text)
                attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.twoExLight(size: 11), range: (text as NSString).range(of: explain))
                // 폰트 수정
                attributedStr.addAttribute(.foregroundColor, value: UIColor(white: 1.0, alpha: 0.6), range: (text as NSString).range(of: explain))
                // label 컬러에 불투명도 값 주기
                
                mentLabel.attributedText = attributedStr
            }
            
            mentLabel.lineSetting(kernValue: 0, lineSpacing: 12)
        }
        
        
    }
    
    // MARK: Make One Button Function
    
    func setOneButton() {
        
        yesButton.setTitle("그래", for: .normal)
        yesButton.titleLabel?.font = .threeLight(size: 12)
        yesButton.setTitleColor(.white, for: .normal)
        yesButton.backgroundColor = .gray
        yesButton.addTarget(self, action: #selector(postYesButtonDidTap), for: .touchUpInside)
        
        self.buttonView.addSubview(yesButton)
        
        // 레이아웃을 수동으로 주고싶을 때 호출하는 인스턴스
        // true 일 때는 자동으로 레이아웃을 주는데 false로 지정하면서 내가 원하는대로 레이아웃을 줄 수 있게 함
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        
        yesButton.centerXAnchor.constraint(equalTo: self.buttonView.centerXAnchor).isActive = true
        // 가운데 정렬
        yesButton.widthAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        yesButton.heightAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        // Button의 넓이와 높이 주기
        
        moment = true
        
    }
    
    @objc func postYesButtonDidTap() {
        self.dismiss(animated: true)
        NotificationCenter.default.post(name: .popNavi, object: nil)
        // Observer 보내기
    }
    
    // MARK: Make Two Button Function
    
    func setTwoButton() {
        
        // 첫번재 버튼
        noButton.setTitle("아니", for: .normal)
        noButton.titleLabel?.font = .threeLight(size: 12)
        noButton.setTitleColor(.white, for: .normal)
        noButton.backgroundColor = .gray
        noButton.addTarget(self, action: #selector(noButtonDidTap), for: .touchUpInside)
        
        self.buttonView.addSubview(noButton)
        
        noButton.translatesAutoresizingMaskIntoConstraints = false
        
        noButton.centerXAnchor.constraint(equalTo: self.buttonView.centerXAnchor, constant: -48).isActive = true
        noButton.widthAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        noButton.heightAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        
        // 두번째 버튼
        yesButton.setTitle("응", for: .normal)
        yesButton.titleLabel?.font = .threeLight(size: 12)
        yesButton.setTitleColor(.white, for: .normal)
        yesButton.backgroundColor = .clear
        yesButton.setBorder(borderColor: .gray, borderWidth: 1)
        yesButton.addTarget(self, action: #selector(delateYesDidTap), for: .touchUpInside)
        
        self.buttonView.addSubview(yesButton)
        
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        
        yesButton.centerXAnchor.constraint(equalTo: self.buttonView.centerXAnchor, constant: 48).isActive = true
        // 가운데 정렬
        yesButton.widthAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        yesButton.heightAnchor.constraint(equalToConstant: self.buttonView.frame.height)
            .isActive = true
        
        moment = false
        
    }
    
    @objc func noButtonDidTap() {
        self.dismiss(animated: true)
    }
    
    @objc func delateYesDidTap() {
        // 게시물 삭제하기
        
        if let deleteIndex = deleteIndex,
           let jwt = UserDefaults.standard.string(forKey: "accessToken") {
            
            APIService.shared.deleteFeed(deleteIndex, jwt) { [self] result in
                switch result {
                case .success(let data):
                    
                    guard let loadData = data as? SimpleData else {
                        return
                    }
                    
                    self.simpleData = loadData
                    if self.simpleData?.status == 200 {
                        // 삭제 후 돌아가기
                        
                        postYesButtonDidTap()
                    }
                    
                    
                    
                case .failure(_):
                    // 데이터 확인하세요
                    print("데이터 확인")
                    
                }
                
            }
            
        } else {
            // 토큰이 만료되었거나 없는 것
            
            print("앱 다시 실행해주세요 하고 다시 켜기")
        }
    }
}
