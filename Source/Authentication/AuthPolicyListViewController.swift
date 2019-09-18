//
//  PolicyListViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 27/08/2019.
//

import UIKit

/// 정책사항 동의 화면
public class AuthPolicyListViewController: AuthenticationViewController  {

    /// 해당 서비스의 정책사항들
    public var policies = [Policy]()
    
    /// 동의를 다 했을 때의 Event Action
    public var completeAction: (() -> Void)?
    
    /// 선택 정책이 가장 아래로 내려가게 한 정책 배열
    private var sortedPolicies: [Policy] {
        return policies.sorted {
            switch ($0.isMandatory, $1.isMandatory) {
            case (true, true): return false
            case (true, false): return true
            case (false, true): return false
            case (false, false): return false
            }
        }
    }
    
    private var mandatoryOnes: [Policy] {
        return policies.compactMap {
            return $0.isMandatory ? $0 : nil
        }
    }
        
    private let feedbackGenerator = UIImpactFeedbackGenerator()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.removeExtraEmptyCells()
        tableView.contentInset = UIEdgeInsets(top: 4.0, left: 0, bottom: 4, right: 0)
        tableView.bounces = false
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 5.0
        tableView.layer.borderColor = UIColor.init(hexString: "707070").cgColor
        tableView.layer.borderWidth = 0.5
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let allAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = "모두 동의하기"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let allAgreeButton: UIButton = {
        let button = UIButton()
        let nImage = ResourcesProvider.image(by: "checkbox_unchecked")
        let sImage = ResourcesProvider.image(by: "checkbox_checked")
        button.setImage(nImage, for: .normal)
        button.setImage(sImage, for: .selected)
        button.setTitle(" 동의", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(touchAgree(_:)), for: .touchUpInside)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc
    private func touchAgree(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        var count = mandatoryOnes.count - 1
        count = count == 0 ? 1 : count
        [Int](0...count).forEach {
            let cell = tableView.cellForRow(at: IndexPath(row: $0, section: 0)) as? AuthPolicyListItemCell
            cell?.isAgreed = sender.isSelected
        }
        self.agreeCount = sender.isSelected ? mandatoryOnes.count : 0
        feedbackGenerator.impactOccurred()
    }
    
    private let nextButton: RoundedSquareButton = {
        let button = RoundedSquareButton()
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(touchNext(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func touchNext(_ sender: RoundedSquareButton) {
        guard allAgreeButton.isSelected else {
            systemAlert(message: "모든 필수약관에 동의를 해 주세요.", buttonTitle: "확인")
            return
        }
        
        completeAction?()
    }
    
    private var agreeCount: Int = 0 {
        didSet {
            Logger.showDebuggingMessage(at: #function, "\(agreeCount)")
            allAgreeButton.isSelected = self.agreeCount == mandatoryOnes.count ? true : false
            if self.agreeCount == mandatoryOnes.count {
                feedbackGenerator.impactOccurred()
            }
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        title = "회원가입"
        setDescription(title: "약관동의", subtitle: "필수 약관을 읽어보시고 동의를 해주세요.")
        setUpTableView()
        nextButton.backgroundColor = completeButtonBackgroundColor
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        view.addSubview(tableView)
        view.addSubview(allAgreeLabel)
        view.addSubview(allAgreeButton)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20.0),
            tableView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(policies.count) * AuthPolicyListItemCell.height + 8.0),
            
            allAgreeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0),
            allAgreeLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16.0),
            
            allAgreeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0),
            allAgreeButton.centerYAnchor.constraint(equalTo: allAgreeLabel.centerYAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            nextButton.topAnchor.constraint(equalTo: allAgreeLabel.bottomAnchor, constant: 32.0),
            nextButton.heightAnchor.constraint(equalToConstant: 44.0),
            ])
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuthPolicyListItemCell.self, forCellReuseIdentifier: AuthPolicyListItemCell.id)
    }
}

extension AuthPolicyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPolicies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthPolicyListItemCell.id, for: indexPath) as? AuthPolicyListItemCell else {
            Logger.showError(at: #function, type: .unsafelyWrapped(taget: "cell"))
            return UITableViewCell()
        }
        
        cell.row = indexPath.row
        cell.policy = sortedPolicies[indexPath.row]
        
        cell.agreeAction = { [unowned self] isSelected in
            self.agreeCount += isSelected ? 1 : -1
        }
        
        cell.titleAction = { [unowned self] policy in
            let policyDetailVC = PolicyDetailViewController()
            policyDetailVC.policy = policy
            self.navigationController?.pushViewController(policyDetailVC, animated: true)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AuthPolicyListItemCell.height
    }
}
