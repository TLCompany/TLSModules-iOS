//
//  ViewController.swift
//  TLSModules
//
//  Created by jjeui0308@gmail.com on 08/13/2019.
//  Copyright (c) 2019 jjeui0308@gmail.com. All rights reserved.
//

import UIKit
import TLSModules

class RootViewController: UIViewController {

    private var announcementManager: AnnouncementManager?
    private var rowTitles = ["공지사항(Announcement)"]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.removeExtraEmptyCells()
        tableView.contentInset = UIEdgeInsets(top: 12.0, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        announcementManager = AnnouncementManager(vc: self)
        view.backgroundColor = .white
        title = "TLSolution Modules"
        setUpLayout()
    }

    private func setUpLayout() {
        view.addSubview(tableView)
        tableView.fillUp()
    }

    fileprivate var annoucements = [Announcement(id: 1, title: "첫번째 공지사항입니다.", content: "Asdf", date: Date()),
                                    Announcement(id: 2, title: "두번째 공지사항입니다.", content: "Asdf", date: Date()),
                                    Announcement(id: 3, title: "세번째 공지사항입니다.", content: "Asdf", date: Date()),
                                    Announcement(id: 4, title: "네번째 공지사항입니다.", content: "Asdf", date: Date()),
                                    Announcement(id: 5, title: "다섯번째 공지사항입니다.", content: "Asdf", date: Date()),
                                    Announcement(id: 6, title: "여섯번째 공지사항입니다.", content: "Asdf", date: Date()),
                                    Announcement(id: 7, title: "일곱번째 공지사항입니다.", content: "Asdf", date: Date()),
                                    Announcement(id: 8, title: "여덟번째 공지사항입니다.", content: "Asdf", date: Date()),]
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        cell.textLabel?.text = rowTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        cell.isSelected = !cell.isSelected
        switch indexPath.row {
        case 0:
            announcementManager?.go(with: self.annoucements)
        default: return
        }
    }
}


