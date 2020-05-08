//
//  StationDto.swift
//  SuperAlarm
//
//  Created by lion on 2020/03/31.
//  Copyright © 2020 lion. All rights reserved.
//

import Foundation

class StationDto:RouteDto{
    
    private var _stationCd:String = ""
    private var _stationName:String = ""
    private var _latitudeValue:Double = 0.0000
    private var _longitudeValue:Double = 0.0000
    
    /**
          駅コード
     */
    var stationCd: String {
        get {
            return _stationCd
        }
        set {
            _stationCd = newValue
        }
    }
    
    /**
          駅名称
     */
    var stationName: String {
        get {
            return _stationName
        }
        set {
            _stationName = newValue
        }
    }
    
    /**
          緯度
     */
    var latitudeValue: Double {
        get {
            return _latitudeValue
        }
        set {
            _latitudeValue = newValue
        }
    }
    
    /**
          経度
     */
    var longitudeValue: Double {
        get {
            return _longitudeValue
        }
        set {
            _longitudeValue = newValue
        }
    }
    
}
