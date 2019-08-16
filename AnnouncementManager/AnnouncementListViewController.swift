//
//  AnnouncementListViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

public class AnnouncementListViewController: UIViewController {

    public var announcements: [Announcement]?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.removeExtraEmptyCells()
        tableView.contentInset = UIEdgeInsets(top: 12.0, left: 0, bottom: 0, right: 0)
        tableView.register(TitleWithDateItemCell.self, forCellReuseIdentifier: TitleWithDateItemCell.id)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        title = "공지사항"
        view.backgroundColor = .red
        setUpLayout()
    }

    private func setUpLayout() {
        view.addSubview(tableView)
        tableView.fillUp()
    }
}
extension AnnouncementListViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleWithDateItemCell.id, for: indexPath) as? TitleWithDateItemCell else {
            return UITableViewCell()
        }
        
        cell.announcement = announcements?[indexPath.row]
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
        announcementDetailVC.annoucement = announcements?[indexPath.row]
        navigationController?.pushViewController(announcementDetailVC, animated: true)
    }
}
