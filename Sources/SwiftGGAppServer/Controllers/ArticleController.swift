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
        
        let types = try getArticleCategoryies()
        let typeDictArr = types.map { ["id": $0.id, "typeName": $0.typeName, "coverUrl": $0.coverUrl] }
        return try commonResponse(code: Errors.Code_Success, message: Errors.Msg_Success, responseData: typeDictArr)

    }
    
    func getArticlesByCategoryV1(request: Request) throws -> ResponseConvertible {
        
        let optionalCategoryId = request.data.query["categoryId"]
        
        guard let categoryId = optionalCategoryId else {
            return try commonResponse(code: Errors.Code_ParameterInvalid, message: Errors.Msg_ParameterInvalid)
        }
        
        let articles = try getArticles()
        let articlesDictArr = articles.filter {
            if let realTypeId = $0.typeId {
                return realTypeId == categoryId
            }
            return false
        }.map {
            ["id": $0.id, "tag": $0.tag, "title": $0.title, "cover_url": $0.coverUrl, "content_url": $0.contentUrl, "translator": $0.translator, "proofreader": $0.proofReader, "finalization": $0.finalization, "author": $0.author, "authorImage": $0.authorImage, "original_date": $0.originalDate, "original_url": $0.originalUrl, "permalink": $0.permalink, "startsNumber": $0.starsNumber, "clickedNumber": $0.clickedNumber]
        }
        return try commonResponse(code: Errors.Code_Success, message: Errors.Msg_Success, responseData: articlesDictArr)
        
    }
    
}

extension ArticleController {
    
    func getArticles() throws -> [Article] {
        
        let (articles, _) = try pool.execute { conn in
            try conn.query("select id, tag, title, cover_url, content_url, translator, proofreader, finalization, author, author_image, author_image, original_date, original_url, permalink, stars_number, clicked_number, t.type_id from sg_article left join (select article_id,type_id from sg_article_type) t on t.article_id = sg_article.id") as ([Article], QueryStatus)
        }
        return articles
        
    }
    
    func getArticleCategoryies() throws -> [ArticleType] {

        let (types, _) = try pool.execute { conn in
            try conn.query("select id, name, cover_url from sg_type") as ([ArticleType], QueryStatus)
        }
        return types
        
    }
    
}
