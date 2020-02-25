//
//  PolicyManager.swift
//  Alamofire
//
//  Created by Justin Ji on 19/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
class PolicyManager: VRTManager<Policy> {
    
    /// 정책사항 리스트 화면에서 TableView의 backgroundColor
    public var listBackgroundColor = UIColor.listBackground
    /// 정책사항 리스트 아이템 화면의 backgroundColor
    public var listItemBackgroundColor = UIColor.listRowBackground
    /// 정책사항 TableView의 상단과 전체 화면의 상단의 간격
    public var listViewTopInset: CGFloat = 8.0
    
    /// 정책사항 리스트 아이템 화면 또는 디테일 화면의 왼쪽/오른쪽 Margin값
    public var hInset: CGFloat = 20.0  {
        didSet {
            contentDetailData.hInset = hInset
        }
    }
    
    /// 정책사항 디테일 화면의 backgroundColor
    public var detailBackgroundColor: UIColor? {
        didSet {
            contentDetailData.backgroundColor = detailBackgroundColor
        }
    }
    
    /// 정책사항 디테일 화면의 정책내용(content)의 글자 색
    public var detailContentColor: UIColor? {
        didSet {
            contentDetailData.contentColor = detailContentColor
        }
    }
    
    /// 정책사항 디테일 화면의 정책내용(content)의 글자 font
    public var detailContentFont: UIFont? {
        didSet {
            contentDetailData.contentFont = detailContentFont
        }
    }
    
    private var contentDetailData = ContentDetailData()
    
    
    public override func launch(with items: [Policy]) {
        
        let policyListVC = PolicyListViewController()
        policyListVC.policies = items
        policyListVC.listViewTopInset = self.listViewTopInset
        policyListVC.listBackgroundColor = self.listBackgroundColor
        policyListVC.listItemBackgroundColor = self.listItemBackgroundColor
        policyListVC.contentDetailData = self.contentDetailData
        vc.navigationController?.pushViewController(policyListVC, animated: true)
    }
}
