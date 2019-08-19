//
//  AnnouncementManager.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

public class AnnouncementManager: NSObject {
    
    public weak var delegate: AnnouncementManagerDelegate? {
        didSet {
            if let delegate = self.delegate {
                let listBackgroundColor = delegate.setListBackgroundColor?(self)
                let separatorColor = delegate.setSeparatorColor?(self)
                announcementListVC.listBackgroundColor = listBackgroundColor
                announcementListVC.separatorColor = separatorColor
            }
        }
    }
    
    private let announcementListVC = AnnouncementListViewController()
    private var vc: UIViewController
    
    public init(vc: UIViewController) {
        self.vc = vc
    }
    
    public func go(with announcements: [Announcement]) {
        
        announcementListVC.announcements = announcements
        vc.navigationController?.pushViewController(announcementListVC, animated: true)
    }
    
}
