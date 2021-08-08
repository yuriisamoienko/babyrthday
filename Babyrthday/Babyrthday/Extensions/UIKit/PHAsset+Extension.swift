//
//  PHAsset+Extension.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation
import UIKit
import Photos

extension PHAsset {
    
    // MARK: Public Properties
    
    var originalImage : UIImage? {
        get {
            var img: UIImage?
            let manager = PHImageManager.default()
            let options = PHImageRequestOptions()
            options.version = .original
            options.isSynchronous = true
            manager.requestImageData(for: self, options: options) { data, _, _, _ in
                
                if let data = data {
                    img = UIImage(data: data)
                }
            }
            return img
        }
    }
    
    var thumbnailImage : UIImage {
        get {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: self, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
            return thumbnail
        }
    }
    
}
