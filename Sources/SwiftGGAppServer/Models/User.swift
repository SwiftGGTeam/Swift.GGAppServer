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
    let salt: String
    let nickname: String
    let score: Int
    let createTime: Int
    let updateTime: Int
    
    static func decodeRow(r: QueryRowResult) throws -> User {
        return try User(id: r <| 0,
                        username: r <| "account",
                        password: r <| "password",
                        salt: r <| "salt",
                        nickname: r <| "nickname",
                        score: r <| "score",
                        createTime: r <| "created_time",
                        updateTime: r <| "updated_time")
    }
    
    func queryParameter() throws -> QueryDictionary {

        return QueryDictionary(["account": username, "password": password, "nickname": nickname, "salt": salt, "score": score, "created_time": createTime, "updated_time": updateTime])
    }
    
}