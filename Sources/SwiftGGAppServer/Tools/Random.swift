//
//  Random.swift
//  SwiftGGAppServer
//
//  Created by 孙燕飞 on 16/3/20.
//  Copyright © 2016年 SwiftGG. All rights reserved.
//

import libc

struct Random {
    
    static func randomIntWithMax(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
    
    static func randomStringWithLength (len : Int) -> String {
        
        let letters : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString  = ""
        
        for _ in 0..<len {
            let length = UInt32(letters.characters.count)
            let rand = arc4random_uniform(length)
            let index = letters.startIndex.advancedBy(Int(rand))
            randomString += String(letters[index])
        }
        return randomString
    }
    
}
