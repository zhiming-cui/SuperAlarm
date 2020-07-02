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
    
    /**
     初期化する
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        alarmTimesTxt.text = ""
        distanceTxt.text = ""
    }


}
