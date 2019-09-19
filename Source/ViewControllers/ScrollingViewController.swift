//
//  ScrollingViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 16/08/2019.
//

import UIKit

/// 전체 View Controller의 화면이 ScrollView로 되어있다.
open class ScrollingViewController: UIViewController {

    public let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    public let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal var containerHeightConstraint: NSLayoutConstraint!
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpLayout()
    }

    open func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            ])
    }
    
}
