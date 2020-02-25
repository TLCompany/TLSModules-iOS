//
//  PolicyListViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
internal class PolicyListViewController: ListViewController {

    internal var policies = [Policy]()
    internal var contentDetailData: ContentDetailData?
    
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
        
        title = "정책사항"
        noItemDescription = "등록된 정책사항 목록이 없습니다."
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RightArrowItemCell.self, forCellReuseIdentifier: RightArrowItemCell.id)
    }
    
    
}

extension PolicyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return policies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RightArrowItemCell.id, for: indexPath) as? RightArrowItemCell else {
            return UITableViewCell()
        }
        
        cell.title = policies[indexPath.row].title
        cell.hInset = self.hInset
        cell.backgroundColor = self.listItemBackgroundColor
        cell.separatorColor = self.listBackgroundColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RightArrowItemCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RightArrowItemCell else {
            return
        }
        cell.isSelected = !cell.isSelected
        
        let policyDetailVC = PolicyDetailViewController()
        policyDetailVC.policy = policies[indexPath.row]
        policyDetailVC.contentDetailData = self.contentDetailData
        navigationController?.pushViewController(policyDetailVC, animated: true)
    }
}
