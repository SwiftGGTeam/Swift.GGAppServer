//
//  Controller+Common.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/18.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor
import SwiftyJSON

extension ResourceController {

    func commonResponse(code theCode: Int = Errors.Code_Success, message: String = Errors.Msg_Success, responseData: AnyObject? = nil) throws -> ResponseConvertible {
        var resultData = try JSON(["code": theCode, "message": message, "data": ""]).rawData().arrayOfBytes()
        if let theData = responseData {
            resultData = try JSON(["code": theCode, "message": message, "data": theData]).rawData().arrayOfBytes()
        }
        return Response(status: .OK, data: resultData, contentType: .Json)
    }

}
