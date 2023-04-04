# scanzy-barcodescanner-sample-ios-swift
Native ios sample to use ScanzyBarcodeScannerSDK, which implements the barcode capture capabilities of the ScanzyBarcodeScannerSDK for iOS and Android. It supports reading a large number of different barcode symbologies, such as Code39, Code93, Code128, Codabar, UPC-A, UPC-E, EAN-8, EAN-13, ITF, QRCode, Aztec, PDF-417, Data Matrix, etc.


## Prerequisites

- To develop an iOS app, you need to use [XCode](https://developer.apple.com/xcode/)
- ScanzyBarcodeScannerSDK is delivered via CocoaPods, one of the most popular iOS package managers, if you haven't setup CocoaPods, check out the official site for more details.
[CocoaPods](https://guides.cocoapods.org/using/getting-started.html)


## Installation

### Install ScanzyBarcodeScannerSDK

Add the below pod to the Podfile under your project root folder, (create the Podfile file if it doesn't exist).

```
pod 'ScanzyBarcodeScannerSDK', '~> 0.0.6'
```

Then run: pod install --repo-update 
on your terminal in the root folder of your project.

### Quick Start

1. In your app's entry point, such as application func in AppDelegate, set the license key you obtained from [Scanzy](https://scanzy.com) for free trial.

```swift
ScanzyBarcodeManager.setLicense("your-valid-licensekey")
```

For example, the code in the sample app is:

```swift
   import ScanzyBarcodeScannerSDK

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ScanzyBarcodeManager.setLicense("your-valid-licensekey")
        return true
    }
    
```

Note: Although it's not harmful to call ScanzyBarcodeManager.setLicense multiple times, even on every single scan, it's better to call it just once in your app's entry point.

2. Add the below code in a specific place in your app, such as a button click where you need to trigger a barcode scan:

In your view controller, you need to implement protocol ViewController ScanzyBarcodeScannedProtocolDelegate

```swift
class ViewController: UIViewController,ScanzyBarcodeScannedProtocolDelegate {
   func getBarcode(_ barcode: String) {
       //your actual business logic to deal with barcode.
    }

...
}
```

In a specific place, such as a button click, launch the scan view:

```swift
import ScanzyBarcodeScannerSDK

 @IBAction func barcode_scan(_ sender: Any) {
        let formats:ScanzyBarcodeFormat = [.Code128, .Code39, .UPCA, .UPCE]
        let barcodeOptions = ScanzyBarcodeOptions(
            options: true,
            enableBeep: true,
            enableAutoZoom:true,
            enableScanRectOnly: true,
            formats:formats)
        
        //presentedBy: the view class which used to present the scan UI, such as self of this view controller
        //barcodeResultDelegate: the class which implements the func getBarcode(_ barcode: String) protocol
        ScanzyBarcodeManager.scan(barcodeOptions, presentedBy: self, barcodeResultDelegate: self)
 }
```

## API Specification

Below are more details about the parameters:

The definition of ScanzyBarcodeFormat:

```objective-c

typedef NS_OPTIONS(NSInteger, ScanzyBarcodeFormat) {
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
Note: Set only the formats you are interested in. You can add ALL formats, but it would impact performance.


ScanzyBarcodeOptions is defined as:

```objective-c
@interface ScanzyBarcodeOptions : NSObject

/**
 * The barcode formats detected in an image. Note that the detection time will increase for each
 * additional format that is specified.
 */
@property(nonatomic, assign) BOOL enableVibration;
@property(nonatomic, assign) BOOL enableBeep;
@property(nonatomic, assign) BOOL enableAutoZoom;
@property(nonatomic, assign) BOOL enableScanCropRectOnly;
@property(nonatomic, assign) ScanzyBarcodeFormat formats;

/**
 * Initializes an instance with the given barcode formats to look for.
 *
 * @param formats The barcode formats to initialize the barcode scanner options.
 * @return A new instance of barcode scanner options.
 */
- (instancetype)initWithOptions:  (BOOL)enableVibration 
                                  enableBeep:(BOOL)enableBeep
                                  enableAutoZoom:(BOOL)enableAutoZoom
                                  enableScanCropRectOnly:(BOOL)enableScanCropRectOnly
                                  formats:(ScanzyBarcodeFormat)formats;

@end
```

|     Parameter    |   Description         | 
| ------------- |:-------------:| 
| enableVibration      | vibrate your phone when a barcode is detected |
| enableBeep      |   play a beep sound when a barcode is detected    |  
| enableAutoZoom |   the library will zoom in/out automatcially to scan a barcode    |   
| enableScanCropRectOnly |   only scan the view finder area    |   
| formats |   the barcode formats    |   

