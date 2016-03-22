//
//  ArticleType.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/22.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import MySQL

struct ArticleType: QueryRowResultType, QueryParameterDictionaryType {
    
    let id: Int
    let typeName: String
    let coverUrl: String?
    
    static func decodeRow(r: QueryRowResult) throws -> ArticleType {
        return try ArticleType(id: r <| 0,
                        typeName: r <| "name",
                        coverUrl: r <|? "cover_url")
    }
    
    func queryParameter() throws -> QueryDictionary {
        return QueryDictionary(["name": typeName, "cover_url": coverUrl])
    }
    
}
