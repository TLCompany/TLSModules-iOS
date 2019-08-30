
//
//  ListViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 20/08/2019.
//

import UIKit

open class ListViewController: UIViewController {

    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.removeExtraEmptyCells()
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .listBackground
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public let noListItemsLabel: UILabel = {
        let label = UILabel()
        label.text = "No List Items"
        label.textColor = .textContent
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var noItemDescription: String? {
        didSet {
            noListItemsLabel.text = noItemDescription
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpLayout()
    }
    
    public func setUpLayout() {
        view.addSubview(tableView)
        view.addSubview(noListItemsLabel)
        
        tableView.fillUp()
        noListItemsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noListItemsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
