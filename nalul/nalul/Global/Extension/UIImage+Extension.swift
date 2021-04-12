//
//  UIImage+Extension.swift
//  nalul
//
//  Created by 김민희 on 2021/04/10.
//

import UIKit
import Accelerate

extension UIImage {
    
    func convertToGrayScale() -> UIImage? {
        // Image 흑백으로 바꾸기
        
        let imageRect:CGRect = CGRect(x:0, y:0, width:self.size.width, height: self.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = self.size.width
        let height = self.size.height
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        if let cgImg = self.cgImage {
            context?.draw(cgImg, in: imageRect)
            if let makeImg = context?.makeImage() {
                let imageRef: CGImage = makeImg
                // 사진이 돌아가는 경우가 있어서 원래 사진 방향으로 회전하기
                let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
                return image
            }
        }
        return UIImage()
    }
    
    
}
