//
//  ViewController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/17.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Cocoa
import Vapor

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override var representedObject: AnyObject? {
        didSet {
        }
    }

}

extension ViewController {
    
    @IBAction func startServer(sender: AnyObject) {
        
        let app = Application()

        app.get("/") { request in
            return "Hello SwiftGG!"
        }

        app.post("/v1/user/otherLogin", handler: UserController().otherLoginV1)

        app.any("/v1/user/userRegister", handler: UserController().registerV1)

        app.post("/v1/user/getInfo", handler: UserController().getInfoV1)

        app.post("/v1/article/getCategoryList", handler: ArticleController().getCategoryListV1)

        app.post("/v1/article/getDetail", handler: ArticleController().getDetailV1)

        app.post("/v1/catch/newArticle", handler: CatchController().addNewArticle)
        
        app.start(port: 4000)
        
    }
}

