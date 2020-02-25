//
//  AnnouncementListViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
class AnnouncementListViewController: ListViewController {

    internal var announcements = [Announcement]() {
        didSet {
            noListItemsLabel.isHidden = !announcements.isEmpty
        }
    }
    
    internal var listBackgroundColor = UIColor.listBackground {
        didSet {
            tableView.backgroundColor = listBackgroundColor
        }
    }
    
    internal var separatorColor = UIColor.separator {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    internal var dateColor = UIColor.date {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    internal var contentDetailData: ContentDetailData?
    
    internal var hInset: CGFloat = 20.0 {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    internal var listViewTopInset: CGFloat = 8.0 {
        didSet {
            tableView.contentInset = UIEdgeInsets(top: listViewTopInset, left: 0, bottom: 0, right: 0)
        }
    }
    
    internal var listItemBackgroundColor = UIColor.listRowBackground {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        title = "공지사항"
        noItemDescription = "공지사항이 없습니다."
        tableView.register(TitleWithDateItemCell.self, forCellReuseIdentifier: TitleWithDateItemCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
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
        cell.hInset = self.hInset
        cell.dateColor = self.dateColor
        cell.backgroundColor = self.listItemBackgroundColor
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
        announcementDetailVC.contentDetailData = self.contentDetailData
        navigationController?.pushViewController(announcementDetailVC, animated: true)
    }
}
