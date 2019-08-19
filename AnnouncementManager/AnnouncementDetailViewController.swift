//
//  AnnouncementDetailViewController.swift
//  TLSModules
//
//  Created by Justin Ji on 16/08/2019.
//

import UIKit

class AnnouncementDetailViewController: ScrollingViewController {
    
    public var announcement: Announcement?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항의 제목을 보여줍니다."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separator = SeparatorView()
    
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        button.setTitle("OFF", for: .normal)
        button.setTitle("ON", for: .selected)
        button.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "0000.00.00"
        label.textColor = .date
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항의 내용을 보여줍니다."
        label.textColor = .textContent
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc
    private func touchButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "공지사항"
        view.backgroundColor = .white
        setUpAnnouncement()
    }
    
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
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20.0),
            
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
