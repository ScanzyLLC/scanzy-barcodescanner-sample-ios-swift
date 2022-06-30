#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** Options for specifying the barcode formats that the library can detect. */
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

/** Options for specifying a barcode scanner. */
NS_SWIFT_NAME(ScanzyBSBarcodeOptions)
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

NS_ASSUME_NONNULL_END
