#import "HMRColorPalette.h"

@implementation HMRColorPalette

+ (UIColor *)colorWithIndex:(NSInteger)index {
    return [UIColor colorWithRed:index*10/255.0 green:0.6+index*15/255.0 blue:0.7 alpha:1.0];
}

@end
