//
//  ArticleController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor

class ArticleController: BaseController {
    
    func getCategoryListV1(request: Request) throws -> ResponseConvertible {
        
//        SELECT * FROM sg_type LEFT JOIN (SELECT `type_id`,count(*) AS sum FROM sg_article_type group BY `type_id`) b ON sg_type.`id`=b.`type_id` ORDER BY `sum` DESC
        
        return ""
    }
    
    func getDetailV1(request: Request) throws -> ResponseConvertible {
        return ""
    }
    
}
