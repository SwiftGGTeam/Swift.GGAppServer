//
//  SwiftGGAppServer.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/17.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor

extension Application {
    
    func configRoute() {
        
        get("/") { request in
            return "Hello SwiftGG!"
        }
        
        any("/v1/user/login", handler: UserController().loginV1)
        any("/v1/user/otherLogin", handler: UserController().otherLoginV1)
        any("/v1/user/userRegister", handler: UserController().registerV1)
        any("/v1/user/getInfo", handler: UserController().getInfoV1)
        any("/v1/article/getCategoryList", handler: ArticleController().getCategoryListV1)
        any("/v1/article/getDetail", handler: ArticleController().getDetailV1)
        any("/v1/catch/newArticle", handler: CatchController().addNewArticle)
    }
    
    
}
