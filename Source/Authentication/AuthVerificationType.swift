//
//  AuthVerificationType.swift
//  TLSModules
//
//  Created by Justin Ji on 29/08/2019.
//

import UIKit

/// 인증타입: 이메일인지 모바일 번호인지
public enum AuthVerificationType: String {
    case email = "이메일"
    case mobile = "휴대폰 번호"
    
    var preposition: String {
        switch self {
        case .email: return "을"
        case .mobile: return "를"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email: return .emailAddress
        case .mobile: return .numberPad
        }
    }
    
    var placeholder: String {
        switch self {
        case .email: return "ex) myemail@gmail.com"
        case .mobile: return "01012345678"
        }
    }
    
    var title: String {
        switch self {
        case .email: return "이메일 인증"
        case .mobile: return "휴대폰 번호 인증"
        }
    }
    
    var subtitle: String {
        switch self {
        case .email: return "인증 된 이메일은 고객님의 아이디로 사용됩니다."
        case .mobile: return "회원가입을 위해서 휴대폰 번호를 인증해 주세요."
        }
    }
}

/// 인증의 목적 타입
///
/// - register: 회원가입
/// - reset: 비밀번호 재설정
public enum VerificationGoalType {
    case register
    case reset
}
