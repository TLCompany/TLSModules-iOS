//
//  InqueryManager.swift
//  TLSModules
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

/// 문의사항 리스트/디테일/작성 화면들의 매니져
public class InqueryManager: VRTManager<Inquery> {
    
    /// 새로운 문의사항이 작성되었을 때 Event Action, 문의사항 내용의 문자열을 Return한다.
    public var newAction: ((String) -> Void)?
    /// 문의사항 리스트 화면에서 TableView의 backgroundColor
    public var listBackgroundColor = UIColor.listBackground
    /// 문의사항 리스트 아이템 화면의 backgroundColor
    public var listItemBackgroundColor = UIColor.listRowBackground
    /// 문의사항 TableView의 상단과 전체 화면의 상단의 간격
    public var listViewTopInset: CGFloat = 8.0
    
    /// 문의사항 리스트 아이템 화면 또는 디테일 화면의 왼쪽/오른쪽 Margin값
    public var hInset: CGFloat = 20.0  {
        didSet {
            contentDetailData.hInset = hInset
        }
    }
    
    /// 문의사항 디테일 화면의 backgroundColor
    public var detailBackgroundColor: UIColor? {
        didSet {
            contentDetailData.backgroundColor = detailBackgroundColor
        }
    }
    
    /// 문의사항 디테일 화면의 문의사항 내용(content)의 글자 색
    public var detailContentColor: UIColor? {
        didSet {
            contentDetailData.contentColor = detailContentColor
        }
    }
    
    /// 문의사항 디테일 화면의 문의사항 내용(content)의 글자 font
    public var detailContentFont: UIFont? {
        didSet {
            contentDetailData.contentFont = detailContentFont
        }
    }
    
    /// 문의사항 디테일 화면의 대답의 backgroundColor
    public var answerBackgroundColor = UIColor.init(hexString: "2359CB") {
        didSet {
            contentDetailData.answerBackgroundColor = self.answerBackgroundColor
        }
    }
    
    /// 문의사항 디테일 화면의 대답의 글자색
    public var answerTextColor = UIColor.white {
        didSet {
            contentDetailData.answerTextColor = self.answerTextColor
        }
    }
    
    /// 문의사항 디테일 화면의 대답의 글자 font
    public var answerFont = UIFont.systemFont(ofSize: 13.0, weight: .regular) {
        didSet {
            contentDetailData.answerFont = self.answerFont
        }
    }
    
    
    /// 문의사항 리스트의 아이템 화면에서 대답상태 글자색 - 완료
    public var answeredColor = UIColor.init(hexString: "BA0000")
    /// /// 문의사항 리스트의 아이템 화면에서 대답상태 글자색 - 미완료
    public var unansweredColor = UIColor.init(hexString: "304786")
    
    //Private Properties
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
    
    /// 문의사항의 리스트 데이터 모델을 다시 넣어준다.
    ///
    /// - Parameter items: 문의사항 데이터 모델 배열
    public func refresh(with items: [Inquery]) {
        inqueryListVC.inqueries = items
    }
    
}
