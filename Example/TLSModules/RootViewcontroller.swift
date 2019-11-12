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
    private var policyManager: PolicyManager?
    private var inquiryManager: InquiryManager?
    private var exampleAuthManager: ExampleAuthManager?
    
    private var rowTitles = ["공지사항(Announcement)", "정책사항(Policy)", "문의사항(Inquery)", "회원가입(Authentication)", "PopupList"]
    
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
        policyManager = PolicyManager(vc: self)
        inquiryManager = InquiryManager(vc: self)
        inquiryManager?.newAction = { [unowned self] text in
            let newInquery = Inquiry(id: 1, content: text, answer: nil, date: Date(), isAnswered: false)
            self.inquiries.insert(newInquery, at: 0)
            self.inquiryManager?.refresh(with: self.inquiries)
        }
        
        exampleAuthManager = ExampleAuthManager(vc: self)
        exampleAuthManager?.policies = self.policies
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
    
    fileprivate lazy var policies =  [Policy(title: "이용약관", content: content),
                                      Policy(title: "마케팅 사용동의(선택)", content: content, isMandatory: false),
                                      Policy(title: "개인정보 취급방침", content: content),]
    
    private let inqeury = "네이버 클라우드 플랫폼 서비스를 이용해주셔서 감사합니다. 당사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 30조의 2(개인정보 이용내역의 통지)에 따라, 고객님께서 네이버 클라우드 플랫폼에 제공하신 개인정보의 이용내역 현황을 알려 드립니다. 자세한 이용내역 현황은 아래와 같습니다. 1. 수집하는 개인정보의 항목 회사는 회원가입, 원활한 고객상담, 서비스 제공을 위해 최초 회원가입 당시 최소한의 개인정보를 수집하고자 하며 부가서비스 및 맞춤서비스 제공, 이벤트 응모 등을 위해 추가 수집이 필요한 경우 이용자 동의를 받고 있습니다."
    fileprivate lazy var inquiries = [Inquiry(id: 1, content: inqeury, answer: inqeury, date: Date(), isAnswered: true),
                                        Inquiry(id: 2, content: inqeury, answer: inqeury, date: Date(), isAnswered: true),
                                        Inquiry(id: 3, content: inqeury, answer: inqeury, date: Date(), isAnswered: true),
                                        Inquiry(id: 4, content: inqeury, answer: nil, date: Date(), isAnswered: false),
                                        Inquiry(id: 5,content: inqeury, answer: nil, date: Date(), isAnswered: false),
                                        Inquiry(id: 6,content: inqeury, answer: nil, date: Date(), isAnswered: false),
                                        Inquiry(id: 7,content: inqeury, answer: nil, date: Date(), isAnswered: false)]
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
            announcementManager?.launch(with: self.annoucements)
        case 1:
            policyManager?.listBackgroundColor = .red
            policyManager?.hInset = 50.0
            policyManager?.detailContentColor = .white
            policyManager?.detailBackgroundColor = .brown
            policyManager?.detailContentFont = UIFont.systemFont(ofSize: 30.0, weight: .bold)
            policyManager?.listItemBackgroundColor = .yellow
            policyManager?.listViewTopInset = 100.0
            policyManager?.launch(with: self.policies)
        case 2:
            inquiryManager?.listBackgroundColor = .red
            inquiryManager?.hInset = 50.0
            inquiryManager?.listItemBackgroundColor = .yellow
            inquiryManager?.listViewTopInset = 100.0
            inquiryManager?.answeredColor = .brown
            inquiryManager?.unansweredColor = .purple
            inquiryManager?.answerBackgroundColor = .red
            inquiryManager?.answeredColor = .yellow
            inquiryManager?.answerFont = UIFont.systemFont(ofSize: 30.0, weight: .bold)
            inquiryManager?.detailContentFont = UIFont.systemFont(ofSize: 30.0, weight: .bold)
            inquiryManager?.detailBackgroundColor = .brown
            inquiryManager?.detailContentColor = .red
            inquiryManager?.launch(with: self.inquiries)
        case 3:
            testAuth()
        case 4:
            let listPopupVC = ListPopupViewController()
            listPopupVC.list = [Int](0...100).map { return "List Item \($0)" }
            listPopupVC.selectAction = { [unowned self] section in
                print(section)
            }
            listPopupVC.modalPresentationStyle = .overCurrentContext
            present(listPopupVC, animated: true, completion: nil)
        default: return
        }
    }
    
    private func testAuth() {
        let actionSheet = UIAlertController(title: "type", message: "Choose Type", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let mobile = UIAlertAction(title: "휴대폰 인증 회원가입", style: .default) { (_) in
            self.exampleAuthManager?.verificationType = .mobile
            self.exampleAuthManager?.execute(completionHandler: { [unowned self] user in
                Logger.showDebuggingMessage(user.password)
                self.systemAlert(message: "회원가입이 완료되었습니다.", buttonTitle: "확인") {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
        }
        let email = UIAlertAction(title: "이메일 인증 회원가입", style: .default) { (_) in
            self.exampleAuthManager?.verificationType = .email
            self.exampleAuthManager?.execute(completionHandler: { [unowned self] user in
                Logger.showDebuggingMessage(user.password)
                self.systemAlert(message: "회원가입이 완료되었습니다.", buttonTitle: "확인") {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
            
        }
        
        let resetPW = UIAlertAction(title: "비밀번호 찾기", style: .default) { (_) in
            self.exampleAuthManager?.findPw(completionHandler: { (pw) in
                self.systemAlert(message: "비밀번호 변경이 완료되었습니다.", buttonTitle: "확인") {
                    Logger.showDebuggingMessage(pw)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
        }
        
        actionSheet.addAction(mobile)
        actionSheet.addAction(email)
        actionSheet.addAction(resetPW)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
}
