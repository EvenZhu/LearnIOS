//
//  EZLearnSwift.swift
//  LearnIOS
//
//  Created by Even on 2019/6/11.
//  Copyright © 2019 Even. All rights reserved.
//

import UIKit

class EZLearnSwift: NSObject {
    
    override init() {
        super.init()
        showNumber()
        
        let string = "A "
        print("\(string)是否为空：\(isEmpty(string: "A "))")
    }
    
    func isEmpty(string:String) -> Bool {
        return string.isEmpty
    }
    
    func showNumber() {
        print("Int16.min = \(Int16.min)")
        print("Int16.max = \(Int16.max)")
        print("Int32.min = \(Int32.min)")
        print("Int32.max = \(Int32.max)")
        print("Int64.min = \(Int64.min)")
        print("Int64.max = \(Int64.max)")
    }
    
    deinit {
        print(Date(), "------------释放了EZLearnSwift")
    }
}
