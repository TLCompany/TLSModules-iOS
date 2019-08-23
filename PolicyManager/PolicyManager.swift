//
//  PolicyManager.swift
//  Alamofire
//
//  Created by Justin Ji on 19/08/2019.
//

import UIKit

public class PolicyManager: VRTManager<Policy> {
    
    public var listBackgroundColor = UIColor.listBackground
    public var listItemBackgroundColor = UIColor.listRowBackground
    public var listViewTopInset: CGFloat = 8.0
    
    public var hInset: CGFloat = 20.0  {
        didSet {
            contentDetailData.hInset = hInset
        }
    }
    
    public var detailBackgroundColor: UIColor? {
        didSet {
            contentDetailData.backgroundColor = detailBackgroundColor
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
