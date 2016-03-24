//
//  Article.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/22.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import MySQL

struct Article: QueryRowResultType, QueryParameterDictionaryType {
    
    let id: Int
    let tag: String
    let title: String
    var coverUrl: String = ""
    var contentUrl: String = ""
    let translator: String
    let proofReader: String
    let finalization: String
    let author: String
    let authorImage: String
    let originalDate: String
    let originalUrl: String
    let permalink: String
    let starsNumber: Int
    let clickedNumber: Int
    let typeId: String?
    
    static func decodeRow(r: QueryRowResult) throws -> Article {
        return try Article(id: r <| 0,
                        tag: r <| "tag",
                        title: r <| "title",
                        coverUrl: r <| "cover_url",
                        contentUrl: r <| "content_url",
                        translator: r <| "translator",
                        proofReader: r <| "proofreader",
                        finalization: r <| "finalization",
                        author: r <| "author",
                        authorImage: r <| "author_image",
                        originalDate: r <| "original_date",
                        originalUrl: r <| "original_url",
                        permalink: r <| "permalink",
                        starsNumber: r <| "stars_number",
                        clickedNumber: r <| "clicked_number",
                        typeId: r <|? "type_id")
    }
    
    func queryParameter() throws -> QueryDictionary {
        return QueryDictionary(["tag": tag, "title": title, "cover_url": coverUrl, "content_url": contentUrl, "translator": translator,
                                "proofreader": proofReader, "finalization": finalization, "author": author, "author_image": authorImage,
                                "original_date": originalDate, "original_url": originalUrl, "permalink": permalink, "stars_number": starsNumber,
                                "clicked_number": clickedNumber])
    }
    
    
}
