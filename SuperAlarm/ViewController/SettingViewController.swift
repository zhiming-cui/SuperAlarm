//
//  SettingViewController.swift
//  SuperAlarm
//
//  システム設定画面処理
//  Created by lion on 2020/03/21.
//  Copyright © 2020 lion. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var alarmTimesTxt: UITextField!
    
    @IBOutlet weak var distanceTxt: UITextField!
    
    @IBAction func btnSetting(_ sender: Any) {
     //NSDictionaryとして作る。 keyは必ずString。
        let putData: NSDictionary = ["Distance1": distanceTxt.text ?? ""]
        print("action setting")
        print(distanceTxt.text)
     //書き込む
     let manager = FileManager.default
     let documentDir = manager.urls(for: .documentDirectory, in: .userDomainMask)[0]
     let url = documentDir.appendingPathComponent("setting.plist")
     putData.write(to:url, atomically: true)

    }
    /**
     初期化する
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        var strDistance : String
        //load properties
        var property: Dictionary<String, String> = [:]
        let path = Bundle.main.path(forResource: "setting", ofType: "plist")
        let configurations = NSDictionary(contentsOfFile: path!)
        // マスタデータを取得する
        if let _: [String : Any]  = configurations as? [String : String] {
            property = configurations as! Dictionary<String, String>
        }
        
        print("Setting view")
        
        
        strDistance = property["Distance"]  ?? "200" 
        print(strDistance)
        // Do any additional setup after loading the view.
        alarmTimesTxt.text = "3"
      //  distanceTxt.text = property["Distance"] as? String
        distanceTxt.text = strDistance
    }


}
