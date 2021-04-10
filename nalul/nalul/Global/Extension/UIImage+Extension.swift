//
//  UIImage+Extension.swift
//  nalul
//
//  Created by 김민희 on 2021/04/10.
//

import UIKit

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
                    let imageRef = makeImg
                    let newImage = UIImage(cgImage: imageRef)
                    return newImage
                }
            }
        
            return UIImage()
        }
}
