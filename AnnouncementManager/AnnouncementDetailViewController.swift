//
//  AnnouncementDetailViewController.swift
//  TLSModules
//
//  Created by Justin Ji on 16/08/2019.
//

import UIKit

class AnnouncementDetailViewController: UIViewController {
    
    public var annoucement: Announcement?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항의 제목을 보여줍니다."
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "공지사항의 제목을 보여줍니다."
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separator = SeparatorView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 1.0)))
    
    private let scrollView = TLScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "공지사항"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.fillUp()
        scrollView.add(titleLabel2, topMargin: 12.0, trailingMargin: -20, leadingMargin: 20, bottomMargin: 0)
        scrollView.add(titleLabel, topMargin: 12.0, trailingMargin: -20, leadingMargin: 20, bottomMargin: 0)
    }
}
