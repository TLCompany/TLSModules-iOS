//
//  TitleWithDateItemCell.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

public class TitleWithDateItemCell: UITableViewCell {
    
    //Static Properties
    static let id = "TitleWithDateItemCell"
    static let height: CGFloat = 44.0
    
    //Public Properties
    public var announcement: Announcement? {
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
    
    private let underline: UIView = {
        let view = UIView()
        view.backgroundColor = .underline
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private var underlineLeftConstraint: NSLayoutConstraint!
    private var underlineRightConstraint: NSLayoutConstraint!
    private var titleYConstraint: NSLayoutConstraint!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .listRowBackground
        setUpLayout()
    }
    
    private func setUpLayout() {
        
        addSubview(underline)
        addSubview(dateLabel)
        addSubview(titleLabel)
        underlineLeftConstraint = underline.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0)
        underlineLeftConstraint.isActive = true
        
        underlineRightConstraint = underline.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0)
        underlineRightConstraint.isActive = true
        
        titleYConstraint = titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        titleYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            underline.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1.5),
            underline.heightAnchor.constraint(equalToConstant: 0.5),
            
            titleLabel.leadingAnchor.constraint(equalTo: underline.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8.0),
            
            dateLabel.trailingAnchor.constraint(equalTo: underline.trailingAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            ])
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
