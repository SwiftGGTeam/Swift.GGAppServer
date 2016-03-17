//
//  main.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor

let app = Application()

app.get("/") { request in
    return "Hello SwiftGG!"
}

app.any("/v1/uesr/login", handler: UserController().loginV1)

app.any("/v1/user/otherLogin", handler: UserController().otherLoginV1)

app.any("/v1/user/userRegister", handler: UserController().registerV1)

app.any("/v1/user/getInfo", handler: UserController().getInfoV1)

app.any("/v1/article/getCategoryList", handler: ArticleController().getCategoryListV1)

app.any("/v1/article/getDetail", handler: ArticleController().getDetailV1)

app.any("/v1/catch/newArticle", handler: CatchController().addNewArticle)


app.start(port: 4000)

print("visit http://localhost:4000")
