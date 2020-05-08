//
//  AlarmPresenter.swift
//  SuperAlarm
//
//  Created by lion on 2020/03/21.
//  Copyright © 2020 lion. All rights reserved.
//

import Foundation

class AlarmPresenter{
    
    //データモデル
    let databaseModel = DatabaseModel(dataModelName :"SuperAlarmDBMolde");
    
    //マスタデータを初期化する
    func initMasterData(){
        return databaseModel.initMasters()
    }
    
    //路線マスタを取得する
    private func fetchRoute() -> [ROUTE_MST] {
        return databaseModel.fetchRoute()
    }
    
    //路線マスタを取得する
    func getRouteDataList() -> [RouteDto] {
        
        var list:[RouteDto] = [RouteDto]()
        
        let i:Int = 0

        for routeMst in fetchRoute(){
            let routeDto:RouteDto! = RouteDto()
            routeDto.rowIndex = i+1
            routeDto.seqId = Int32(routeMst.seq_id)
            routeDto.routeCd = routeMst.route_cd!
            routeDto.routeName = routeMst.route_name!
            list.append(routeDto)
        }
        
        return list
    }
    
    //駅マスタを取得する
    private func fetchStation() -> [STATION_MST] {
        return databaseModel.fetchStation()
    }
    
    
    //駅マスタを取得する
    func getStationDataList() -> [StationDto] {
        
        var list:[StationDto] = [StationDto]()
        
        let i:Int = 0

        for stationMst in fetchStation(){
            let stationDto:StationDto! = StationDto()
            stationDto.rowIndex = i+1
            stationDto.seqId = Int32(stationMst.seq_id)
            stationDto.routeCd = stationMst.route_cd!
            stationDto.stationCd = stationMst.station_cd!
            stationDto.stationName = stationMst.station_name!
            stationDto.latitudeValue = Double(stationMst.latitude_value)
            stationDto.longitudeValue = Double(stationMst.longitude_value)
            
            list.append(stationDto)
        }
        
        
        return list
    }
    
    //駅マスタを取得する
    private func fetchStation(sID:Int) -> [STATION_MST] {
        return databaseModel.fetchStation(sectionIndex:sID)
    }
    
    //駅マスタを取得する
    func getStationDataList(sID:Int) -> [StationDto] {
        
        var list:[StationDto] = [StationDto]()
        
        let i:Int = 0

        for stationMst in fetchStation(sID:sID){
            let stationDto:StationDto! = StationDto()
            stationDto.rowIndex = i+1
            stationDto.seqId = Int32(stationMst.seq_id)
            stationDto.routeCd = stationMst.route_cd!
            stationDto.stationCd = stationMst.station_cd!
            stationDto.stationName = stationMst.station_name!
            stationDto.latitudeValue = Double(stationMst.latitude_value)
            stationDto.longitudeValue = Double(stationMst.longitude_value)
            
            list.append(stationDto)
        }
        
        
        return list
    }
    
    //履歴マスタを取得する
    private func fetchHistory() -> [HISTORY_TBL] {
        return databaseModel.fetchHistory()
    }
    
    //履歴マスタを取得する
    func getHistoryDataList() -> [HistoryDto] {
        
        var list:[HistoryDto] = [HistoryDto]()
        
        let i:Int = 0

        for historyTbl in fetchHistory(){
            let historyDto:HistoryDto! = HistoryDto()
            historyDto.rowIndex = i+1
            historyDto.routeCd = historyTbl.route_cd!
            historyDto.stationCd = historyTbl.station_cd!
            historyDto.stationName = historyTbl.station_name!
            historyDto.latitudeValue = Double(historyTbl.latitude_value)
            historyDto.longitudeValue = Double(historyTbl.longitude_value)
            //historyDto.createDate = historyTbl.create_date!
            
            list.append(historyDto)
        }
        
        return list
    }
    
    //履歴テーブルを書込み
    func createHistory(){
        //databaseModel.deleteHistoryData()
        databaseModel.createHistoryData()
    }
    
    
}
