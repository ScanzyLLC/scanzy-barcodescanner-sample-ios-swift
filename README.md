# scanzy-barcodescanner-sample-android-ios
native ios sample to use ScanzyBarcodeScannerSDK


Follow below steps to use ScanzyBarcodeScannerSDK.

## Install ScanzyBarcodeScannerSDK.framework

1. download ScanzyBarcodeScannerSDK.framework from XXX.
2. put the ScanzyBarcodeScannerSDK.framework to root folder in your app (or any other places within your app).
3. drag the ScanzyBarcodeScannerSDK.framework to your project's left navigator panel in XCode. 
4. add resources ScanzyBarcodeScannerSDK.framework/ScanzyBarcodeScannerSDK.bundle to your resources bundle.
5. add AVFoundation.framework, CoreMedia.framework, AudioToolbox.framework, libc++.tbd to your project.


## Start to scan. (swift code example)

1. In your app's entry point, such as application func in AppDelegate, set the license key you obtained from Scanzy.

```swift
ScanzyBSLicense.setLicense("your-valid-licensekey")
```

For example, the code in the sample app:

```swift
   import ScanzyBarcodeScannerSDK

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ScanzyBSLicense.setLicense("your-valid-licensekey")
        return true
    }
    
```

Note: Although it's not harmful to call ScanzyBSLicense.setLicense multiple times, even on every single scan, it's better to call it just once in your app's entry point.

2. In your app's specific place, such as button click where you need to trigger the barcode scan. add below code:

In your view controller, need to implement protocol ViewController ScanzyBarcodeScannedProtocolDelegate

```swift
class ViewController: UIViewController,ScanzyBarcodeScannedProtocolDelegate {
   func getBarcode(_ barcode: String) {
       //your actual business logic to deal with barcode.
    }

...
}
```

In the specific place, such as button click in the view, launch the scan view:

```swift
import ScanzyBarcodeScannerSDK

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
                self.present(
                    self.scanView!,
                    animated: true,
                    completion: nil
                )
 }
```

Firstly, you need to specify the barcode formats you would like to support, and other options.

```swift
let formats:ScanzyBSBarcodeFormat = [.Code128, .Code39, .UPCA, .UPCE]
let barcodeOptions = ScanzyBSBarcodeOptions(
                    options: formats,
                    vibrate: true,
                    beep: true,
                    autoZoom:true,
                    scanCropRectOnly: true)
```

Create a barcode scan view with the barcodeOptions:

```swift
var scanView: ScanzyBSBarcodePicker? = nil
self.scanView = ScanzyBSBarcodePicker.init(options: barcodeOptions)
```

Set the scanview delegate to self(the current viewController), so that scanview knows how to return the barcode back.
```swift
self.scanView?.delegate = self
```

Finally, present the scanview:

```swift
self.present(
                    self.scanView!,
                    animated: true,
                    completion: nil
                )
```


That is all you need to use ScanzyBarcodeScannerSDK, happy coding :joy:

Below gives you more details about the parameters:

The definition of ScanzyBarcodeFormat:

```objective-c

typedef NS_OPTIONS(NSInteger, ScanzyBSBarcodeFormat) {
  None = 0x0000,
  /** Code-128. */
  Code128 = 0x0001,
  /** Code-39. */
  Code39 = 0x0002,
  /** Code-93. */
  Code93 = 0x0004,
  /** Codabar. */
  CodaBar = 0x0008,
  /** Data Matrix. */
  DataMatrix = 0x0010,
  /** EAN-13. */
  EAN13 = 0x0020,
  /** EAN-8. */
  EAN8 = 0x0040,
  /** ITF. */
  ITF = 0x0080,
  /** QR Code. */
  QRCode = 0x0100,
  /** UPC-A. */
  UPCA = 0x0200,
  /** UPC-E. */
  UPCE = 0x0400,
  /** PDF-417. */
  PDF417 = 0x0800,
  /** Aztec code. */
  Aztec = 0x1000,
  MaxiCode = 0x2000
} NS_SWIFT_NAME(ScanzyBSBarcodeFormat);

```
Note: to set the formats you only interested, although you can add ALL formats, it definitely would impact the performance.


The ScanzyBarcodeOptions is defined as:

```objective-c
@interface ScanzyBSBarcodeOptions : NSObject

/**
 * The barcode formats detected in an image. Note that the detection time will increase for each
 * additional format that is specified.
 */
@property(nonatomic, assign) ScanzyBSBarcodeFormat formats;
@property(nonatomic, assign) BOOL enableVibration;
@property(nonatomic, assign) BOOL enableBeep;
@property(nonatomic, assign) BOOL autoZoom;
@property(nonatomic, assign) BOOL scanCropRectOnly;

/**
 * Initializes an instance with the given barcode formats to look for.
 *
 * @param formats The barcode formats to initialize the barcode scanner options.
 * @return A new instance of barcode scanner options.
 */
- (instancetype)initWithOptions:(ScanzyBSBarcodeFormat)formats 
                                  vibrate:(BOOL)enableVibration 
                                  beep:(BOOL)enableBeep
                                  autoZoom:(BOOL)autoZoom
                                  scanCropRectOnly:(BOOL)scanCropRectOnly;

@end
```

enableBeep: play the beep sound when barcode detected.<br>

enableVibration: vibrate your phone when barcode detected.<br>

autoZoom: the library will zoom in/out automatcially to scan the barcode.<br>

scanCropRectOnly: only scan the view finder area.<br>

formats: the barcode formats.<br>
