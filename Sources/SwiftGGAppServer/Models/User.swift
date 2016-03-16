//
//  User.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import MySQL

struct User : QueryRowResultType, QueryParameterDictionaryType {
 
    let id: Int
    let username: String
    let password: String
    let nickname: String
    
    static func decodeRow(r: QueryRowResult) throws -> User {
        return try User(id: r <| 0, username: r <| "account", password: r <| "password", nickname: r <| "nickname")
    }
    
    func queryParameter() throws -> QueryDictionary {
        let userDict = ["account": username, "password": password, "nickname": nickname]
        return QueryDictionary(userDict)
    }
    
}