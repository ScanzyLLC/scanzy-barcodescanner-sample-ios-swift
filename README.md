# scanzy-barcodescanner-sample-android-ios
native ios sample to use ScanzyBarcodeScannerSDK


## Get Started

### Install ScanzyBarcodeScannerSDK

Add below pod to the Podfile under your project root folder, (create the Podfile file if it doesn't exist)

```
pod 'ScanzyBarcodeScannerSDK', '~> 0.0.3'
```


### Start to scan. (swift code example)

1. In your app's entry point, such as application func in AppDelegate, set the license key you obtained from Scanzy.

```swift
ScanzyBarcodeManager.setLicense("your-valid-licensekey")
```

For example, the code in the sample app:

```swift
   import ScanzyBarcodeScannerSDK

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ScanzyBarcodeManager.setLicense("BdyCh9eyxw$9#k2qX79Z") //NOTE: BdyCh9eyxw$9#k2qX79Z is just a 7 days free trial key, you should purchase a valid key from Scanzy
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
        let formats:ScanzyBSBarcodeFormat = [.Code128, .Code39, .UPCA, .UPCE]
        let barcodeOptions = ScanzyBSBarcodeOptions(
            options: formats,
            vibrate: true,
            beep: true,
            autoZoom:true,
            scanCropRectOnly: true)
        
        //presentedBy: the view class which used to present the scan UI, such as self of this view controller
        //barcodeResultDelegate: the class which implements the func getBarcode(_ barcode: String) protocol
        ScanzyBarcodeManager.scan(barcodeOptions, presentedBy: self, barcodeResultDelegate: self)
 }
```

That is all you need to use ScanzyBarcodeScannerSDK, happy coding :joy:

## API Specification

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
