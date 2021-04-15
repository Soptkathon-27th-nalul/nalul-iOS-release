//
//  BackgroundConfirmVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import UIKit

class BackgroundConfirmVC: UIViewController {
    
    // MARK: Variable Part
    
    var backImage: UIImage?
    var signupData: LoginData?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    // MARK: IBAction
    
    @IBAction func againButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func okButtonDidTap(_ sender: Any) {
        
        signup(uuid: UIDevice.current.identifierForVendor!.uuidString)
        // 회원가입 시도
        
    }
    
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setBackground()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        againButton.makeRounded(cornerRadius: nil)
        okButton.makeRounded(cornerRadius: nil)
    }
    
}

// MARK: Extension

extension BackgroundConfirmVC {
    
    // MARK: Function
    
    func setButton() {
        
        againButton.setTitle("다시", for: .normal)
        againButton.titleLabel?.font = UIFont.threeLight(size: 14)
        againButton.tintColor = .white
        againButton.setBorder(borderColor: .white, borderWidth: 1)
        againButton.backgroundColor = .clear
        
        okButton.setTitle("사용", for: .normal)
        okButton.titleLabel?.font = UIFont.threeLight(size: 14)
        okButton.tintColor = .white
        okButton.setBorder(borderColor: .white, borderWidth: 1)
        okButton.backgroundColor = .clear
    }
    
    func setBackground() {
        
        if let backImage = backImage {
            backgroundImageView.image = backImage.convertToGrayScale()
            // 흑백처리
            
        } else {
            backgroundImageView.image = UIImage(named: "testBlackImage")
        }
    }
    
    func signup(uuid: String) {
        // 회원가입 서버 연결 함수
        
        APIService.shared.signup(uuid) { [self] result in
            switch result {
            case .success(let data):
                // 회원가입 완료
                print(data)
                signupData = data
                UserDefaults.standard.setValue(signupData?.accessToken, forKey: "accessToken")
                // 토큰 저장
                backgroundImageSave()
                
            case .failure(_):
                print("데이터 연결을 확인해주세요")
            }
            
        }
    }
    
    func backgroundImageSave() {
        // 사용자 배경화면 저장하기
        
        let uniqueFileName: String = "UserBackgroundImage"
        
        if let image = backgroundImageView.image {
            
            ImageFileManager.shared.saveImage(image: image, name: uniqueFileName) { [weak self] onSuccess in
                print("saveImage onSuccess: \(onSuccess)")
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                guard let homeTab = storyboard.instantiateViewController(identifier: "MainStartVC") as? MainStartVC else {
                    return
                }
                self?.view.window?.rootViewController?.dismiss(animated: false, completion: {
                    // 현재뷰를 pop 한 다음, 다음 뷰로 이동하기
                    homeTab.modalPresentationStyle = .fullScreen
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController?.present(homeTab, animated: true, completion: nil)
                })
                
            }
        }
    }
    
}
