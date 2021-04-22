//
//  OnboardingPageController.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import UIKit

class OnboardingPageController: UIPageViewController {
    
    // MARK: Variable Part
    
    lazy var VCArray:[UIViewController] = {
        return [self.VCInstance(name: "LogoOnboardingVC"),
                self.VCInstance(name: "ExplainOnboardingVC"),
                self.VCInstance(name: "PrivacyPolicyAgreementVC"),
                self.VCInstance(name: "BackgroundSettingVC")]
    }()
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let firstVC = VCArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            // 제일 처음 나올 뷰 설정
        }
    }
    
    override func didReceiveMemoryWarning() {
        // 메모리 경고시
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        // 맨 밑에 나오는 검정 tab을 제거하기 위함
        
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    func VCInstance(name: String) -> UIViewController {
        
        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: name)
    }

    
}

// MARK: UIPageViewControllerDataSource

extension OnboardingPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 현재 뷰 앞에 있는 뷰(이전 뷰) 반환
        
        guard let viewControllerIndex = VCArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        // 현재 인덱스에서 -1 ( 이전이니깐 )
        
        guard previousIndex >= 0 else {
            // 현재 위치가 제일 첫번째 페이지라면?
            
            return nil
            // 이전으로 이동 X
        }
        
        guard VCArray.count > previousIndex else {
            return nil
        }
        
        return VCArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 현재 뷰 뒤에 있는 뷰 반환
        
        guard let viewControllerIndex = VCArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        // 현재 인덱스에서 +1
        
        guard nextIndex < VCArray.count else {
            return nil
        }
        
        guard VCArray.count > nextIndex else {
            return nil
        }
        
        return VCArray[nextIndex]
    }
    
    
}

// MARK: UIPageViewControllerDelegate

extension OnboardingPageController: UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = VCArray.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
}
