//
//  UserController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor
import MySQL

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
    
    func registerV1(request: Request) throws -> ResponseConvertible {

        let result = try pool.execute { conn in
            try conn.query("select * from sg_user")
        }
        
        print(result)
        
        return try Json(["lub": "dub"])
    }
    
    func otherLoginV1(request: Request) throws -> ResponseConvertible {
        return ""
    }
    
    func getInfoV1(request: Request) throws -> ResponseConvertible {
        return ""
    }
    
}
