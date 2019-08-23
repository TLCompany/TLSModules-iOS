//
//  InqueryManager.swift
//  TLSModules
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

public class InqueryManager: VRTManager<Inquery> {
    
    public var newAction: ((String) -> Void)?
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
    
    public var answerBackgroundColor = UIColor.init(hexString: "2359CB") {
        didSet {
            contentDetailData.answerBackgroundColor = self.answerBackgroundColor
        }
    }
    
    public var answerTextColor = UIColor.white {
        didSet {
            contentDetailData.answerTextColor = self.answerTextColor
        }
    }
    
    public var answerFont = UIFont.systemFont(ofSize: 13.0, weight: .regular) {
        didSet {
            contentDetailData.answerFont = self.answerFont
        }
    }
    
    public var answeredColor = UIColor.init(hexString: "BA0000")
    public var unansweredColor = UIColor.init(hexString: "304786")
    
    private var contentDetailData = InqueryDetailData()
    private let inqueryListVC = InqueryListViewController()
    
    override public func launch(with items: [Inquery]) {
        inqueryListVC.inqueries = items
        inqueryListVC.newAction = {
            let newInqueryVC = NewInqueryViewController()
            newInqueryVC.completeAction = { [unowned self] inqueryText in
                self.newAction?(inqueryText)
            }
            self.inqueryListVC.navigationController?.pushViewController(newInqueryVC, animated: true)
        }
        inqueryListVC.listViewTopInset = self.listViewTopInset
        inqueryListVC.listBackgroundColor = self.listBackgroundColor
        inqueryListVC.listItemBackgroundColor = self.listItemBackgroundColor
        inqueryListVC.answeredColor = self.answeredColor
        inqueryListVC.unansweredColor = self.unansweredColor
        inqueryListVC.contentDetailData = self.contentDetailData
        vc.navigationController?.pushViewController(inqueryListVC, animated: true)
    }
    
    public func refresh(with items: [Inquery]) {
        inqueryListVC.inqueries = items
    }
    
}
