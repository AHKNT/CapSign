//
//  ConfigViewController.swift
//  testing
//
//  Created by 大家拓 on 2018/09/21.
//  Copyright © 2018年 大家拓. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class ConfigViewController: UIViewController {
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var voiceConfigButton: UIButton!
    @IBOutlet weak var vibrationConfigButton: UIButton!
    @IBOutlet weak var saveConfigButton: UIButton!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //------------------------descriptionButton---------------------------------
        //ボタンの背景の色設定
        descriptionButton.backgroundColor = UIColor.white
        //ボタン画像
        //descriptionButton.setImage(UIImage.init(named: "main_on_image.png"), for: UIControl.State.normal)
        //descriptionButton.setImage(UIImage.init(named: "main_on_image.png"), for: UIControl.State.highlighted)
        //ボタン画像のアスペクト比保持
        descriptionButton.imageView?.contentMode = .scaleAspectFit
        descriptionButton.contentHorizontalAlignment = .fill
        descriptionButton.contentVerticalAlignment = .fill
        //ボタンの中身設定
        descriptionButton.setTitle("", for: UIControl.State.normal)
        //ボタンのタイトルの色設定
        descriptionButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        //ボタンのボーダー色
        descriptionButton.layer.borderColor = UIColor.rgba(red: 200, green: 188, blue: 28, alpha: 1).cgColor
        //ボタンのボーダー幅
        descriptionButton.layer.borderWidth = 2.0
        //ボタンの角丸半径
        descriptionButton.layer.cornerRadius = 10.0
        //ボタンの影ぼかし 低いほどぼかし少
        descriptionButton.layer.shadowOpacity = 0.5
        //ボタンの影 大きさ
        descriptionButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        
        //------------------------voiceConfigButton---------------------------------
        //ボタンの背景の色設定
        voiceConfigButton.backgroundColor = UIColor.white
        //ボタン画像
        //voiceConfigButton.setImage(UIImage.init(named: "main_on_image.png"), for: UIControl.State.normal)
        //voiceConfigButton.setImage(UIImage.init(named: "main_on_image.png"), for: UIControl.State.highlighted)
        //ボタン画像のアスペクト比保持
//        voiceConfigButton.imageView?.contentMode = .scaleAspectFit
//        voiceConfigButton.contentHorizontalAlignment = .fill
//        voiceConfigButton.contentVerticalAlignment = .fill
        //ボタンの中身設定
        voiceConfigButton.setTitle("VOICE", for: UIControl.State.normal)
        //ボタンのタイトルの色設定
        voiceConfigButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        //ボタンのボーダー色
        voiceConfigButton.layer.borderColor = UIColor.rgba(red: 200, green: 188, blue: 28, alpha: 1).cgColor
        //ボタンのボーダー幅
        voiceConfigButton.layer.borderWidth = 2.0
        //ボタンの角丸半径
        voiceConfigButton.layer.cornerRadius = 10.0
        //ボタンの影ぼかし 低いほどぼかし少
        voiceConfigButton.layer.shadowOpacity = 0.5
        //ボタンの影 大きさ
        voiceConfigButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        
        //------------------------vibrationConfigButton---------------------------------
        //ボタンの背景の色設定
        vibrationConfigButton.backgroundColor = UIColor.white
        //ボタンの中身設定
        vibrationConfigButton.setTitle("VIBRATION", for: UIControl.State.normal)
        //ボタンのタイトルの色設定
        vibrationConfigButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        //ボタンのボーダー色
        vibrationConfigButton.layer.borderColor = UIColor.rgba(red: 200, green: 188, blue: 28, alpha: 1).cgColor
        //ボタンのボーダー幅
        vibrationConfigButton.layer.borderWidth = 2.0
        //ボタンの角丸半径
        vibrationConfigButton.layer.cornerRadius = 10.0
        //ボタンの影ぼかし 低いほどぼかし少
        vibrationConfigButton.layer.shadowOpacity = 0.5
        //ボタンの影 大きさ
        vibrationConfigButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        //------------------------saveConfigButton---------------------------------
        //ボタンの背景の色設定
        saveConfigButton.backgroundColor = UIColor.rgba(red: 69, green: 151, blue: 255, alpha: 1)
        //ボタンの中身設定
        saveConfigButton.setTitle("SAVE", for: UIControl.State.normal)
        //ボタンのタイトルの色設定
        saveConfigButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        //ボタンのボーダー色
        saveConfigButton.layer.borderColor = UIColor.rgba(red: 200, green: 188, blue: 28, alpha: 1).cgColor
        //ボタンのボーダー幅
        saveConfigButton.layer.borderWidth = 2.0
        //ボタンの角丸半径
        saveConfigButton.layer.cornerRadius = 10.0
        //ボタンの影ぼかし 低いほどぼかし少
        saveConfigButton.layer.shadowOpacity = 0.5
        //ボタンの影 大きさ
        saveConfigButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension UIColor {
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}

