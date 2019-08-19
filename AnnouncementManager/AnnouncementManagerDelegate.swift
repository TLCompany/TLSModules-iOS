//
//  AnnouncementManagerDelegate.swift
//  Alamofire
//
//  Created by Justin Ji on 19/08/2019.
//

import UIKit

@objc
public protocol AnnouncementManagerDelegate: class {
    
    /// 공지사항 TableView의 백그라운드 색
    @objc optional func setListBackgroundColor(_ announcementManager: AnnouncementManager) -> UIColor?
    /// 각 공지사항의 cell의 separator 색
    @objc optional func setSeparatorColor(_ announcementManager: AnnouncementManager) -> UIColor?
}
