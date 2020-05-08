//
//  ComDto.swift
//  SuperAlarm
//  comit
//  Created by lion on 2020/03/31.
//  Copyright © 2020 lion. All rights reserved.
//

import Foundation

class ComDto{
    
    private var _rowIndex:Int = 0
    
    init() {
        
    }
    /**
       レコードIndex
     */
     var rowIndex: Int {
        get {
            return _rowIndex
        }
        set {
            _rowIndex = newValue
        }
    }
    
}
