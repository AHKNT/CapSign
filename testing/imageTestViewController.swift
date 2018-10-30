//
//  imageTestViewController.swift
//  testing
//
//  Created by 大家拓 on 2018/10/10.
//  Copyright © 2018年 大家拓. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class imageTestViewController: UIViewController {
    
    
}
class getImageAction: UIButton {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let urlstr = "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"
        let url = NSURL(string: urlstr);
        
        do{
            let data = try Data(contentsOf: url! as URL)
            let image = UIImage(data: data)
            let myImageName = urlstr.replacingOccurrences(of:"/", with:"=") // 変換
            //let imagePath = self.fileInDocumentsDirectory(filename: myImageName)
            let imagePath = NSHomeDirectory() + "/Library/Caches/" + myImageName
            
            if(self.saveImage(image: image!, path: imagePath)){
                messageLabel.text = "保存成功"
                print("succeced")
            } else {
                messageLabel.text = "保存失敗"
                print("failed")
            }
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
    }
    
    // DocumentディレクトリのfileURLを取得
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        return documentsURL
    }
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool {
        let pngImageData = image.pngData()
        do {
            try pngImageData!.write(to: URL(fileURLWithPath: path), options: .atomic)
            
            let SaveImageDataset = SaveImageDataSet()
            SaveImageDataset.image_id = 1
            SaveImageDataset.image_path = path
            SaveImageDataset.save()
            
        } catch {
            print(error)
            return false
        }
        return true
    }
}
class showImage: UIButton {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var aaa: UIImageView!
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let realm = try! Realm()
        let image = realm.objects(SaveImageDataSet.self).last
        print(image!.image_path)
        
        
        let showImage: UIImage = loadImageFromPath(path: image!.image_path)!
        aaa?.image = showImage
    
        
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("missing image at: \(path)")
        }
        return image
    }
    
//    func exsistImageFile(url: String) -> Bool{
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do {
//            //let fetchRequest: NSFetchRequest<ImageFile> = ImageFile.fetchRequest()
//            //fetchRequest.predicate = NSPredicate(format: "url = %@", url)
//            
//            let count = try context.count(for: fetchRequest)
//            if count > 0 {
//                return true
//            }
//        } catch {
//            print("Fetching Failed.")
//        }
//        return false
//    }
}

