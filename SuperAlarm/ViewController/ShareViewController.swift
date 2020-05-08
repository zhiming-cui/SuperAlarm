//
//  ShareViewController.swift
//  SuperAlarm
//
//  位置共有画面処理
//  Created by lion on 2020/03/21.
//  Copyright © 2020 lion. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    
    @IBOutlet weak var longitudeLbl: UITextField!
    @IBOutlet weak var latitudeLbl: UITextField!
    @IBOutlet weak var msgLbl: UILabel!
    
    /**
       画面初期化する
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /**
       確認ボタンをタップする
    */
    @IBAction func confirmBtn(_ sender: Any) {
        //経緯度設定
        let latitude = Double(latitudeLbl.text!)
        Globalvariables.objectLatitude = latitude!
        
        let longitude = Double(longitudeLbl.text!)
        Globalvariables.objectLongitude  = longitude!
        
        Globalvariables.startFlg = true
        self.dismiss(animated: true, completion: nil)
        
        Globalvariables.objectName = "座標"
        
    }
    
}
