//
//  AppConfig.swift
//  testing
//
//  Created by 大家拓 on 2018/09/27.
//  Copyright © 2018年 大家拓. All rights reserved.
//

//
//参考：https://qiita.com/syou007/items/267612c402fdd28de7a8
//  使い方 保存するとき
//  let configDataet = ConfigDataet()
//  configDataet.voice = true
//  configDataet.vivration = false
//  configDataet.save()
//
//  変更・新規登録
//  let realm = try! Realm()
//  let configDataet = realm.objects(ConfigDataet.self).first ?? ConfigDataet()
//  try! realm.write {
//      configDataet.voice = true
//      configDataet.vivration = true
//      configDataet.save()
//  }

import Foundation
import RealmSwift

//設定項目データベース
class ConfigDataSet: RealmObject {
    //音声案内のON/OFF
    @objc dynamic var voice = Bool()
    //バイブレーションのON/OFF
    @objc dynamic var vibration = Bool()
}

//標識テーブル
class TrafficSignDataSet: RealmObject {
    //標識のID guideDatasetとのリレーションあり
    @objc dynamic var sign_id = Int()
    //標識の名前
    @objc dynamic var sign_name = String()
    //写真の画像パス
    @objc dynamic var signPath = String()
    //標識の意味(漢字)
    @objc dynamic var meaning_char = String()
    //標識の意味(読み上げ用)
    @objc dynamic var meaning_speak = String()
    //標識の優先度
    @objc dynamic var priority = Int()
}

//メインの案内で使うやつ。ログとしても使う
class ImageDataSet: RealmObject {
    //唯一の画像ID
    @objc dynamic var image_id = Int()
    //画像の取得年月日
    @objc dynamic var acquisition_date = NSDate()
    //写真の画像パス
    @objc dynamic var image_path = String()
    //判断結果の可否
    @objc dynamic var gudgment = Bool()
    //結果：標識のID guideDatasetとのリレーションあり
    @objc dynamic var result_sign_id = Int()
}

//----------------------------------------------------------------------------画像テスト用
class SaveImageDataSet: RealmObject {
    @objc dynamic var image_id = Int()
    @objc dynamic var image_path = String()
}



class RealmObject: Object {
    // ID
    @objc dynamic var id = 0
    
    // データを保存。
    func save() {
        let realm = try! Realm()
        if realm.isInWriteTransaction {
            if self.id == 0 { self.id = self.createNewId() }
            realm.add(self, update: true)
        } else {
            try! realm.write {
                if self.id == 0 { self.id = self.createNewId() }
                realm.add(self, update: true)
            }
        }
    }
    
    // 新しいIDを採番します。
    private func createNewId() -> Int {
        let realm = try! Realm()
        return (realm.objects(type(of: self).self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
    }
    
    // プライマリーキーの設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
