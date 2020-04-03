//
//  CWGradientView.m
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "CWGradientView.h"
#import "UIColor+ColorWorks_Internal.h"

@implementation CWGradientView

- (instancetype)initWithColors:(NSArray *)colors {
    if (self == [super init]) {
        self.startPoint = CGPointMake(0, 0.5);
        self.endPoint = CGPointMake(1, 0.5);
        self.cornerCurve = kCACornerCurveContinuous;
        self.masksToBounds = YES;
        self.cornerRadius = 10;
        self.borderWidth = 1;
        self.borderColor = UIColor.systemGrayColor.CGColor;
        self.colors = colors;
    }
    
    return self;
}

- (void)setColorsForSliderType:(CWSliderType)type primaryColor:(UIColor *)primary {
    switch (type) {
        
        case CWSliderTypeHue: {
            self.colors = UIColor.hueColors;
        } break;
        case CWSliderTypeAlpha: {
            NSArray *components = primary.HSBAValues;
            self.colors = @[(__bridge id)hsba([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], 0).CGColor,
                            (__bridge id)hsba([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], 1).CGColor];
        } break;
        case CWSliderTypeSaturation: {
            NSArray *components = primary.HSBAValues;
            self.colors = @[(__bridge id)hsba([components[0] doubleValue], 0, [components[2] doubleValue], [components[3] doubleValue]).CGColor,
                            (__bridge id)hsba([components[0] doubleValue], 1, [components[2] doubleValue], [components[3] doubleValue]).CGColor];
        } break;
        case CWSliderTypeBrightness: {
            NSArray *components = primary.HSBAValues;
            self.colors = @[(__bridge id)hsba([components[0] doubleValue], [components[1] doubleValue], 0, [components[3] doubleValue]).CGColor,
                            (__bridge id)hsba([components[0] doubleValue], [components[1] doubleValue], 1, [components[3] doubleValue]).CGColor];
        } break;
        case CWSliderTypeRed: {
            NSArray *components = primary.RGBAValues;
            self.colors = @[(__bridge id)rgba(0, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue]).CGColor,
                            (__bridge id)rgba(1, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue]).CGColor];
        } break;
        case CWSliderTypeGreen: {
            NSArray *components = primary.RGBAValues;
            self.colors = @[(__bridge id)rgba([components[0] doubleValue], 0, [components[2] doubleValue], [components[3] doubleValue]).CGColor,
                            (__bridge id)rgba([components[0] doubleValue], 1, [components[2] doubleValue], [components[3] doubleValue]).CGColor];
        } break;
        case CWSliderTypeBlue: {
            NSArray *components = primary.RGBAValues;
            self.colors = @[(__bridge id)rgba([components[0] doubleValue], [components[1] doubleValue], 0, [components[3] doubleValue]).CGColor,
                            (__bridge id)rgba([components[0] doubleValue], [components[1] doubleValue], 1, [components[3] doubleValue]).CGColor];
        } break;
        case CWSliderTypeCyan: {
            NSArray *components = primary.CMYKAValues;
            self.colors = @[(__bridge id)cmyka(0, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]).CGColor,
                            (__bridge id)cmyka(1, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]).CGColor];
        } break;
        case CWSliderTypeMagenta: {
            NSArray *components = primary.CMYKAValues;
            self.colors = @[(__bridge id)cmyka([components[0] doubleValue], 0, [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]).CGColor,
                            (__bridge id)cmyka([components[0] doubleValue], 1, [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]).CGColor];
        } break;
        case CWSliderTypeYellow: {
            NSArray *components = primary.CMYKAValues;
            self.colors = @[(__bridge id)cmyka([components[0] doubleValue], [components[1] doubleValue], 0, [components[3] doubleValue], [components[4] doubleValue]).CGColor,
                            (__bridge id)cmyka([components[0] doubleValue], [components[1] doubleValue], 1, [components[3] doubleValue], [components[4] doubleValue]).CGColor];
        } break;
        case CWSliderTypeBlack: {
            NSArray *components = primary.CMYKAValues;
            self.colors = @[(__bridge id)cmyka([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], 0, [components[4] doubleValue]).CGColor,
                            (__bridge id)cmyka([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], 1, [components[4] doubleValue]).CGColor];
        } break;
    }
}

@end
