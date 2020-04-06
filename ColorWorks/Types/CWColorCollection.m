//
//  CWColorCollection.m
//  ColorWorks
//
//  Created by Dana Buehre on 4/3/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "CWColorCollection.h"

@implementation CWColorCollection

+ (instancetype)collectionWithTitle:(NSString *)title colors:(NSArray<UIColor *> *)colors {
    return [[CWColorCollection alloc] initWithTitle:title colors:colors];
}

- (instancetype)initWithTitle:(NSString *)title colors:(NSArray<UIColor *> *)colors {
    if (self = [super init]) {
        _title = title;
        _colors = colors;
    }
    
    return self;
}

- (NSInteger)count {
    return _colors.count;
}

+ (instancetype)defaultSystemColorsCollection {
    return [CWColorCollection collectionWithTitle:@"SYSTEM COLORS" colors:@[
            UIColor.systemRedColor,
            UIColor.systemOrangeColor,
            UIColor.systemYellowColor,
            UIColor.systemGreenColor,
            UIColor.systemTealColor,
            UIColor.systemBlueColor,
            UIColor.systemIndigoColor,
            UIColor.systemPurpleColor,
            UIColor.systemPinkColor,
            UIColor.systemGrayColor,
            UIColor.systemGray2Color,
            UIColor.systemGray3Color,
            UIColor.systemGray4Color,
            UIColor.systemGray5Color,
            UIColor.systemGray6Color,
            UIColor.whiteColor,
            UIColor.blackColor
    ]];
}

+ (instancetype)defaultPrimaryColorsCollection {
    return [CWColorCollection collectionWithTitle:@"PRIMARY COLORS" colors:@[
        UIColor.redColor,
        UIColor.orangeColor,
        UIColor.yellowColor,
        UIColor.greenColor,
        UIColor.blueColor,
        UIColor.purpleColor,
        UIColor.whiteColor,
        UIColor.grayColor,
        UIColor.darkGrayColor,
        UIColor.blackColor
    ]];
}

+ (instancetype)defaultHueColorsCollection {
    NSMutableArray *colors = [NSMutableArray new];
    for (NSInteger deg = 0; deg <= 360; deg += 1) {
        [colors addObject:[UIColor colorWithHue:1.0f * deg / 360.0f saturation:1.0f brightness:1.0f alpha:1.0f]];
    }
    return [CWColorCollection collectionWithTitle:@"HUE COLORS" colors:colors];
}

@end
