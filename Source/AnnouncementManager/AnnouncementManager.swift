//
//  AnnouncementManager.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
/// 공지사항 리스트/디테일 화면들의 매니져
public class AnnouncementManager: VRTManager<Announcement> {
    
    private let announcementListVC = AnnouncementListViewController()
    private var contentDetailData = ContentDetailData()
    
    
    /// 공지사항의 데이터 모델의 배열을 가지고 리스트 화면을 push 한다.
    ///
    /// - Parameter items: 공지사항 데이터 모델의 배열
    public override func launch(with items: [Announcement]) {
        announcementListVC.announcements = items
        announcementListVC.listBackgroundColor = listBackgroundColor
        announcementListVC.listItemBackgroundColor = listItemBackgroundColor
        announcementListVC.listViewTopInset = listViewTopInset
        announcementListVC.separatorColor = separatorColor
        announcementListVC.dateColor = dateColor
        announcementListVC.hInset = hInset
        announcementListVC.contentDetailData = contentDetailData
        vc.navigationController?.pushViewController(announcementListVC, animated: true)
    }
    
    /// 공지사항 TableView의 상단과 전체 화면의 상단의 간격
    public var listViewTopInset: CGFloat = 8.0
    /// 공지사항 리스트 화면에서 TableView의 backgroundColor
    public var listBackgroundColor: UIColor?
    /// 공지사항 리스트 아이템 화면의 backgroundColor
    public var listItemBackgroundColor: UIColor?
    
    /// 공지사항 리스트 아이템 화면의 하단 구분선 색
    public var separatorColor: UIColor? {
        didSet {
            contentDetailData.separatorColor = separatorColor
        }
    }
    
    /// 공지사항 리스트 아이템 화면의 날짜의 글자색
    public var dateColor: UIColor? {
        didSet {
            contentDetailData.dateColor = dateColor
        }
    }
    
    /// 공지사항 리스트 아이템 화면의 왼쪽/오른쪽 Margin값
    public var hInset: CGFloat = 20.0  {
        didSet {
            contentDetailData.hInset = hInset
        }
    }
    
    /// 공지사항 디테일 화면의 backgroundColor
    public var detailBackgroundColor: UIColor? {
        didSet {
            contentDetailData.backgroundColor = detailBackgroundColor
        }
    }
    
    /// 공지사항 디테일 화면의 제목(title)의 글자 색
    public var detailTitleColor: UIColor? {
        didSet {
            contentDetailData.titleColor = detailTitleColor
        }
    }
    
    /// 공지사항 디테일 화면의 제목(title)의 글자 font
    public var detailTitleFont: UIFont? {
        didSet {
            contentDetailData.titleFont = detailTitleFont
        }
    }
    
    /// 공지사항 디테일 화면의 문의사항 내용(content)의 글자 색
    public var detailContentColor: UIColor? {
        didSet {
            contentDetailData.contentColor = detailContentColor
        }
    }
    
    /// 공지사항 디테일 화면의 문의사항 내용(content)의 글자 font
    public var detailContentFont: UIFont? {
        didSet {
            contentDetailData.contentFont = detailContentFont
        }
    }
}
