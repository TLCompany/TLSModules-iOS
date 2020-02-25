//
//  PolicyDetailViewController.swift
//  TLSModules
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
internal class PolicyDetailViewController: ScrollingViewController {

    internal var policy: Policy?
    internal var contentDetailData: ContentDetailData?
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "정책사항 내용을 보여줍니다."
        label.textColor = .textContent
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var leadingEdgeConstraint: NSLayoutConstraint!
    private var trailingEdgeConstraint: NSLayoutConstraint!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = self.policy?.title
        contentLabel.text = policy?.content
        setUpLayout()
        setUpContentDetailData()
    }
    
    private func setUpContentDetailData() {
        guard let contentDetailData = self.contentDetailData else {
            print("\(#function), 😭 contentDetailData is nil...")
            return
        }
        
        view.backgroundColor = contentDetailData.backgroundColor
        contentLabel.textColor = contentDetailData.contentColor
        leadingEdgeConstraint.constant = contentDetailData.hInset
        trailingEdgeConstraint.constant = -contentDetailData.hInset
        view.layoutIfNeeded()
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        containerView.addSubview(contentLabel)
        leadingEdgeConstraint = contentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20.0)
        trailingEdgeConstraint = contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20.0)
        leadingEdgeConstraint.isActive = true
        trailingEdgeConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0),
            containerView.bottomAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20.0),
            ])
    }
}
