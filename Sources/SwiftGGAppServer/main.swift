//
//  main.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/15.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor

let app = Application()
app.configRoute()
app.start(port: 4000)

print("visit http://localhost:4000")
