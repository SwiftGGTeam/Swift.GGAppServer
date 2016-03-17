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
        app.configRoute()
        app.start(port: 4000)
        
    }
}

