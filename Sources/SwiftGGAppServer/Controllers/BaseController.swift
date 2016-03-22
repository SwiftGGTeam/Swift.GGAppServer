//
//  BaseController.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/22.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import Vapor

class BaseController: ResourceController, DefaultInitializable {
    
    required init() {
        
    }
    
    /// Display many instances
    func index(request: Request) throws -> ResponseConvertible {
        return "index"
    }
    
    /// Create a new instance.
    func store(request: Request) throws -> ResponseConvertible {
        return "store"
    }
    
    /// Show an instance.
    func show(request: Request) throws -> ResponseConvertible {
        return "show"
    }
    
    /// Update an instance.
    func update(request: Request) throws -> ResponseConvertible {
        return "update"
    }
    
    /// Delete an instance.
    func destroy(request: Request) throws -> ResponseConvertible {
        return "destroy"
    }
    
}
