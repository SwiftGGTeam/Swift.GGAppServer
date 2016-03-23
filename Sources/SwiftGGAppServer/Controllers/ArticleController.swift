//
//  ArticleController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor
import MySQL
import SwiftyJSON

class ArticleController: BaseController {
    
    func getCategoryListV1(request: Request) throws -> ResponseConvertible {
        
//        SELECT * FROM sg_type LEFT JOIN (SELECT `type_id`,count(*) AS sum FROM sg_article_type group BY `type_id`) b ON sg_type.`id`=b.`type_id` ORDER BY `sum` DESC
        
        "select id, name, cover_url from sg_type left join (select type_id, count(*) as sum from sg_article_type group by type_id) t on sg_type.id = t.type_id order by sum desc"
        
        let (types, _) = try pool.execute { conn in
            try conn.query("select id, name, cover_url from sg_type") as ([ArticleType], QueryStatus)
        }
        
        var resultTypeArr = [JSON]()
        
        for type in types {
            let typeDicts: JSON = ["id": type.id, "typeName": type.typeName, "coverUrl": type.coverUrl!]
            resultTypeArr.append(typeDicts)
        }
        
//        let result = ["":""]
        return try commonResponse(code: Errors.Code_Success, message: Errors.Msg_Success, responseData: resultTypeArr)
    }
    
    func getDetailV1(request: Request) throws -> ResponseConvertible {
        return ""
    }
    
}
