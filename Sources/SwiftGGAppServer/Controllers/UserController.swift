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

    func loginV1(request: Request) throws -> ResponseConvertible {

        let params = request.parameters
        let username = params["userName"]
        let password = params["password"]

        // 参数判空
        // 判断是否含有特殊字符
        // 判断长度
        // 查询账号信息

        let queryParams = ( username! )

        let (users, _): ([User], QueryStatus) = try pool.execute { conn in
            try conn.query("SELECT id,account,password,nickname FROM sg_user where account = ?", build(queryParams)) as ([User], QueryStatus)
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
            return try Json(["userId": result.id])
        } else {
            return "登录失败"
        }
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
