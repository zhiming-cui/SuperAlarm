//
//  MapViewController.swift
//  SuperAlarm
//
//  地図から指定画面処理
//  Created by lion on 2020/03/21.
//  Copyright © 2020 lion. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate{

    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var objMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        objMapView.delegate = self

    // 中心点の緯度経度.
    let myLat: CLLocationDegrees = 35.5606
    let myLon: CLLocationDegrees = 139.7237
    let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLon) as CLLocationCoordinate2D

    // 縮尺.
    let myLatDist : CLLocationDistance = 500
    let myLonDist : CLLocationDistance = 500

    // Regionを作成.
    let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: myCoordinate, latitudinalMeters: myLatDist, longitudinalMeters: myLonDist);

    // MapViewに反映.
    objMapView.setRegion(myRegion, animated: true)
    
    // 長押しのUIGestureRecognizerを生成.
    let myLongPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    myLongPress.addTarget(self, action: #selector(MapViewController.recognizeLongPress(sender:)))

    // MapViewにUIGestureRecognizerを追加.
    objMapView.addGestureRecognizer(myLongPress)
    
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
    
    /*
     長押しを感知した際に呼ばれるメソッド.
     */
    @objc func recognizeLongPress(sender: UILongPressGestureRecognizer) {

        // 長押しの最中に何度もピンを生成しないようにする.
        if sender.state != UIGestureRecognizer.State.began {
            return
        }

        // 長押しした地点の座標を取得.
        let location = sender.location(in: objMapView)

        // locationをCLLocationCoordinate2Dに変換.
        let myCoordinate: CLLocationCoordinate2D = objMapView.convert(location, toCoordinateFrom: objMapView)

        // ピンを生成.
        let myPin: MKPointAnnotation = MKPointAnnotation()

        // 座標を設定.
        myPin.coordinate = myCoordinate
        
        // 目的地経緯度
        
        //メイン画面に渡す
        Globalvariables.objectLatitude = myCoordinate.latitude
        Globalvariables.objectLongitude  = myCoordinate.longitude
        Globalvariables.objectName = "地図"
        // タイトルを設定.
        myPin.title = "目的地"

        // サブタイトルを設定.
        myPin.subtitle = "この駅を目標する"
        

        // MapViewにピンを追加.
        objMapView.addAnnotation(myPin)
    }

    /*
     addAnnotationした際に呼ばれるデリゲートメソッド.
     */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        let myPinIdentifier = "PinAnnotationIdentifier"

        // ピンを生成.
        let myPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myPinIdentifier)

        // アニメーションをつける.
        myPinView.animatesDrop = true

        // コールアウトを表示する.
        myPinView.canShowCallout = true

        // annotationを設定.
        myPinView.annotation = annotation

        return myPinView
    }
    
}
