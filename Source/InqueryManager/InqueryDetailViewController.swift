//
//  InqueryDetailViewController.swift
//  TLSModules
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

/// 문의사항 디테일 화면 Controller
internal class InquiryDetailViewController: ScrollingViewController {

    //Internal Properties
    internal var inquery: Inquiry?
    internal var contentDetailData: InquiryDetailData?
    
    //Private Properties
    private let separator = SeparatorView()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "0000.00.00"
        label.textColor = .date
        label.adjustsFontForContentSizeCategory = true
        let font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "문의사항의 내용을 보여줍니다."
        label.textColor = .textContent
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.text = "문의사항의 답변을 보여줍니다."
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let answerBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = UIColor.init(hexString: "2359CB")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var leadingEdgeConstraint: NSLayoutConstraint!
    private var trailingEdgeConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "나의 문의"
        setUpInquery()
        setUpContentDetailData()
    }
    
    private func setUpContentDetailData() {
        guard let contentDetailData = self.contentDetailData else {
            print("\(#function), 😭 contentDetailData is nil...")
            return
        }
    
        view.backgroundColor = contentDetailData.backgroundColor
        contentLabel.textColor = contentDetailData.contentColor
        answerLabel.textColor = contentDetailData.answerTextColor
        answerBackgroundView.backgroundColor = contentDetailData.answerBackgroundColor
        
    }
    
    private func setUpInquery() {
        guard let inquery = self.inquery else {
            return
        }
        
        dateLabel.text = inquery.date.formattedDateString
        contentLabel.text = inquery.content
        answerLabel.text = inquery.answer
        separator.isHidden = !inquery.isAnswered
        answerLabel.isHidden = !inquery.isAnswered
        answerBackgroundView.isHidden = !inquery.isAnswered
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        containerView.addSubview(dateLabel)
        containerView.addSubview(separator)
        containerView.addSubview(contentLabel)
        containerView.addSubview(answerBackgroundView)
        containerView.addSubview(answerLabel)
        
        leadingEdgeConstraint = dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20.0)
        trailingEdgeConstraint = dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20.0)
        leadingEdgeConstraint.isActive = true
        trailingEdgeConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            
            
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0),
            
            contentLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            contentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12.0),
            
            separator.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            separator.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 12.0),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            
            answerLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: 8.0),
            answerLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: -8.0),
            answerLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 14.0),
            
            answerBackgroundView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            answerBackgroundView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            answerBackgroundView.topAnchor.constraint(equalTo: answerLabel.topAnchor, constant: -8.0),
            answerBackgroundView.bottomAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 8.0),
            
            containerView.bottomAnchor.constraint(equalTo: answerBackgroundView.bottomAnchor, constant: 12.0)
            ])
    }
}
