//
//  InqueryItemCell.swift
//  TLSModules
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

/// 문의사항 리스트 아이템 TableViewCell
internal class InqueryItemCell: BaseTableViewCell {

    static let id = "InqueryItemCell"
    static let height: CGFloat = 50.5
    
    //Internal Properties
    internal var inquery: Inquery? {
        didSet {
            guard let inquery = self.inquery else {
                print("\(#function) 😭 inquery is nil...")
                return
            }
            titleLabel.text = inquery.content
            dateLabel.text = inquery.date.formattedDateString
            completionLabel.text = inquery.isAnswered ? "답변 완료" : "답변 미완료"
            completionLabel.textColor = inquery.isAnswered ? answeredColor : unansweredColor
        }
    }
    
    internal var hInset: CGFloat = 20.0 {
        didSet {
            leadingEdgeConstraint.constant = hInset
            trailingEdgeConstraint.constant = -hInset
            layoutIfNeeded()
        }
    }
    
    internal var answeredColor = UIColor.init(hexString: "BA0000")
    internal var unansweredColor = UIColor.init(hexString: "304786")
    
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
    
    private let completionLabel: UILabel = {
        let label = UILabel()
        label.text = "답변미완료"
        label.textColor = .incompleted
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator = SeparatorView()
    private var trailingEdgeConstraint: NSLayoutConstraint!
    private var leadingEdgeConstraint: NSLayoutConstraint!
    
    override public func setThingsUp() {
        addSubview(separator)
        addSubview(completionLabel)
        addSubview(dateLabel)
        addSubview(titleLabel)
        
        trailingEdgeConstraint = completionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0)
        leadingEdgeConstraint = dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0)
        leadingEdgeConstraint.isActive = true
        trailingEdgeConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            
            completionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.5),
            dateLabel.trailingAnchor.constraint(equalTo: completionLabel.leadingAnchor, constant: -8.0),
            
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -4.0),
            titleLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            ])
    }
}
