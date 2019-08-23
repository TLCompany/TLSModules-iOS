//
//  AnnouncementManager.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

public class AnnouncementManager: VRTManager<Announcement> {
    
    private let announcementListVC = AnnouncementListViewController()
    private var contentDetailData = ContentDetailData()
    
    public override func launch(with items: [Announcement]) {
        announcementListVC.announcements = items
        announcementListVC.contentDetailData = self.contentDetailData
        vc.navigationController?.pushViewController(announcementListVC, animated: true)
    }
    
    
    public var listBackgroundColor: UIColor? {
        didSet {
            announcementListVC.listBackgroundColor = listBackgroundColor
        }
    }
    
    public var listItemBackgroundColor: UIColor? {
        didSet {
            announcementListVC.listItemBackgroundColor = listItemBackgroundColor
        }
    }
    
    public var separatorColor: UIColor? {
        didSet {
            announcementListVC.separatorColor = separatorColor
            contentDetailData.separatorColor = separatorColor
        }
    }
    
    public var dateColor: UIColor? {
        didSet {
            announcementListVC.dateColor = dateColor
            contentDetailData.dateColor = dateColor
        }
    }
    
    public var hInset: CGFloat = 20.0  {
        didSet {
            announcementListVC.hInset = hInset
            contentDetailData.hInset = hInset
        }
    }
    
    public var detailBackgroundColor: UIColor? {
        didSet {
            contentDetailData.backgroundColor = detailBackgroundColor
        }
    }
    
    public var detailTitleColor: UIColor? {
        didSet {
            contentDetailData.titleColor = detailTitleColor
        }
    }
    
    public var detailTitleFont: UIFont? {
        didSet {
            contentDetailData.titleFont = detailTitleFont
        }
    }
    
    public var detailContentColor: UIColor? {
        didSet {
            contentDetailData.contentColor = detailContentColor
        }
    }
    
    public var detailContentFont: UIFont? {
        didSet {
            contentDetailData.contentFont = detailContentFont
        }
    }
}
