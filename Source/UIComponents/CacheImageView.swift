//
//  CacheImageView.swift
//  Alamofire
//
//  Created by Justin Ji on 30/09/2019.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

open class CacheImageView: UIImageView {

    var imageURLString: String?
    
    public func loadImageUsingURLString(urlString: String) {
        
        imageURLString = urlString
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        self.imageDownloaded(from: urlString) { (image) in
            guard let image = image else {
                Logger.showError(at: #function, type: .unsafelyWrapped(taget: "image"))
                return
            }
            
            let imageToCache = image
            if self.imageURLString == urlString {
                DispatchQueue.main.async {
                    self.image = imageToCache
                }
            }
            imageCache.setObject(imageToCache, forKey: urlString as NSString)
        }
    }
}
