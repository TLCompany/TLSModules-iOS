//
//  ListPopupViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 23/10/2019.
//

import UIKit

final public class ListPopupViewController: BasePopupViewController {
    
    // Public Properties
    
    public var selectAction: ((Int) -> Void)?
    
    /// 팝업창에 들어갈 리스트의 이름들
    public var list = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    /// 팝업 리스트의 아이템 Cell의 높이
    public var itemCellHeight: CGFloat = 44.0
    
    /// 팝업 상단의 메세지
    public var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    /// 하단 버튼의 title
    public var bottomButtonTitle: NSAttributedString? {
        didSet {
            bottomButton.setAttributedTitle(bottomButtonTitle, for: .normal)
        }
    }
    
    //MARK: UI Properties
    private let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "BBBBBB")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Popup Message"
        label.textAlignment = .center
        label.backgroundColor = UIColor.init(hexString: "F8F8F8").withAlphaComponent(0.82)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(hexString: "F8F8F8").withAlphaComponent(0.82)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "147AFD"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        button.addTarget(self, action: #selector(touchBottomButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.init(hexString: "BBBBBB")
        tableView.removeExtraEmptyCells()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var popupViewWidthConstraint: NSLayoutConstraint!
    private var popupViewHeightConstraint: NSLayoutConstraint!

    
    @objc
    private func touchBottomButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListPopupItemCell.self, forCellReuseIdentifier: ListPopupItemCell.id)
        setUpLayout()
        popupView.layer.cornerRadius = 10.0
        popupView.clipsToBounds = true
        adjustTableViewHeight()
    }
    
    private func adjustTableViewHeight() {
        if list.count <= 3 {
            popupViewHeightConstraint.constant = 239.0
        } else {
            popupViewHeightConstraint.constant = 344.5
        }
        view.layoutIfNeeded()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        popupView.isHidden = false
        show(popupView: popupView)
    }
    
    private func setUpLayout() {
        view.addSubview(popupView)
        popupView.addSubview(messageLabel)
        popupView.addSubview(bottomButton)
        popupView.addSubview(tableView)
        
        popupViewWidthConstraint = popupView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72)
        popupViewHeightConstraint = popupView.heightAnchor.constraint(equalToConstant: 360.0)
        popupViewWidthConstraint.isActive = true
        popupViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: popupView.topAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 58.0),
            
            bottomButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor),
            bottomButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            tableView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 1.0),
            tableView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -1.0),
            
        ])
    }

}

extension ListPopupViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListPopupItemCell.id, for: indexPath) as! ListPopupItemCell
        cell.title = list[indexPath.section]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemCellHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismiss(animated: true) { self.selectAction?(indexPath.section) }
        }
    }
}
