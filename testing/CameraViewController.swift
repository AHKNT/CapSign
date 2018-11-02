//
//  imageTestViewController.swift
//  testing
//
//  Created by 大家拓 on 2018/10/10.
//  Copyright © 2018年 大家拓. All rights reserved.
//

import AVFoundation
import UIKit
import RealmSwift

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var detector: OpenCV!
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    // セッション
    var mySession : AVCaptureSession!
    // カメラデバイス
    var myDevice : AVCaptureDevice!
    // 出力先
    var myOutput : AVCaptureVideoDataOutput!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        detector = OpenCV();
        // カメラを準備
        if initCamera() {
            
        }
        
        
        // 撮影開始
        mySession.startRunning()
    }
    
    // カメラの準備処理
    func initCamera() -> Bool {
        // セッションの作成.
        mySession = AVCaptureSession()
        
        // 解像度の指定.
        mySession.sessionPreset = AVCaptureSession.Preset.medium
        
        // デバイス一覧の取得.
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        // プロパティの条件を満たしたカメラデバイスの取得
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if(device.position == AVCaptureDevice.Position.back){
                myDevice = device
            }
        }
        
        if myDevice == nil {
            return false
        }
        
        // バックカメラからVideoInputを取得.
        var myInput: AVCaptureDeviceInput! = nil
        do {
            myInput = try AVCaptureDeviceInput(device: myDevice) as AVCaptureDeviceInput
        } catch let error {
            print(error)
        }
        
        // セッションに追加.
        if mySession.canAddInput(myInput) {
            mySession.addInput(myInput)
        } else {
            return false
        }
        
        // 出力先を設定
        myOutput = AVCaptureVideoDataOutput()
        myOutput.videoSettings = ([ kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA) ] as! [String : Any])
        
        // FPSを設定
        do {
            try myDevice.lockForConfiguration()
            
            myDevice.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: 15)
            myDevice.unlockForConfiguration()
        } catch let error {
            print("lock error: \(error)")
            return false
        }
        
        // デリゲートを設定
        let queue: DispatchQueue = DispatchQueue(label: "myqueue",  attributes: [])
        myOutput.setSampleBufferDelegate(self, queue: queue)
        
        // セッションに追加.
        if mySession.canAddOutput(myOutput) {
            mySession.addOutput(myOutput)
        } else {
            return false
        }
        
        //カメラの向きを合わせる
        for connection in myOutput.connections{
            let conn = connection
            if conn.isVideoOrientationSupported{
                conn.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
            }
        }
        
        return true
    }
    
    //毎フレーム実行される処理
    var i = 1
    func captureOutput(_ captureOutput: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
    {
        DispatchQueue.main.sync(execute: {
            // UIImageへ変換
            let image = CameraUtil.imageFromSampleBuffer(sampleBuffer)
            // 顔認識
            let faceImage = self.detector?.recognizeFace(image)
            let cropping = faceImage!.cropping(to: CGRect(x:Int(self.detector.getRectPointX()),
                                                          y: Int(self.detector.getRectPointY()),
                                                          width: Int(self.detector.getRectPointWidth()),
                                                          height: Int(self.detector.getRectPointHeight()))
            )
            // 表示
            self.myImageView.image = faceImage
            
            //保存
            if(cropping != nil){
                if(self.saveImage(image: cropping!, path: NSHomeDirectory() + "/Library/Caches/cutImage\(i).png")){
                    i = i + 1
                    print("保存成功")
                } else {
                    print("保存失敗")
                }
            }
            print(self.detector.getRectPointX(),":",
                  self.detector.getRectPointY(),":",
                  self.detector.getRectPointHeight(),":",
                  self.detector.getRectPointWidth()
            )
            print("")
        })
        
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool {
        let pngImageData = image.pngData()
        do {
            try pngImageData!.write(to: URL(fileURLWithPath: path), options: .atomic)
        } catch {
            print(error)
            return false
        }
        return true
    }
}

extension UIImage {
    func cropping(to: CGRect) -> UIImage? {
        var opaque = false
        if let cgImage = cgImage {
            switch cgImage.alphaInfo {
            case .noneSkipLast, .noneSkipFirst:
                opaque = true
            default:
                break
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(to.size, opaque, scale)
        draw(at: CGPoint(x: -to.origin.x, y: -to.origin.y))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
