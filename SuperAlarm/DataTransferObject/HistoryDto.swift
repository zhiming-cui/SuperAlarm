//
//  HistoryDto.swift
//  SuperAlarm
//
//  Created by lion on 2020/03/31.
//  Copyright © 2020 lion. All rights reserved.
//

import Foundation

class HistoryDto:StationDto{
    
    private var _createDate:Date = Date()
    
    /**
          作成日
     */
    var createDate: Date {
        get {
            return _createDate
        }
        set {
            _createDate = newValue
        }
    }
    
}
