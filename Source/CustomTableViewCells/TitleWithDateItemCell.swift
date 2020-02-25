//
//  TitleWithDateItemCell.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
class TitleWithDateItemCell: BaseTableViewCell {
    
    //Static Properties
    static let id = "TitleWithDateItemCell"
    static let height: CGFloat = 44.0
    
    //Internal Properties
    internal var announcement: Announcement? {
        didSet {
            guard let announcement = self.announcement else {
                return
            }
            
            DispatchQueue.main.async {
                self.titleLabel.text = announcement.title
                self.dateLabel.text = announcement.date.formattedDateString
            }
        }
    }
    
    internal var separatorColor: UIColor? {
        didSet {
            separator.backgroundColor = self.separatorColor
        }
    }
    
    internal var isLast: Bool = false {
        didSet {
            separator.isHidden = isLast ? true : false
        }
    }
    
    internal var dateColor: UIColor? {
        didSet {
            dateLabel.textColor = dateColor
        }
    }
    
    internal var hInset: CGFloat = 20.0 {
        didSet {
            self.leadingEdgeConstraint.constant = hInset
            self.trailingEdgeConstraint.constant = -hInset
            self.layoutIfNeeded()
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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "0000.00.00"
        label.textColor = .date
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let separator = SeparatorView()

    private var leadingEdgeConstraint: NSLayoutConstraint!
    private var trailingEdgeConstraint: NSLayoutConstraint!
    private var titleYConstraint: NSLayoutConstraint!
    
    public override func setThingsUp() {
        backgroundColor = .listRowBackground
        setUpLayout()
    }
    
    private func setUpLayout() {
        
        addSubview(separator)
        addSubview(dateLabel)
        addSubview(titleLabel)
        leadingEdgeConstraint = separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0)
        leadingEdgeConstraint.isActive = true
        
        trailingEdgeConstraint = separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0)
        trailingEdgeConstraint.isActive = true
        
        titleYConstraint = titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        titleYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1.5),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            
            titleLabel.leadingAnchor.constraint(equalTo: separator.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8.0),
            
            dateLabel.trailingAnchor.constraint(equalTo: separator.trailingAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            ])
    }
}
