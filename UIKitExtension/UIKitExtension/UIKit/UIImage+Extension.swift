//
//  UIImage+Extension.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

public extension UIImage {

    // MARK: Public Functions
    
    func with(backgroundColor color: UIColor) -> UIImage {
        let opaque: Bool = true
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        guard let ctx = UIGraphicsGetCurrentContext(), let image = cgImage else { return self }
        defer { UIGraphicsEndImageContext() }
        
        let rect = CGRect(origin: .zero, size: size)
        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
        ctx.draw(image, in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
    
}
