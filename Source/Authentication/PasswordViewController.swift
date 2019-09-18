//
//  PasswordViewController.swift
//  TLSModules
//
//  Created by Justin Ji on 29/08/2019.
//

import UIKit

/// 비밀번호 설정/재설정 화면의 Controller
public class PasswordViewController: AuthenticationViewController {

    public var goalType: PasswordGoalType = .register
    /// 비밀번호가 정상적으로 입력되고 사용자가 완료를 했을 때, 비밀번호를 return 하는 closure 변수
    public var completeAction: ((String) -> Void)?
    
    private let pwTextField: UnderlinedTextField = {
        let textField = UnderlinedTextField()
        textField.placeholder = "비밀번호를 입력해 주세요."
        textField.isSecureTextEntry = true
        textField.returnKeyType = UIReturnKeyType.next
        textField.addTarget(self, action: #selector(textInputChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let pw2TextField: UnderlinedTextField = {
        let textField = UnderlinedTextField()
        textField.placeholder = "비밀번호를 다시 한번 입력해 주세요."
        textField.isSecureTextEntry = true
        textField.returnKeyType = UIReturnKeyType.go
        textField.addTarget(self, action: #selector(textInputChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private var password: String?
    
    @objc
    private func textInputChanged(_ sender: UITextField) {
        guard let pw = pwTextField.text, !pw.isEmpty, let pw2 = pw2TextField.text, !pw2.isEmpty else {
            self.password = nil
            return
        }
        
        guard pw == pw2 else {
            warningMessage = "비밀번호가 일치하지 않습니다."
            self.password = nil
            return
        }
        
        guard pw.isValidAsPassword else {
            warningMessage = "비밀번호는 영문 + 숫자를 포함한 8자리 이상입니다."
            self.password = nil
            return
        }
        
        warningLabel.isHidden = true
        self.password = pw
        
    }
    
    private var warningMessage: String? {
        didSet {
            warningLabel.text = self.warningMessage
            warningLabel.isHidden = false
        }
    }
    
    private lazy var nextButton: RoundedSquareButton = {
        let button = RoundedSquareButton()
        button.setTitle(goalType.nextTitle, for: .normal)
        button.addTarget(self, action: #selector(touchNext(_:)), for: .touchUpInside)
        return button
    }()
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 일치하지 않습니다."
        label.textColor = .warning
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc
    private func touchNext(_ sender: RoundedSquareButton) {
       next()
    }
    
    private func next() {
        guard let pw = self.password else {
            systemAlert(message: "비밀번호를 올바르게 입력해 주세요.", buttonTitle: "확인")
            return
        }
        
        completeAction?(pw)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        pwTextField.delegate = self
        pw2TextField.delegate = self
        title = goalType.navTitle
        setDescription(title: goalType.title, subtitle: "영문 + 숫자를 포함한 8자리 이상을 입력해 주세요.")
        nextButton.backgroundColor = completeButtonBackgroundColor
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pwTextField.becomeFirstResponder()
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        view.addSubview(pwTextField)
        view.addSubview(pw2TextField)
        view.addSubview(warningLabel)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            pwTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            pwTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            pwTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20.0),
            pwTextField.heightAnchor.constraint(equalToConstant: 44.0),
            
            pw2TextField.leadingAnchor.constraint(equalTo: pwTextField.leadingAnchor),
            pw2TextField.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor),
            pw2TextField.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 12.0),
            pw2TextField.heightAnchor.constraint(equalToConstant: 44.0),
            
            warningLabel.leadingAnchor.constraint(equalTo: pwTextField.leadingAnchor),
            warningLabel.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor),
            warningLabel.topAnchor.constraint(equalTo: pw2TextField.bottomAnchor, constant: 12.0),
            
            nextButton.leadingAnchor.constraint(equalTo: pwTextField.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor),
            nextButton.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 32.0),
            nextButton.heightAnchor.constraint(equalToConstant: 44.0),
            ])
    }
}

extension PasswordViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case pwTextField:
            pwTextField.resignFirstResponder()
            pw2TextField.becomeFirstResponder()
        case pw2TextField:
            next()
        default: break
        }
        
        return true
    }
}
