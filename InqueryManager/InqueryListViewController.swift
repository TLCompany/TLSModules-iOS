//
//  InqueryListViewController.swift
//  TLSModules
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

internal class InqueryListViewController: ListViewController {
    
    internal var inqueries = [Inquery]() {
        didSet {
            tableView.reloadData()
        }
    }
    internal var contentDetailData: InqueryDetailData?
    internal var newAction: (() -> Void)?
    internal var answeredColor = UIColor.init(hexString: "BA0000")
    internal var unansweredColor = UIColor.init(hexString: "304786")
    
    internal var listBackgroundColor = UIColor.listBackground {
        didSet {
            tableView.backgroundColor = listBackgroundColor
        }
    }
    
    internal var hInset: CGFloat = 20.0 {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    internal var listViewTopInset: CGFloat = 8.0 {
        didSet {
            tableView.contentInset = UIEdgeInsets(top: listViewTopInset, left: 0, bottom: 0, right: 0)
        }
    }
    
    internal var listItemBackgroundColor = UIColor.listRowBackground {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "문의 리스트"
        let inqueryButton = UIBarButtonItem(title: "문의하기", style: .plain, target: self, action: #selector(touchNewInquery(_:)))
        navigationItem.rightBarButtonItem = inqueryButton
        noItemDescription = "문의사항이 없습니다."
        tableView.register(InqueryItemCell.self, forCellReuseIdentifier: InqueryItemCell.id)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc
    private func touchNewInquery(_ sender: UIBarButtonItem) {
        newAction?()
    }
}

extension InqueryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inqueries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InqueryItemCell.id, for: indexPath) as? InqueryItemCell else {
            return UITableViewCell()
        }
        
        cell.inquery = inqueries[indexPath.row]
        cell.hInset = self.hInset
        cell.answeredColor = self.answeredColor
        cell.unansweredColor = self.unansweredColor
        cell.backgroundColor = self.listItemBackgroundColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InqueryItemCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? InqueryItemCell else {
            return
        }
        cell.isSelected = !cell.isSelected
        
        let inqueryDetailVC = InqueryDetailViewController()
        inqueryDetailVC.inquery = inqueries[indexPath.row]
        inqueryDetailVC.contentDetailData = self.contentDetailData
        navigationController?.pushViewController(inqueryDetailVC, animated: true)
    }
}
