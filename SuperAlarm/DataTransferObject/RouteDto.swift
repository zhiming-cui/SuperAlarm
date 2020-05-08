//
//  RouteDto.swift
//  SuperAlarm
//
//  Created by lion on 2020/03/31.
//  Copyright © 2020 lion. All rights reserved.
//

import Foundation

class RouteDto:ComDto{
      
    private var _routeCd:String = ""
    private var _routeName:String = ""
    private var _seqId:Int32 = 0
    private var _sectionIndex:Int = 0
      
    /**
          路線コード
     */
    var routeCd: String {
        get {
            return _routeCd
        }
        set {
            _routeCd = newValue
        }
    }
    
    /**
          路線名称
     */
    var routeName: String {
        get {
            return _routeName
        }
        set {
            _routeName = newValue
        }
    }
    
    /**
          表示順
     */
    var seqId: Int32 {
        get {
            return _seqId
        }
        set {
            _seqId = newValue
        }
    }
    
    /**
    セクションID
        */
    var sectionIndex: Int {
       get {
           return _sectionIndex
       }
       set {
           _sectionIndex = newValue
       }
   }
}
