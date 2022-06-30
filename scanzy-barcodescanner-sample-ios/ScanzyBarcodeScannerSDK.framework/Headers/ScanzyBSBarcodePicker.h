//
//  ScanzyBSBarcodePicker.h
//
//  Created by Forrest on 5/7/22.
//

#import <UIKit/UIKit.h>
#import "ScanzyBSBarcodeOptions.h"
#import "ScanzyBSLicense.h"

//@import MLImage;
//@import MLKit;

NS_ASSUME_NONNULL_BEGIN

@class ScanzyBSBarcodePicker;

@protocol ScanzyBarcodeScannedProtocolDelegate
- (void)getBarcode:(NSString*)barcode;
@end

@interface ScanzyBSBarcodePicker : UIViewController

@property ScanzyBSBarcodeOptions* barcodeOptions;
@property (nonatomic, weak) id<ScanzyBarcodeScannedProtocolDelegate> delegate;

//@property(nonatomic, strong) MLKBarcodeScanner *mlBarcoder;

- (instancetype)initWithOptions:(ScanzyBSBarcodeOptions *)options;

- (void)addCancel;
- (void)addTorch;

@end

NS_ASSUME_NONNULL_END
