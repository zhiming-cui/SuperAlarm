//
//  HistoryViewController.swift
//  SuperAlarm
//
//  履歴から指定画面処理
//  Created by lion on 2020/03/21.
//  Copyright © 2020 lion. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    //Presenterを初期化する
    let alarmPresenter = AlarmPresenter();
    //TableViewデータリスト
    var historyItems:[HistoryDto] = [HistoryDto]()
    //データ件数
    var dataCount:Int = 0
    
    
    /**
        画面初期化する
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        //TableView初期設定
        listTableView.delegate = self
        listTableView.dataSource = self
        //履歴リストを取得する
        historyItems = alarmPresenter.getHistoryDataList()
        //件数
        dataCount = historyItems.count
        
        
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
    
    /**
     セル数を設定する
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount
    }
    
    /**
     セル表示を設定する
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = historyItems[indexPath.row].stationName
           
        return cell
    }
    
    //行選択イベント
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //目的地を設定する
        Globalvariables.objectName = historyItems[indexPath.row].stationName
        //経緯度設定
        Globalvariables.objectLatitude = historyItems[indexPath.row].latitudeValue
        Globalvariables.objectLongitude  =  historyItems[indexPath.row].longitudeValue
        //メッセージを表示する
        msgLbl.text = Globalvariables.objectName + "を指定しました。"
    }
}
