//
//  AnnouncementManager.swift
//  Alamofire
//
//  Created by Justin Ji on 15/08/2019.
//

import UIKit

public class AnnouncementManager: NSObject {
    
    private var vc: UIViewController
    
    public init(vc: UIViewController) {
        self.vc = vc
    }
    
    public func go(with announcements: [Announcement]) {
        
        let announcementListVC = AnnouncementListViewController()
        announcementListVC.announcements = announcements
        vc.navigationController?.pushViewController(announcementListVC, animated: true)
    }
    
}
