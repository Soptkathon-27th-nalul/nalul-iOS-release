//
//  GalleryListVC.swift
//  nalul
//
//  Created by 김민희 on 2021/03/17.
//

import UIKit

class GalleryListVC: UIViewController {
    
    // MARK: Variable Part
    
    var titleName: String?
    var indexs: Int?
    var feedData: [FeedData]?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writeButton: UIButton!
    
    @IBOutlet weak var galleryBackImage: UIImageView!
    
    @IBOutlet weak var galleryListCollectionView:
        UICollectionView!
    
    // MARK: IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func writeButtonDidTap(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PhotoInsertVC") as? PhotoInsertVC else {
            return
        }
        nextVC.titleName = titleName
        nextVC.categoryIndex = indexs
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: Life Cycle Part
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateFeed()
    }
    
    override func viewDidLayoutSubviews() {
        
        setButton()
        
    }
    
}

// MARK: Extension

extension GalleryListVC {
    
    // MARK: Function
    
    func setView() {
        
        galleryBackImage.image = UIImage(named: "gallaryBackground")
        galleryListCollectionView.backgroundColor = .none
        
        titleLabel.font = UIFont.threeLight(size: 17)
        titleLabel.textColor = .white
        
        if let titleName = titleName {
            titleLabel.text = titleName
        } else {
            titleLabel.text = "왼쪽 눈"
        }
        
        galleryListCollectionView.dataSource = self
        galleryListCollectionView.delegate = self
        
    }
    
    
    func setButton() {
        
        writeButton.setTitle("추가", for: .normal)
        writeButton.titleLabel?.font = UIFont.threeLight(size: 14)
        writeButton.tintColor = .white
        writeButton.setBorder(borderColor: .white, borderWidth: 1)
        writeButton.makeRounded(cornerRadius: nil)
        
    }
    
    func updateFeed() {
        
        if let indexs = indexs,
           let jwt = UserDefaults.standard.string(forKey: "accessToken") {
            
            APIService.shared.feedUpdate(indexs, jwt) { [self] result in
                switch result {
                case .success(let data):

                    self.feedData = data
                    galleryListCollectionView.reloadData()
                    // Feed 새로고침
                    
                    
                case .failure(let error):
                    // 데이터 통신 확인해주세요
                    print(error)
                }
                
            }
            
        }
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension GalleryListVC: UICollectionViewDelegateFlowLayout {
    // CollectionView 크기 잡기
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 한 아이템의 크기
        
        return CGSize(width: 110/375*collectionView.frame.width, height: 110/375*collectionView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 위아래 간격
        
        return 13
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템간의 오른쪽 간격
        
        return 72
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // collectionView와 View 간의 간격
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.view.frame.width - (110/375*collectionView.frame.width*2 + 72))
        
    }
    
}

// MARK: UICollectionViewDataSource

extension GalleryListVC: UICollectionViewDataSource {
    // CollectionView 데이터 넣기
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 최소 단위 12개로 설정
        
        if let feedData = feedData {
            if feedData.count > 12 {
                return feedData.count
            }
        }
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryListCell.identifier, for: indexPath) as? GalleryListCell else {
            return UICollectionViewCell()
        }
        
        if let feedData = feedData {
            if indexPath.row < feedData.count {
                cell.setimage(imageURL: feedData[indexPath.row].photo)
            } else {
                cell.galleryImageView.image = nil
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "GalleryDetailVC") as? GalleryDetailVC else {
            return
        }
        nextVC.titleName = titleName
        if let feedData = feedData {
            if indexPath.row < feedData.count {
                self.navigationController?.pushViewController(nextVC, animated: true)
                nextVC.postDate = feedData[indexPath.row].createdAt
                nextVC.userPhoto = feedData[indexPath.row].photo
                nextVC.question = feedData[indexPath.row].Question
                nextVC.answer = feedData[indexPath.row].text
            }
            
        }
        
    }
    
    
}
