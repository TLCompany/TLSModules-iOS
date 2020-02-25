//
//  RightArrowItemCell.swift
//  Alamofire
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
class RightArrowItemCell: BaseTableViewCell {
    
    static let id = "RightArrowItemCell"
    static let height: CGFloat = 44.5

    public var title: String? {
        didSet {
            titleLabel.text = self.title
        }
    }
    
    public var hInset: CGFloat = 20.0 {
        didSet {
            self.leadingEdgeConstraint.constant = hInset
            self.trailingEdgeConstraint.constant = -hInset
            self.layoutIfNeeded()
        }
    }
    
    public var separatorColor = UIColor.separator {
        didSet {
            self.separator.backgroundColor = self.separatorColor
        }
    }
    
    //Private Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "list item title"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right_arrow_gray")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let separator = SeparatorView()
    private var trailingEdgeConstraint: NSLayoutConstraint!
    private var leadingEdgeConstraint: NSLayoutConstraint!
    
    public override func setThingsUp() {
        backgroundColor = UIColor.listRowBackground
        setUpLayout()
    }
    
    private func setUpLayout() {
        addSubview(titleLabel)
        addSubview(rightImageView)
        addSubview(separator)
        
        trailingEdgeConstraint = rightImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0)
        leadingEdgeConstraint = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0)
        trailingEdgeConstraint.isActive = true
        leadingEdgeConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.rightImageView.leadingAnchor, constant: -24.0),
            
            rightImageView.widthAnchor.constraint(equalToConstant: 14.0),
            rightImageView.heightAnchor.constraint(equalToConstant: 14.0),
            rightImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            ])
    }
}
