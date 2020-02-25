//
//  NewInqueryViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 22/08/2019.
//

import UIKit

@available(*, deprecated, message: "View-related classes are not supported.")
/// 새로운 문의사항 작성 화면 Controller
class NewInquiryViewController: UIViewController {
    
    internal var completeAction: ((String) -> Void)?
    
    private let inqueryTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        textView.layer.cornerRadius = 5.0
        textView.isScrollEnabled = true
        textView.contentInset = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        textView.attributedText = NSAttributedString.placeholder(text: "문의할 내용을 입력해 주세요.")
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var leadingEdgeConstraint: NSLayoutConstraint!
    private var trailingEdgeConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "문의하기"
        view.backgroundColor = UIColor.listBackground
        inqueryTextView.delegate = self
        let sendButton = UIBarButtonItem(title: "보내기", style: .plain, target: self, action: #selector(touchSend(_:)))
        navigationItem.rightBarButtonItem = sendButton
        setUpLayout()
    }
    
    private func setUpLayout() {
        view.addSubview(inqueryTextView)
        
        leadingEdgeConstraint = inqueryTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0)
        trailingEdgeConstraint = inqueryTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0)
        leadingEdgeConstraint.isActive = true
        trailingEdgeConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            inqueryTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            inqueryTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            ])
    }

    @objc
    private func touchSend(_ sender: UIBarButtonItem) {
        guard let inquery = self.inqueryTextView.text, !inquery.isEmpty else {
            systemAlert(message: "문의사항을 입력해 주세요.", buttonTitle: "확인")
            return
        }
        
        systemAlert(message: "문의가 완료되었습니다.", buttonTitle: "확인") {
            self.completeAction?(inquery)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        inqueryTextView.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        inqueryTextView.resignFirstResponder()
        view.endEditing(true)
        inqueryTextView.attributedText = NSAttributedString.placeholder(text: "문의할 내용을 입력해 주세요.")
    }
}

extension NewInquiryViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textView.attributedText = NSAttributedString.lineSpaced(by: 8.0, text: textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholder {
            textView.attributedText = NSAttributedString.lineSpaced(by: 8.0, text: "")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.attributedText = NSAttributedString.placeholder(text: "문의할 내용을 입력해 주세요.")
        }
    }
}
