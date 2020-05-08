//
//  LineViewController.swift
//  SuperAlarm
//
//  路線から指定画面処理
//  Created by lion on 2020/03/21.
//  Copyright © 2020 lion. All rights reserved.
//

import UIKit

class LineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    //Presenterを初期化する
    let alarmPresenter = AlarmPresenter();
    //TableViewデータリスト
    var routeDtoItems:[RouteDto] = [RouteDto]()
    var stationItems:[StationDto] = [StationDto]()
    //データ件数
    var routeDataCount:Int = 0
    var stationDataCount:Int = 0
    
    /**
        画面初期化する
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //TableView初期設定
        listTableView.delegate = self
        listTableView.dataSource = self
        //路線リストを取得する
        routeDtoItems = alarmPresenter.getRouteDataList()
        //件数
        routeDataCount = routeDtoItems.count
        
    }

    /**
       確認ボタンをタップする
    */
    @IBAction func confirmBtn(_ sender: Any) {
        //指定する
        Globalvariables.startFlg = true
        //自画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    //セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return routeDataCount
    }
    
    //セクションタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return routeDtoItems[section].routeName
    }
    
    /**
    セル数を設定する
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        stationDataCount = alarmPresenter.getStationDataList(sID:section).count
        
        return stationDataCount
    }
    
    /**
     セル表示を設定する
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        //対象セクション
        stationItems = alarmPresenter.getStationDataList(sID:indexPath.section)
        // セルに表示する値を設定する
        cell.textLabel!.text = stationItems[indexPath.row].stationName
           
        return cell
    }
    
    //行選択イベント
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //対象セクション
        stationItems = alarmPresenter.getStationDataList(sID:indexPath.section)
        //目的地を設定する
        Globalvariables.objectName = stationItems[indexPath.row].stationName
        //経緯度設定
        Globalvariables.objectLatitude = stationItems[indexPath.row].latitudeValue
        Globalvariables.objectLongitude  =  stationItems[indexPath.row].longitudeValue
        //メッセージを表示する
        msgLbl.text = Globalvariables.objectName + "を指定しました。"
    }
    
}

