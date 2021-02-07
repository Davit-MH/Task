//
//  UIImageExtension.swift
//  Task
//
//  Created by Davit Martirosyan on 04.02.21.
//

import Foundation
import UIKit



extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero,size: scaledImageSize))
        }
        
        return scaledImage
    }
    
    func resizePreservingAspectRatio(targetWidth: CGFloat) -> UIImage {
        
        let widthRatio = targetWidth / size.width

        let scaledImageSize = CGSize(width: size.width * widthRatio,
            height: size.height * widthRatio
        )
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero,size: scaledImageSize))
        }
        
        return scaledImage
    }
}
