//
//  UserController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor
import MySQL
import CryptoSwift
import SwiftyJSON
import Regex
import Foundation

class UserController : Controller {

    struct Options: ConnectionOption {
        let host: String
        let port: Int
        let user: String
        let password: String
        let database: String
    }

    private let pool:ConnectionPool = {
        let options = Options(host: "123.57.250.194", port: 3306, user: "swiftggapp", password: "SwiftGG123", database: "swiftggapp")
        return ConnectionPool(options: options)
    }()

    required init() {

    }

    func registerV1(request: Request) throws -> ResponseConvertible {
        
        let query = request.data.query
        let optionalUsername = query["username"]
        let optionalPassword = query["password"]
        
        guard let username = optionalUsername, password = optionalPassword else {
            return try commonResponse(code: Errors.Code_ParameterInvalid, message: Errors.Msg_ParameterInvalid)
        }
        
        let (verifyStatus, code, message) = try verify(username, password)
        
        if !verifyStatus {
            return try commonResponse(code: code, message: message)
        } else {
            return try register(username, password)
        }
    }
    
    func loginV1(request: Request) throws -> ResponseConvertible {

        let params = request.data.query
        let optionalUsername = params["username"]
        let optionalPassword = params["password"]
        
        guard let username = optionalUsername, password = optionalPassword else {
            return try commonResponse(code: Errors.Code_ParameterInvalid, message: Errors.Msg_ParameterInvalid)
        }
        
        let (verifyStatus, code, message) = try verify(username, password)
        
        if !verifyStatus {
            return try commonResponse(code: code, message: message)
        } else {
            return try login(username, password)
        }

    }

    func getInfoV1(request: Request) throws -> ResponseConvertible {
        
        let optionalUserId = request.data.query["userid"]
        guard let userid = optionalUserId else {
            return try commonResponse(code: Errors.Code_ParameterInvalid, message: Errors.Msg_ParameterInvalid)
        }
        
        let queryParams = (userid)
        
        let (users, _) = try pool.execute { conn in
            try conn.query("select id, account, password, salt, nickname, score, created_time, updated_time from sg_user where id = ?", build(queryParams)) as ([User], QueryStatus)
        }
        
        if users.count == 1 {
            let user = users[0]
            let userDict = ["uid":user.id, "username": user.username, "nickname": user.nickname, "score": user.score]
            return try commonResponse(responseData: userDict)
        } else {
            return try commonResponse(code: Errors.Code_UserInValid, message: Errors.Msg_UserInValid)
        }
    }

}

extension UserController {
    
    func register(username: String, _ password: String) throws -> ResponseConvertible {
        
        let queryParams = ( username )
        
        let (users, _): ([User], QueryStatus) = try pool.execute { conn in
            try conn.query("select id, account, password, salt, nickname, score, created_time, updated_time from sg_user where account = ?", build(queryParams)) as ([User], QueryStatus)
        }
        
        if users.count > 0 {
            return try commonResponse(code: Errors.Code_UserExist, message: Errors.Msg_UserExist)
        }
    
        let nickname = "SwiftGG粉丝:\(username)"
        let score = Random.randomIntWithMax(100)
        let salt = Random.randomStringWithLength(6)
        let encryptPass = (password + salt).md5()
        
        let newDateTime = Int(Date().timeIntervalSince1970)

        let user = User(id: 0, username: username, password: encryptPass, salt: salt, nickname: nickname, score: score, createTime: newDateTime, updateTime: newDateTime)
        
        let queryStatus = try pool.execute {conn in
            try conn.query("INSERT INTO sg_user SET ?", [user]) as QueryStatus
        }
        let newId = queryStatus.insertedId
        
        return try commonResponse(responseData: ["userId": newId])
    }
    
    func login(username: String, _ password: String) throws -> ResponseConvertible {
        let queryParams = ( username )
        
        let (users, _): ([User], QueryStatus) = try pool.execute { conn in
            try conn.query("select id, account, password, salt, nickname, score, created_time, updated_time from sg_user where account = ?", build(queryParams)) as ([User], QueryStatus)
        }
        
        var finalUser: User?
        
        for user in users {
            let md5Password = user.password;
            let salt = user.salt
            if md5Password == (password + salt).md5() {
                finalUser = user
                break;
            }
        }
        
        if let result = finalUser {
            return try commonResponse(responseData: ["userId": String(result.id)])
        } else {
            return try commonResponse(code: Errors.Code_UserInValid, message: Errors.Msg_UserInValid)
        }
    }

    func verify(username: String, _ password: String) throws -> (Bool, Int, String) {
        
        //用户名验证（允许使用小写字母、数字、下滑线、横杠，一共3~16个字符）
        // 判断是否含有特殊字符
        if username !~ "^[a-z0-9_-]{3,16}$" {
            return (false, Errors.Code_UsernameInvalid, Errors.Msg_UsernameInvalid)
        }
        
        // 判断长度
        if username.characters.count < Constant.Constant_Username_Length {
            return (false, Errors.Code_UsernameLengthInValid, Errors.Msg_UsernameLengthInValid)
        }
        
        if password.characters.count < Constant.Constant_Password_Length {
            return (false, Errors.Code_PasswordLengthInValid, Errors.Msg_PasswordLengthInValid)
        }
        
        return (true, Errors.Code_Success, Errors.Msg_Success)
    }
}
