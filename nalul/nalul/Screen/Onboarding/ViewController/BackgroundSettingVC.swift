//
//  BackgroundSettingVC.swift
//  nalul
//
//  Created by 김민희 on 2021/04/09.
//

import UIKit

class BackgroundSettingVC: UIViewController {
    
    // MARK: Variable Part
    
    var myImage: UIImage?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    
    // MARK: IBAction
    
    @IBAction func registerButtonDidTap(_ sender: Any) {
        // 배경화면 지정 버튼 클릭 시
        
        let optionMenu = UIAlertController(title: nil, message: "배경화면 등록하기", preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "카메라 촬영", style: .default, handler: {
            // 카메라 선택 시 action
            
            (alert: UIAlertAction!) -> Void in
            
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.cameraDevice = .front
            vc.delegate = self
            vc.mediaTypes = ["public.image"]
            vc.allowsEditing = false
            self.present(vc, animated: true, completion: nil)
            
        })
        
        let saveAction = UIAlertAction(title: "앨범에서 사진 선택하기", style: .default, handler: {
            // 갤러시 선택 시 action
            
            (alert: UIAlertAction!) -> Void in
            
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.mediaTypes = ["public.image"]
            vc.allowsEditing = false
            self.present(vc, animated: true, completion: nil)
        })
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
        })
        
        //action sheet에 옵션 추가.
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)

        self.present(optionMenu, animated: true, completion: nil)
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    
}

// MARK: Extension

extension BackgroundSettingVC {
    
    // MARK: Function
    
    func setView() {
        titleLabel.text = "이제 nalul 찍어볼까요?"
        titleLabel.font = .threeLight(size: 18)
        titleLabel.textColor = .white
        
        explainLabel.text = "나를의 배경은 당신입니다.\n화면에 꽉 찰 수 있는 정면 사진을 올려주세요.\n등록하는 모든 사진은 흑백처리 됩니다."
        explainLabel.font = .threeLight(size: 14)
        explainLabel.textColor = .init(white: 1.0, alpha: 0.6)
        explainLabel.numberOfLines = 0
        explainLabel.textAlignment = .center
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension BackgroundSettingVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            
            // 수정된 이미지가 있을 경우
            myImage = image
            
        } else if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            
            // 오리지널 이미지가 있을 경우
            myImage = image
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        
        guard let firstTab = self.storyboard?.instantiateViewController(identifier: "BackgroundConfirmVC") as? BackgroundConfirmVC else {
            return
        }
        
        firstTab.backImage = myImage
        firstTab.modalPresentationStyle = .fullScreen
        self.present(firstTab, animated: true, completion: nil)
        // 확인하는 뷰로 이동하기
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}
