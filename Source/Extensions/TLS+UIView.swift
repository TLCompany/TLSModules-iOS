//
//  UIView.swift
//  MansPouch_iOS
//
//  Created by Justin Ji on 04/01/2019.
//  Copyright © 2019 Justin Ji. All rights reserved.
//

import UIKit

extension UIView {
    
    public class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: self, options: nil)[0] as? UIView
    }

    public func fillUp() {
        guard let superView = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            ])
    }
    
    /// 상하의 Gradient 색을 넣습니다.
    public func addVerticalGredient(colors: [CGColor], locations: [NSNumber], cornerRadius: CGFloat = 0.0) {
        let graidentLayer = CAGradientLayer()
        graidentLayer.colors = colors
        graidentLayer.locations = locations
        graidentLayer.frame = self.frame
        graidentLayer.cornerRadius = cornerRadius
        self.layer.addSublayer(graidentLayer)
    }
    
    /// 좌우의 Graident 색을 넣습니다.
    public func addHorizontalGradient(colors: [CGColor]?, startPoint: CGPoint, endPoint: CGPoint, size: CGSize, cornerRadius: CGFloat = 0.0) {
        guard let colors = colors else { return }
        let graidentLayer = CAGradientLayer()
        graidentLayer.colors = colors
        graidentLayer.startPoint = startPoint
        graidentLayer.endPoint = endPoint
        graidentLayer.frame = CGRect(origin: self.bounds.origin, size: size)
        graidentLayer.cornerRadius = cornerRadius
        graidentLayer.masksToBounds = true
        self.layer.addSublayer(graidentLayer)
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // OUTPUT 1
    public func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
    /// 이미지를 URL로부터 다운로드 합니다.
    ///
    /// - Parameters:
    ///   - urlString: 다운로드할 이미지의 URL 텍스트
    public func downloadedImage(from urlString: String,
                         completionHandler completion: @escaping ((UIImage?) -> Void)) {
        
        guard let url = URL(string: urlString) else {
            showError(#function, type: .unsafelyWrapped(taget: "url"))
            completion(nil)
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: url) else {
                self.showError(#function, type: .nil(taget: "imageData"))
                return
            }
            
            DispatchQueue.main.async {
                completion(UIImage(data: imageData))
            }
        }
    }
}
