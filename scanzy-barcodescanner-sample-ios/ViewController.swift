//
//  ViewController.swift
//  scanzy-barcodescanner-sample-ios
//
//  Created by Forrest on 6/29/22.
//

import UIKit
import ScanzyBarcodeScannerSDK

class ViewController: UIViewController,ScanzyBarcodeScannedProtocolDelegate {
    func getBarcode(_ barcode: String) {
        let dialogMessage = UIAlertController(title: "Barcode", message: barcode, preferredStyle: .alert)
        // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    var scanView: ScanzyBSBarcodePicker? = nil
    
    @IBOutlet weak var btnScan: UIButton!
    
    @IBAction func barcode_scan(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if(self.scanView == nil){
                let formats:ScanzyBSBarcodeFormat = [.Code128, .Code39, .UPCA, .UPCE]
            
                let barcodeOptions = ScanzyBSBarcodeOptions(
                    options: formats,
                    vibrate: true,
                    beep: true,
                    autoZoom:true,
                    scanCropRectOnly: true)
                
                self.scanView = ScanzyBSBarcodePicker.init(options: barcodeOptions)
                self.scanView?.delegate = self
                if #available(iOS 13.0, *) {
                    self.scanView?.isModalInPresentation = true
                } else {
                    // Fallback on earlier versions
                }
                
                guard self.presentedViewController == nil else {return}
                guard self.scanView!.isBeingPresented == false else {return}
                self.present(
                    self.scanView!,
                    animated: true,
                    completion: nil
                )
                
            }
            else{
                
                guard self.presentedViewController == nil else {return}
                guard self.scanView!.isBeingPresented == false else {return}
                let formats:ScanzyBSBarcodeFormat = [.Code128, .Code39, .UPCA, .UPCE]
                self.scanView?.barcodeOptions.formats = formats
                
                self.present(
                    self.scanView!,
                    animated: true,
                    completion: nil
                )
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

