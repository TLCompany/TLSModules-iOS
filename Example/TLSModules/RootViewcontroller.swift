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
    
    let content = "네이버 클라우드 플랫폼 서비스를 이용해주셔서 감사합니다. 당사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 30조의 2(개인정보 이용내역의 통지)에 따라, 고객님께서 네이버 클라우드 플랫폼에 제공하신 개인정보의 이용내역 현황을 알려 드립니다. 자세한 이용내역 현황은 아래와 같습니다. 1. 수집하는 개인정보의 항목 회사는 회원가입, 원활한 고객상담, 서비스 제공을 위해 최초 회원가입 당시 최소한의 개인정보를 수집하고자 하며 부가서비스 및 맞춤서비스 제공, 이벤트 응모 등을 위해 추가 수집이 필요한 경우 이용자 동의를 받고 있습니다. <개인 회원가입> - 필수항목: 이메일 주소, 비밀번호, 이름, 생년월일, 휴대폰 번호, 거주국가, 주소 <사업자 회원가입>네이버 클라우드 플랫폼 서비스를 이용해주셔서 감사합니다. 당사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 30조의 2(개인정보 이용내역의 통지)에 따라, 고객님께서 네이버 클라우드 플랫폼에 제공하신 개인정보의 이용내역 현황을 알려 드립니다. 자세한 이용내역 현황은 아래와 같습니다. 1. 수집하는 개인정보의 항목 회사는 회원가입, 원활한 고객상담, 서비스 제공을 위해 최초 회원가입 당시 최소한의 개인정보를 수집하고자 하며 부가서비스 및 맞춤서비스 제공, 이벤트 응모 등을 위해 추가 수집이 필요한 경우 이용자 동의를 받고 있습니다. <개인 회원가입> - 필수항목: 이메일 주소, 비밀번호, 이름, 생년월일, 휴대폰 번호, 거주국가, 주소 <사업자 회원가입>네이버 클라우드 플랫폼 서비스를 이용해주셔서 감사합니다. 당사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 30조의 2(개인정보 이용내역의 통지)에 따라, 고객님께서 네이버 클라우드 플랫폼에 제공하신 개인정보의 이용내역 현황을 알려 드립니다. 자세한 이용내역 현황은 아래와 같습니다. 1. 수집하는 개인정보의 항목 회사는 회원가입, 원활한 고객상담, 서비스 제공을 위해 최초 회원가입 당시 최소한의 개인정보를 수집하고자 하며 부가서비스 및 맞춤서비스 제공, 이벤트 응모 등을 위해 추가 수집이 필요한 경우 이용자 동의를 받고 있습니다. <개인 회원가입> - 필수항목: 이메일 주소, 비밀번호, 이름, 생년월일, 휴대폰 번호, 거주국가, 주소 <사업자 회원가입>네이버 클라우드 플랫폼 서비스를 이용해주셔서 감사합니다. 당사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 30조의 2(개인정보 이용내역의 통지)에 따라, 고객님께서 네이버 클라우드 플랫폼에 제공하신 개인정보의 이용내역 현황을 알려 드립니다. 자세한 이용내역 현황은 아래와 같습니다. 1. 수집하는 개인정보의 항목 회사는 회원가입, 원활한 고객상담, 서비스 제공을 위해 최초 회원가입 당시 최소한의 개인정보를 수집하고자 하며 부가서비스 및 맞춤서비스 제공, 이벤트 응모 등을 위해 추가 수집이 필요한 경우 이용자 동의를 받고 있습니다. <개인 회원가입> - 필수항목: 이메일 주소, 비밀번호, 이름, 생년월일, 휴대폰 번호, 거주국가, 주소 <사업자 회원가입>네이버 클라우드 플랫폼 서비스를 이용해주셔서 감사합니다. 당사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 30조의 2(개인정보 이용내역의 통지)에 따라, 고객님께서 네이버 클라우드 플랫폼에 제공하신 개인정보의 이용내역 현황을 알려 드립니다. 자세한 이용내역 현황은 아래와 같습니다. 1. 수집하는 개인정보의 항목 회사는 회원가입, 원활한 고객상담, 서비스 제공을 위해 최초 회원가입 당시 최소한의 개인정보를 수집하고자 하며 부가서비스 및 맞춤서비스 제공, 이벤트 응모 등을 위해 추가 수집이 필요한 경우 이용자 동의를 받고 있습니다. <개인 회원가입> - 필수항목: 이메일 주소, 비밀번호, 이름, 생년월일, 휴대폰 번호, 거주국가, 주소 <사업자 회원가입>네이버 클라우드 플랫폼 서비스를 이용해주셔서 감사합니다. 당사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 30조의 2(개인정보 이용내역의 통지)에 따라, 고객님께서 네이버 클라우드 플랫폼에 제공하신 개인정보의 이용내역 현황을 알려 드립니다. 자세한 이용내역 현황은 아래와 같습니다. 1. 수집하는 개인정보의 항목 회사는 회원가입, 원활한 고객상담, 서비스 제공을 위해 최초 회원가입 당시 최소한의 개인정보를 수집하고자 하며 부가서비스 및 맞춤서비스 제공, 이벤트 응모 등을 위해 추가 수집이 필요한 경우 이용자 동의를 받고 있습니다. <개인 회원가입> - 필수항목: 이메일 주소, 비밀번호, 이름, 생년월일, 휴대폰 번호, 거주국가, 주소 <사업자 회원가입>네이버 클라우드 플랫폼 서비스를 이용해주셔서 감사합니다. 당사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 30조의 2(개인정보 이용내역의 통지)에 따라, 고객님께서 네이버 클라우드 플랫폼에 제공하신 개인정보의 이용내역 현황을 알려 드립니다. 자세한 이용내역 현황은 아래와 같습니다. 1. 수집하는 개인정보의 항목 회사는 회원가입, 원활한 고객상담, 서비스 제공을 위해 최초 회원가입 당시 최소한의 개인정보를 수집하고자 하며 부가서비스 및 맞춤서비스 제공, 이벤트 응모 등을 위해 추가 수집이 필요한 경우 이용자 동의를 받고 있습니다. <개인 회원가입> - 필수항목: 이메일 주소, 비밀번호, 이름, 생년월일, 휴대폰 번호, 거주국가, 주소 <사업자 회원가입>"

    fileprivate lazy var annoucements = [Announcement(id: 1, title: "첫번째 공지사항입니다.", content: content, date: Date()),
                                    Announcement(id: 2, title: "두번째 공지사항입니다.", content: content, date: Date()),
                                    Announcement(id: 3, title: "세번째 공지사항입니다.", content: content, date: Date()),
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