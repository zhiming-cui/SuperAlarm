//
//  MainViewController.swift
//  SuperAlarm
//
//  メニュー画面処理
//  Created by lion on 2020/03/21.
//  Copyright © 2020 lion. All rights reserved.
//

import UIKit
import AudioToolbox
import CoreLocation
import BackgroundTasks

class MainViewController: UIViewController {

    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var objLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var distanceValueLbl: UILabel!
    
    
    //位置ライブラリ
    var locationManager: CLLocationManager!
    //距離
    var distance = 0.0
    //距離km単位
    var kmDistance = 0.0
    //初期化フラグ
    var initFlg = false
    //Presenter
    let alarmPresenter = AlarmPresenter();
    
    /**
       画面初期化する
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // インスタンスの生成
       locationManager = CLLocationManager()
       // CLLocationManagerDelegateプロトコルを実装するクラスを指定する
       locationManager.delegate = self
        
        //固定文言
        objLbl.isHidden = true
        distanceLbl.isHidden = true
        distanceValueLbl.isHidden = true
        
        // 路線データがなければ、データを初期化する
        if alarmPresenter.getRouteDataList().count < 1{
            alarmPresenter.initMasterData()
        }
        
    }
    
    /**
       開始ボタンをタップする
    */
    @IBAction func startBtj(_ sender: Any) {
        //固定文言
        objLbl.isHidden = false
        distanceLbl.isHidden = false
        distanceValueLbl.isHidden = false
        //振動
        AudioServicesPlaySystemSound(1000)
        //初期化フラグ
        initFlg = true
        //バックグラウンド処理
        locationManager.allowsBackgroundLocationUpdates = true
        //位置取得開始
        locationManager.startUpdatingLocation()
        
    }
    
    /**
       停止ボタンをタップする
    */
    @IBAction func stopBtn(_ sender: Any) {
        //振動
        AudioServicesPlaySystemSound(1000)
        //固定文言
        objLbl.isHidden = true
        distanceLbl.isHidden = true
        distanceValueLbl.isHidden = true
        //指定フラグを無効にする
        Globalvariables.startFlg = false
        msgLbl.text = "目的地を指定してください"
        //位置取得停止
        locationManager.stopUpdatingHeading()
        //バックグラウンド処理
        locationManager.allowsBackgroundLocationUpdates = false
        //初期化する
        initFlg = false
    }
}
    
    extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // 許可を求めるコードを記述する（後述）
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied:
            // 「設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい」を表示する
            break
        case .restricted:
            // 「このアプリは、位置情報を取得できないために、正常に動作できません」を表示する
            break
        case .authorizedAlways:
            // 位置情報取得の開始処理
            break
        case .authorizedWhenInUse:
             //バックグラウンド処理
             //locationManager.allowsBackgroundLocationUpdates = true
             // 位置情報取得の開始処理
             locationManager.startUpdatingLocation()
            break
        }
     }
        
        //位置を計算する
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                    
            //現在地
            //緯度
            var latitude = 0.0000
            //経度
            var longitude = 0.0000
            
            //行先
            //緯度
            var oldLatitude = 0.0000
            //経度
            var oldLongitude = 0.0000
        
            for location in locations {
                //緯度
                latitude = location.coordinate.latitude
                //経度
                longitude = location.coordinate.longitude
                
                //LocalLbl.text = "現在地 緯度:\(String(format: "%.4f", latitude) ) 経度:\(String(format: "%.4f", longitude)) "
                
                //現在地位置計算
                let newLocation: CLLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
                //行先位置
                oldLatitude = latitude
                oldLongitude = longitude
                
                // 他画面から指定された行き先位置
                if(Globalvariables.startFlg == true){
                    msgLbl.text = "目的地\(Globalvariables.objectName)指定しました。"
                    //固定文言
                    objLbl.isHidden = false
                    distanceLbl.isHidden = false
                    distanceValueLbl.isHidden = false
                    
                    oldLatitude = Globalvariables.objectLatitude
                    oldLongitude = Globalvariables.objectLongitude
                    //行き先位置計算
                    let oldLocation: CLLocation = CLLocation(latitude: oldLatitude, longitude: oldLongitude)
                    
                    //距離km単位
                    kmDistance = oldLocation.distance(from: newLocation)/1000
                    distanceLbl.text = "キロ "
                    distanceValueLbl.text = "\(String(format: "%.1f", kmDistance))  "
                    
                    if(kmDistance < 1) {
                        distanceLbl.text = "メートル "
                        distanceValueLbl.text = "\(String(format: "%.0f", kmDistance*1000))  "
                        //round(
                    }
                    //目的地周辺
                    if(kmDistance < 0.3){
                        msgLbl.text = "目的地[\(Globalvariables.objectName)]です。"

                        if(initFlg == true){
                            //アラームした
                            AudioServicesPlaySystemSound(1336)
                            //次アラームしない
                            initFlg = false
                            //位置取得停止
                            locationManager.stopUpdatingHeading()
                            //バックグラウンド処理
                            locationManager.allowsBackgroundLocationUpdates = false
                        }
                    }
                 }
            }
        }
    }
