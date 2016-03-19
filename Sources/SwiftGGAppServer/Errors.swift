//
//  Errors.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/18.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//


struct Errors {
    static let Code_Success = 0
    static let Msg_Success = "请求成功"
    
    static let Code_ParameterInvalid = -10000
    static let Msg_ParameterInvalid = "请求参数无效"
    
    static let Code_UserInValid = -10001
    static let Msg_UserInValid = "账号不存在,请重新输入"
    
    static let Code_UsernameInValid = -10002
    static let Msg_UsernameInValid = "用户名位数必须大于或等于\(Config.Constant_Username_Length)"
    
    static let Code_PasswordInValid = -10003
    static let Msg_PasswordInValid = "密码位数必须大于或等于\(Config.Constant_Password_Length)"

}
