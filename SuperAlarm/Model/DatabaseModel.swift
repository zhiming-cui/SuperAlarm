//
//  DatabaseModel.swift
//  SuperAlarm
//
//  Created by lion on 2020/03/21.
//  Copyright © 2020 lion. All rights reserved.
//

import CoreData

class DatabaseModel: NSObject {
    var persistentContainer: NSPersistentContainer!

    /*
     データモデルを初期化する
     */
    init(dataModelName: String){
        persistentContainer = NSPersistentContainer(name: dataModelName)
        persistentContainer.loadPersistentStores() { (description, error) in
        if let error = error {
            fatalError("Failed to load Core Data stack: \(error)")
        }
     }
    }
      
    /*
     路線マスタを取得する
     */
    func fetchRoute() -> [ROUTE_MST] {
        let context = persistentContainer.viewContext
        let routeFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ROUTE_MST")
        let sortDescripter = NSSortDescriptor(key: "section_index", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "seq_id", ascending: true)
        //並び順
        routeFetch.sortDescriptors = [sortDescripter,sortDescriptor2]

        do {
            let fetchedRoute = try context.fetch(routeFetch) as! [ROUTE_MST]
            return fetchedRoute
        } catch {
            fatalError("Failed to fetch Route: \(error)")
        }
        return []
    }
    
    /*
     駅マスタを取得する
     */
    func fetchStation() -> [STATION_MST] {
        let context = persistentContainer.viewContext
        let stationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "STATION_MST")

        do {
            let fetchedStation = try context.fetch(stationFetch) as! [STATION_MST]
            return fetchedStation
        } catch {
            fatalError("Failed to fetch STATION_MST: \(error)")
        }
        return []
    }
    
    /*
     駅マスタを取得する(where section_index= %ld )
     */
    func fetchStation(sectionIndex:Int) -> [STATION_MST] {
        let context = persistentContainer.viewContext
        let stationFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "STATION_MST")
        let predicate = NSPredicate(format: "section_index = %d", sectionIndex)
        let sortDescripter = NSSortDescriptor(key: "section_index", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "seq_id", ascending: true)
        //検索条件
        stationFetch.predicate = predicate
        
        //並び順
        stationFetch.sortDescriptors = [sortDescripter,sortDescriptor2]
        
        do {
            let fetchedStation = try context.fetch(stationFetch) as! [STATION_MST]
            return fetchedStation
        } catch {
            fatalError("Failed to fetch STATION_MST where section_index= : \(error)")
        }
        return []
    }
  
    /*
     履歴テーブルを取得する
     */
    func fetchHistory() -> [HISTORY_TBL] {
        let context = persistentContainer.viewContext
        let historyFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HISTORY_TBL")

        do {
            let fetchedHistory = try context.fetch(historyFetch) as! [HISTORY_TBL]
            return fetchedHistory
        } catch {
            fatalError("Failed to fetch History: \(error)")
        }
        return []
    }
    
    /*
    履歴テーブルを書き込み
    */
    func createHistoryData()  {
        let context = persistentContainer.viewContext
        let historyData = NSEntityDescription.insertNewObject(forEntityName: "HISTORY_TBL", into: context) as! HISTORY_TBL
        
        historyData.route_cd = "KK"
        historyData.route_name = "京急本線"
        historyData.station_cd = "KK01"
        historyData.station_name = "品川駅"
        historyData.latitude_value = 35.6277
        historyData.longitude_value = 139.7377
        
        saveContext()
        
        historyData.route_cd = "KK"
        historyData.route_name = "京急本線"
        historyData.station_cd = "KK11"
        historyData.station_name = "京急蒲田駅"
        historyData.latitude_value = 35.5606
        historyData.longitude_value = 139.7237
        
        saveContext()
        
        
    }
    
    /*
     データをコミット
    */
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /*
     履歴データを削除する
    */
    func deleteHistoryData() {
        let context = persistentContainer.viewContext
        let historyFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HISTORY_TBL")

        do {
            let fetchedHistory = try context.fetch(historyFetch) as! [HISTORY_TBL]
            for result: AnyObject in fetchedHistory {
                let record = result as! NSManagedObject
                context.delete(record)
            }
            try context.save()
            
        } catch {
            fatalError("Failed to fetch History: \(error)")
        }
    }

    /**
           マスタデータを初期化する
     */
    func initMasters() {
        // plist の読み込み
        let path = Bundle.main.path(forResource: "Masterdata", ofType: "plist")
        // マスタデータを取得する
        let plist = NSDictionary(contentsOfFile: path!)

        for (key, value) in plist!{
            //キーを取得する
            let KeyCd: String = key as! String
            //値を取得する
            let item: NSArray = value as!NSArray
            
            if KeyCd.contains("Route"){
                print("---------Route-----------")
                initRouteData(items: item as! [Any])
                print("------------------------")
            }
            
            if KeyCd.contains("Station"){
                print("--------Station----------")
                initStationData(items: item as! [Any])
                print("------------------------")
            }
         }
        //投入完了
        print("☆☆☆☆☆マスタデータ投入完了☆☆☆☆☆")
    }
    
    /*
      路線データを書込み
    */
    func initRouteData(items:[Any])  {
        let context = persistentContainer.viewContext
        let routeData = NSEntityDescription.insertNewObject(forEntityName: "ROUTE_MST", into: context) as! ROUTE_MST
        
        routeData.seq_id = items[0] as! Int32
        routeData.route_name = items[1] as! String
        routeData.route_cd = items[2] as! String
        routeData.section_index = items[3] as! Int32
        print("initRouteData_SEQ:\(items[0])")
        print("initRouteData_Name:\(items[1])")
        print("initRouteData_cd:\(items[2])")
        print("initsection_index:\(items[3])")
        
        saveContext()
    }
    
    /*
      駅データを書込み
    */
    func initStationData(items:[Any])  {
        let context = persistentContainer.viewContext
        let stationData = NSEntityDescription.insertNewObject(forEntityName: "STATION_MST", into: context) as! STATION_MST
        
        stationData.seq_id = items[0] as! Int32
        stationData.longitude_value = items[1] as! Double
        stationData.latitude_value = items[2] as! Double
        stationData.station_name = items[3] as! String
        stationData.station_cd = items[4] as! String
        stationData.route_cd = items[5] as! String
        stationData.section_index = items[6] as! Int32
        
        print("Station_SEQ:\(items[0])")
        print("longitude_value:\(items[1])")
        print("latitude_value:\(items[2])")
        print("Station_Name:\(items[3])")
        print("Station_cd:\(items[4])")
        print("Route_cd:\(items[5])")
        print("initsection_index:\(items[6])")
        
        saveContext()
    }
    
}


