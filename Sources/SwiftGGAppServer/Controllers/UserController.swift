//
//  UserController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor
import MySQL
import CryptoSwift
import SwiftyJSON
import Regex

class UserController : Controller {

    struct Options: ConnectionOption {
        let host: String
        let port: Int
        let user: String
        let password: String
        let database: String
    }

    private let pool:ConnectionPool = {
        let options = Options(host: "123.57.250.194", port: 3306, user: "swiftggapp", password: "SwiftGG123", database: "swiftggapp")
        return ConnectionPool(options: options)
    }()

    required init() {

    }

    func newLoginV1(request: Request, username: String, password: String) throws -> ResponseConvertible {
         print("the username is \(username) and password \(password)")
        return try login(username, password)
    }

    func loginV1(request: Request) throws -> ResponseConvertible {

        let params = request.data.query
        let username = params["username"]
        let password = params["password"]

        return try login(username, password)
    }

    func otherLoginV1(request: Request) throws -> ResponseConvertible {
        return ""
    }

    func registerV1(request: Request) throws -> ResponseConvertible {
        return try Json(["lub": "dub"])
    }

    func getInfoV1(request: Request) throws -> ResponseConvertible {

        let (rows, _): ([User], QueryStatus) = try pool.execute { conn in
            try conn.query("SELECT id,account,password,nickname FROM sg_user;") as ([User], QueryStatus)
        }

        print(rows)

        let result = try rows.map { try Json(["username": $0.username]) }
        print(result)

        return Json(result)
    }

}


extension UserController {

    func login(theUsername: String?, _ thePassword: String?) throws -> ResponseConvertible {

        // 参数判空
        guard let username = theUsername, password = theUsername else {
            return try commonResponse(code: Errors.Code_ParameterInvalid, message: Errors.Msg_ParameterInvalid)
        }

        //用户名验证（允许使用小写字母、数字、下滑线、横杠，一共3~16个字符）
        // 判断是否含有特殊字符
        if username !~ "^[a-z0-9_-]{3,16}$" {
            return try commonResponse(code: Errors.Code_UsernameInvalid, message: Errors.Msg_UsernameInvalid)
        }

        // 判断长度
        if username.characters.count < Config.Constant_Username_Length {
            return try commonResponse(code: Errors.Code_UsernameLengthInValid, message: Errors.Msg_UsernameLengthInValid)
        }
        
        if password.characters.count < Config.Constant_Password_Length {
            return try commonResponse(code: Errors.Code_PasswordLengthInValid, message: Errors.Msg_PasswordLengthInValid)
        }        
        
        let queryParams = ( username )

        let (users, _): ([User], QueryStatus) = try pool.execute { conn in
            try conn.query("SELECT id,account,password,salt,nickname FROM sg_user where account = ?", build(queryParams)) as ([User], QueryStatus)
        }


        var finalUser: User?

        for user in users {
            let md5Password = user.password;
            let salt = user.salt
            if md5Password == (password + salt).md5() {
                finalUser = user
                break;
            }
        }

        if let result = finalUser {
            let responseData = ["userId": String(result.id)]
            return try commonResponse(responseData: responseData)
        } else {
            return try commonResponse(code: Errors.Code_UserInValid, message: Errors.Msg_UserInValid)
        }
    }

}
