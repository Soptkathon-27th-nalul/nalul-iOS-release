//
//  SplashVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/15.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    
    // MARK: Variable Part
    
    var loginData: LoginData?
    
    @IBOutlet weak var splashView: UIView!
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLottie()
    }
    
}

// MARK: Extension

extension SplashVC {
    
    // MARK: Function
    
    func setLottie(){
        
        self.view.backgroundColor = .nalulBlack
        splashView.backgroundColor = .clear
        
        let animationView = AnimationView(name: "suna2")
        
        animationView.frame = CGRect(x: 0, y: 0, width: splashView.bounds.width, height: splashView.bounds.height)
        
        // 애니메이션뷰의 콘텐트모드 설정
        animationView.contentMode = .scaleAspectFill
        
        // 에러 나는 부분
        
        // 애니메이션뷰를 메인뷰에 추가
        splashView.addSubview(animationView)
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.playOnce,
                           completion: { (finished) in
                            if finished {
                                self.login(uuid: UIDevice.current.identifierForVendor!.uuidString)
                            } else {
                                // 앱 다시 확인
                            }
                           })
        
    }
    
    func login(uuid: String) {
        // 로그인 서버 연결 함수
        
        APIService.shared.login(uuid) { [self] result in
            switch result {
            case .success(let data):
                // 로그인이 되어있는 상황
                
                loginData = data
                UserDefaults.standard.setValue(loginData?.accessToken, forKey: "accessToken")
                // 토큰 저장
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                guard let mainTab = storyboard.instantiateViewController(identifier: "MainNavigationVC") as? MainNavigationVC else {
                    return
                }
                
                mainTab.modalPresentationStyle = .fullScreen
                self.present(mainTab, animated: false, completion: nil)
                // main 화면으로 이동
                
                
            case .failure(let error):
                if error == 400 {
                    // 회원가입 필요한 상황
                    
                    let storyboard = UIStoryboard.init(name: "Onboarding", bundle: nil)
                    guard let signupTab = storyboard.instantiateViewController(identifier: "OnboardingPageController") as? OnboardingPageController else {
                        return
                    }
                    signupTab.modalPresentationStyle = .fullScreen
                    self.present(signupTab, animated: false, completion: nil)
                    // 온보딩 뷰로 이동
                    
                } else {
                    print("데이터 연결을 확인해주세요")
                }
            }
            
        }
    }
}
