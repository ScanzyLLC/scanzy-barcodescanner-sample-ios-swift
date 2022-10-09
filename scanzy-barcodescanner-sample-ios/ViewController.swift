//
//  ViewController.swift
//  scanzy-barcodescanner-sample-ios
//
//  Created by Forrest on 6/29/22.
//

import UIKit
import ScanzyBarcodeScannerSDK

class ViewController: UIViewController,ScanzyBarcodeScannedProtocolDelegate {
   
    func getBarcode(_ barcode: String,barcodeType: String) {
        let dialogMessage = UIAlertController(title: "Barcode & Type", message: barcode + " Type: " + barcodeType, preferredStyle: .alert)
        // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBOutlet weak var btnScan: UIButton!
    
    @IBAction func barcode_scan(_ sender: Any) {
        
        let formats:ScanzyBSBarcodeFormat = [.Code128, .Code39, .UPCA, .UPCE, .QRCode]
        let barcodeOptions = ScanzyBSBarcodeOptions(
            options: formats,
            vibrate: true,
            beep: true,
            autoZoom:true,
            scanCropRectOnly: true)
        
        ScanzyBarcodeManager.scan(barcodeOptions, presentedBy: self, barcodeResultDelegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

