//
//  LogMiddleware.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor

class LogMiddleware : Middleware {
    
    static func handle(handler: Request.Handler, for application: Application) -> Request.Handler {
        
        return { request in
            return try handler(request: request)
        }
        
    }
    
}
