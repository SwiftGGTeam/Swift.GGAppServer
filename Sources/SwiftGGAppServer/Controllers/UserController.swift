//
//  UserController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor
import MySQL
//import Foundation

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
        return ""
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
