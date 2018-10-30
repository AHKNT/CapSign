//
//  ViewController.swift
//  testing
//
//  Created by 大家拓 on 2018/09/20.
//  Copyright © 2018年 大家拓. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var configButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //------------------------mainButton---------------------------------
        //ボタンの背景の色設定
        mainButton.backgroundColor = UIColor.white
        //ボタン画像
        mainButton.setImage(UIImage.init(named: "main_on_image.png"), for: UIControl.State.normal)
        mainButton.setImage(UIImage.init(named: "main_on_image.png"), for: UIControl.State.highlighted)
        //ボタン画像のアスペクト比保持
        mainButton.imageView?.contentMode = .scaleAspectFit
        mainButton.contentHorizontalAlignment = .fill
        mainButton.contentVerticalAlignment = .fill
        //ボタンの中身設定
        //mainButton.setTitle("", for: UIControl.State.normal)
        //ボタンのタイトルの色設定
        mainButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        //ボタンのボーダー色
        mainButton.layer.borderColor = UIColor.blue.cgColor
        //ボタンのボーダー幅
        mainButton.layer.borderWidth = 2.0
        //ボタンの角丸半径
        mainButton.layer.cornerRadius = 10.0
        //ボタンの影ぼかし 低いほどぼかし少
        mainButton.layer.shadowOpacity = 0.5
        //ボタンの影 大きさ
        mainButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        //------------------------configButton------------------------------
        configButton.backgroundColor = UIColor.white
        configButton.setImage(UIImage.init(named: "config_image.png"), for: UIControl.State.normal)
        configButton.setImage(UIImage.init(named: "config_image.png"), for: UIControl.State.highlighted)
        configButton.imageView?.contentMode = .scaleAspectFit
        configButton.contentHorizontalAlignment = .fill
        configButton.contentVerticalAlignment = .fill
        //configButton.setTitle("設定", for: UIControl.State.normal)
        configButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        configButton.layer.borderColor = UIColor.red.cgColor
        configButton.layer.borderWidth = 2.0
        configButton.layer.cornerRadius = 10.0
        configButton.layer.shadowOpacity = 0.5
        configButton.layer.shadowOffset = CGSize(width: 5, height: 5)

        //------------------------helpButton---------------------------------
        helpButton.backgroundColor = UIColor.white
        //ボタン画像
        helpButton.setImage(UIImage.init(named: "help_image.png"), for: UIControl.State.normal)
        helpButton.setImage(UIImage.init(named: "help_image.png"), for: UIControl.State.highlighted)
        helpButton.imageView?.contentMode = .scaleAspectFit
        helpButton.contentHorizontalAlignment = .fill
        helpButton.contentVerticalAlignment = .fill
        //helpButton.setTitle("へルプ", for: UIControl.State.normal)
        helpButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        helpButton.layer.borderColor = UIColor.gray.cgColor
        helpButton.layer.borderWidth = 2.0
        helpButton.layer.cornerRadius = 10.0
        helpButton.layer.shadowOpacity = 0.5
        helpButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        
        
        
        
    }


}

