//
//  EmailVerificationViewController.swift
//  Alamofire
//
//  Created by Justin Ji on 29/08/2019.
//

import UIKit

/// Authentication 관련된 인증(이메일 또는 모바일) View Controller
public class AuthVerificationViewController: AuthenticationViewController {
    
    public var verificationType: AuthVerificationType = .email
    public var verificationGoalType: VerificationGoalType = .register
    /// 인증 완료 Event Action
    public var completeAction: ((String) -> Void)?
    /// 사용자가 이메일 또는 모바일 번호를 입력하고 인증번호를 받으려는 Event Action
    public var sendAction: ((String) -> Void)?
    
    /// 인증번호를 앱 프로젝트에서 
    ///
    /// - Parameter isSuccessful: <#isSuccessful description#>
    public func handleVCodeSent(by isSuccessful: Bool) {
        if isSuccessful {
            systemAlert(message: "인증번호가 보내졌습니다.", buttonTitle: "확인") {
                self.verificationTextField.becomeFirstResponder()
            }
        } else {
            systemAlert(message: "인증번호 보내기 실패...", buttonTitle: "확인")
        }
    }
    
    private let requestManager = RequestManager()
    
    private let inputTextField: UnderlinedTextField = {
        let textField = UnderlinedTextField()
        textField.returnKeyType = UIReturnKeyType.go
        textField.addTarget(self, action: #selector(textInputChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    @objc
    private func textInputChanged(_ sender: UITextField) {
        switch sender {
        case self.inputTextField:
            vcode = nil
            verificationTextField.text = ""
        default: return
        }
    }
    
    private let verificationTextField: UnderlinedTextField = {
        let textField = UnderlinedTextField()
        textField.placeholder = "인증번호"
        textField.returnKeyType = UIReturnKeyType.next
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let sendButton: RoundedSquareButton = {
        let button = RoundedSquareButton()
        button.setTitle("보내기", for: .normal)
        button.addTarget(self, action: #selector(touchSend(_:)), for: .touchUpInside)
        return button
    }()
    
    private var vcode: String?
    
    @objc
    private func touchSend(_ sender: RoundedSquareButton) {
       send()
    }
    
    private func send() {
        guard let input = inputTextField.text, !input.isEmpty else {
            systemAlert(message: "\(verificationType.rawValue)\(verificationType.preposition) 입력해 주세요.", buttonTitle: "확인") {
                self.inputTextField.becomeFirstResponder()
            }
            return
        }
        
        if verificationType == .email {
            guard input.isValidAsEmail else {
                systemAlert(message: "이메일 형식에 맞춰서 입력해 주세요.", buttonTitle: "확인") {
                    self.inputTextField.becomeFirstResponder()
                }
                return
            }
        }
        
        self.sendAction?(input)
    }
    
    private let verifyButton: RoundedSquareButton = {
        let button = RoundedSquareButton()
        button.setTitle("인증", for: .normal)
        button.addTarget(self, action: #selector(touchVerify(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func touchVerify(_ sender: RoundedSquareButton) {
        verify()
    }
    
    private func verify() {
        guard let input = inputTextField.text, let generatedOne = self.vcode else {
            systemAlert(message: "\(verificationType.rawValue)\(verificationType.preposition) 입력하고 보내기 버튼을 먼저 눌러주세요.", buttonTitle: "확인") {
                self.inputTextField.becomeFirstResponder()
            }
            return
        }
        
        guard let enteredOne = verificationTextField.text, !enteredOne.isEmpty else {
            systemAlert(message: "인증번호를 입력해 주세요.", buttonTitle: "확인") {
                self.verificationTextField.becomeFirstResponder()
            }
            return
        }
        
        guard generatedOne == enteredOne else {
            systemAlert(message: "입력하신 인증번호가 올바르지 않습니다.", buttonTitle: "확인")
            return
        }
        
        systemAlert(message: "인증이 완료되었습니다.", buttonTitle: "확인") {
            self.verificationTextField.text = ""
            self.vcode = nil
            if self.verificationGoalType == .register {
                self.completeAction?(input)
            } else {
                let passwordVC = PasswordViewController()
                passwordVC.goalType = .reset
                passwordVC.completeAction = self.completeAction
                self.navigationController?.pushViewController(passwordVC, animated: true)
            }
        }
    }
    
    private let nextButton: RoundedSquareButton = {
        let button = RoundedSquareButton()
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(touchVerify(_:)), for: .touchUpInside)
        return button
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        title = "회원가입"
        inputTextField.keyboardType = verificationType.keyboardType
        inputTextField.placeholder = verificationType.placeholder
        verifyButton.backgroundColor = completeButtonBackgroundColor
        nextButton.backgroundColor = completeButtonBackgroundColor
    }
    
    override func setDescription(title: String, subtitle: String) {
        if verificationGoalType == .register {
            titleLabel.text = verificationType.title
            subtitleLabel.text = verificationType.subtitle
        } else {
            titleLabel.text = "비밀번호 찾기"
            subtitleLabel.text = "가입하실 때, 인증하신 \(verificationType.rawValue)로 인증해 주세요."
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        inputTextField.becomeFirstResponder()
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        view.addSubview(sendButton)
        view.addSubview(inputTextField)
        view.addSubview(verificationTextField)
        view.addSubview(verifyButton)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            sendButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20.0),
            sendButton.widthAnchor.constraint(equalToConstant: 80.0),
            sendButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            inputTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            inputTextField.topAnchor.constraint(equalTo: sendButton.topAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -20.0),
            inputTextField.bottomAnchor.constraint(equalTo: sendButton.bottomAnchor),
            
            verifyButton.trailingAnchor.constraint(equalTo: sendButton.trailingAnchor),
            verifyButton.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 12.0),
            verifyButton.widthAnchor.constraint(equalTo: sendButton.widthAnchor),
            verifyButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor),
            
            verificationTextField.leadingAnchor.constraint(equalTo: inputTextField.leadingAnchor),
            verificationTextField.topAnchor.constraint(equalTo: verifyButton.topAnchor),
            verificationTextField.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor),
            verificationTextField.bottomAnchor.constraint(equalTo: verifyButton.bottomAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            nextButton.topAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 32.0),
            nextButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            ])
    }

}

