//
//  AnnouncementDetailViewController.swift
//  TLSModules
//
//  Created by Justin Ji on 16/08/2019.
//

import UIKit

class AnnouncementDetailViewController: ScrollingViewController {
    
    internal var announcement: Announcement?
    internal var contentDetailData: ContentDetailData?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항의 제목을 보여줍니다."
        label.numberOfLines = 2
        let font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.font = UIFontMetrics.init(forTextStyle: .body).scaledFont(for: font)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator = SeparatorView()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "0000.00.00"
        label.textColor = .date
        let font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        label.font = UIFontMetrics.init(forTextStyle: .body).scaledFont(for: font)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항의 내용을 보여줍니다."
        label.textColor = .textContent
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        let font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.font = UIFontMetrics.init(forTextStyle: .body).scaledFont(for: font)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "공지사항"
        view.backgroundColor = .white
        setUpAnnouncement()
        setUpContentDetailData()
    }
    
    private func setUpContentDetailData() {
        
        guard let contentDetailData = self.contentDetailData else {
            print("\(#function), 😭 contentDetailData is nil...")
            return
        }
        
        if let titleFont = contentDetailData.titleFont {
            titleLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: titleFont)
        }
        
        if let contentFont = contentDetailData.contentFont {
            contentLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: contentFont)
        }
        
        view.backgroundColor = contentDetailData.backgroundColor
        titleLabel.textColor = contentDetailData.titleColor
        contentLabel.textColor = contentDetailData.contentColor
        dateLabel.textColor = contentDetailData.dateColor
        separator.backgroundColor = contentDetailData.separatorColor
        titleLeftConstraint.constant = contentDetailData.hInset
        titleRightConstraint.constant = -contentDetailData.hInset
        view.layoutIfNeeded()
    }
    
    private var titleLeftConstraint: NSLayoutConstraint!
    private var titleRightConstraint: NSLayoutConstraint!
    
    private func setUpAnnouncement() {
        guard let announcement = self.announcement else {
            print("\(#function), 😭 announcement is nil...")
            return
        }
        
        titleLabel.text = announcement.title
        dateLabel.text = announcement.date.formattedDateString
        contentLabel.text = announcement.content
        
    }
    
    
    override func setUpLayout() {
        super.setUpLayout()
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(separator)
        containerView.addSubview(dateLabel)
        containerView.addSubview(contentLabel)
        
        titleLeftConstraint = titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20.0)
        titleLeftConstraint.isActive = true
        
        titleRightConstraint = titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20.0)
        titleRightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0),
            
            separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            separator.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            
            dateLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8.0),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20.0),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            containerView.bottomAnchor.constraint(equalTo: contentLabel.bottomAnchor)
            ])
    }
}
