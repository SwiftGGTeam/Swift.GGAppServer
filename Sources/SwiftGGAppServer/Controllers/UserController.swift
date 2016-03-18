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
        return try login(username, password: password)
    }

    func loginV1(request: Request) throws -> ResponseConvertible {
        
        let params = request.data.query
        let username = params["username"]
        let password = params["password"]
        
        return try login(username, password: password)
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
    
    func login(username: String?, password: String?) throws -> ResponseConvertible {
        
        // 参数判空
        guard let _ = username, _ = password else {
            return try commonResponse(code: Errors.Code_Success, message: Errors.Msg_Success)
        }
        
        // 判断是否含有特殊字符
        // 判断长度
        // 查询账号信息
        
        let queryParams = ( username! )
        
        let (users, _): ([User], QueryStatus) = try pool.execute { conn in
            try conn.query("SELECT id,account,password,salt,nickname FROM sg_user where account = ?", build(queryParams)) as ([User], QueryStatus)
        }
        
        
        var finalUser: User?
        
        for user in users {
            let md5Password = user.password;
            let salt = user.salt
            if md5Password == (password! + salt).md5() {
                finalUser = user
                break;
            }
        }
        
        if let result = finalUser {
            return try commonResponse(responseData: Json(["userId": String(result.id)]))
        } else {
            return "没有发现此账户"
        }
    }
    
}
