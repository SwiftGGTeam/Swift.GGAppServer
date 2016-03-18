//
//  Controller+Common.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/18.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor

extension Controller {
    
    func commonResponse(code theCode: Int = Errors.Code_Success, message: String = Errors.Msg_Success, responseData: Json? = nil) throws -> ResponseConvertible {
        
        if let _ = responseData {
//            return Json([
//                     "number": 123,
//                     "string": "test",
//                     "array": [
//                                  0, 1, 2, 3
//                ],
//                     "dict": [
//                                 "name": "Vapor",
//                                 "lang": "Swift"
//                ]
//                ])
            
            
//            let content:String = "123"
            return Json(["code": "", "message": content, "data": ["username": "sunyanfei"]])
            
        } else {
            return try Json(["code": "", "message": message, "data": ""])
        }
    }

}
