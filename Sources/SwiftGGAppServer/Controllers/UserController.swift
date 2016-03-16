//
//  UserController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor

class UserController : Controller {
    
    required init() {
        
    }
    
    func registerV1(request: Request) throws -> ResponseConvertible {
        return try Json(["lub": "dub"])
    }
    
    func otherLoginV1(request: Request) throws -> ResponseConvertible {
        return ""
    }
    
    func getInfoV1(request: Request) throws -> ResponseConvertible {
        return ""
    }
    
}
