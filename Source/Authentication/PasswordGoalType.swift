//
//  PasswordGoalType.swift
//  TLSModules
//
//  Created by Justin Ji on 29/08/2019.
//

import Foundation

@available(*, deprecated, message: "View-related classes are not supported.")
/// 비밀번호 화면(PasswordViewController)의 목표 타입: 회원가입인지 아니면 비밀번호 변경인지
enum PasswordGoalType {
    case register, reset
    
    var navTitle: String {
        switch self {
        case .register: return "회원가입"
        case .reset: return "비밀번호 재설정"
        }
    }
    
    var title: String {
        switch self {
        case .register: return "비밀번호 입력"
        case .reset: return "비밀번호 재설정"
        }
    }
    
    var nextTitle: String {
        switch self {
        case .register: return "회원가입"
        case .reset: return "재설정"
        }
    }
}
