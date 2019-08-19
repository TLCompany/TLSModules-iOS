//
//  AnnouncementListViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

public class AnnouncementListViewController: UIViewController {

    public var announcements = [Announcement]() {
        didSet {
            emptyLabel.isHidden = !announcements.isEmpty
        }
    }
    
    public var listBackgroundColor: UIColor? {
        didSet {
            tableView.backgroundColor = listBackgroundColor
        }
    }
    
    public var separatorColor: UIColor? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.removeExtraEmptyCells()
        tableView.contentInset = UIEdgeInsets(top: 12.0, left: 0, bottom: 0, right: 0)
        tableView.register(TitleWithDateItemCell.self, forCellReuseIdentifier: TitleWithDateItemCell.id)
        tableView.backgroundColor = .listBackground
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항이 없습니다."
        label.textColor = .textContent
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        title = "공지사항"
        view.backgroundColor = .white
        setUpLayout()
    }

    private func setUpLayout() {
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
        
        tableView.fillUp()
        emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension AnnouncementListViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithDateItemCell.id, for: indexPath) as? TitleWithDateItemCell else {
            return UITableViewCell()
        }
        
        cell.announcement = announcements[indexPath.row]
        cell.isLast = indexPath.row == announcements.count - 1
        cell.separatorColor = self.separatorColor
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TitleWithDateItemCell.height
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TitleWithDateItemCell else {
            return
        }
        cell.isSelected = !cell.isSelected
        
        let announcementDetailVC = AnnouncementDetailViewController()
        announcementDetailVC.announcement = announcements[indexPath.row]
        navigationController?.pushViewController(announcementDetailVC, animated: true)
    }
}
