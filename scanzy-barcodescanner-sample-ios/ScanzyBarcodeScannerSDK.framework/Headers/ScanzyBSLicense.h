#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanzyBSLicense : NSObject

+ (void)setLicense:(nonnull NSString *)license;

+ (NSString *)getLicense;

@end

NS_ASSUME_NONNULL_END
