//
//  UIColor+ColorWorks_Internal.m
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "UIColor+ColorWorks_Internal.h"
#import "UIColor+ColorWorks.h"

@implementation UIColor (ColorWorks_Internal)

- (UIImage *)imageWithSize:(CGSize)size {
    return [[[UIGraphicsImageRenderer alloc] initWithSize:size] imageWithActions:^(UIGraphicsImageRendererContext *rendererContext) {
        [self setFill];
        [rendererContext fillRect:CGRectMake(0, 0, size.width, size.height)];
    }];
}

+ (NSArray *)hueColors {
    NSMutableArray *colors = [NSMutableArray new];
    for (NSInteger deg = 0; deg <= 360; deg += 5) {
        [colors addObject:(__bridge id)[UIColor colorWithHue:1.0f * deg / 360.0f saturation:1.0f brightness:1.0f alpha:1.0f].CGColor];
    }
    return colors.copy;
}

+ (NSArray *)someColors {
    NSMutableArray *colors = [NSMutableArray new];
    for (NSInteger deg = 0; deg <= 360; deg += 1) {
        [colors addObject:[UIColor colorWithHue:1.0f * deg / 360.0f saturation:1.0f brightness:1.0f alpha:1.0f]];
    }
    return colors.copy;
}

- (CGFloat)valueForType:(CWSliderType)sliderType {
    CGFloat value = 0;
    
    switch (sliderType) {
        case CWSliderTypeAlpha:        { [self getHue:nil saturation:nil brightness:nil alpha: &value]; } break;
        case CWSliderTypeHue:          { [self getHue:&value saturation:nil brightness:nil alpha:nil]; } break;
        case CWSliderTypeSaturation:   { [self getHue:nil saturation:&value brightness:nil alpha:nil]; } break;
        case CWSliderTypeBrightness:   { [self getHue:nil saturation:nil brightness:&value alpha:nil]; } break;
        case CWSliderTypeRed:          { [self getRed:&value green:nil blue:nil alpha:nil]; } break;
        case CWSliderTypeGreen:        { [self getRed:nil green:&value blue:nil alpha:nil]; } break;
        case CWSliderTypeBlue:         { [self getRed:nil green:nil blue:&value alpha:nil]; } break;
        case CWSliderTypeCyan:         { value = [self.CMYKAValues[0] doubleValue]; } break;
        case CWSliderTypeMagenta:      { value = [self.CMYKAValues[1] doubleValue]; } break;
        case CWSliderTypeYellow:       { value = [self.CMYKAValues[2] doubleValue]; } break;
        case CWSliderTypeBlack:        { value = [self.CMYKAValues[3] doubleValue]; } break;
    }
    
    return value;
}

- (UIColor *)colorByApplyingValue:(CGFloat)value sliderType:(CWSliderType)sliderType {
    UIColor *color;
    
    switch (sliderType) {
        case CWSliderTypeHue: {
            NSArray *components = self.HSBAValues;
            color = hsba(value, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue]);
        } break;
        case CWSliderTypeAlpha: {
            NSArray *components = self.HSBAValues;
            color = hsba([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], value);
        } break;
        case CWSliderTypeSaturation: {
            NSArray *components = self.HSBAValues;
            color = hsba([components[0] doubleValue], value, [components[2] doubleValue], [components[3] doubleValue]);
        } break;
        case CWSliderTypeBrightness: {
            NSArray *components = self.HSBAValues;
            color = hsba([components[0] doubleValue], [components[1] doubleValue], value, [components[3] doubleValue]);
        } break;
        case CWSliderTypeRed: {
            NSArray *components = self.RGBAValues;
            color = rgba(value, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue]);
        } break;
        case CWSliderTypeGreen: {
            NSArray *components = self.RGBAValues;
            color = rgba([components[0] doubleValue], value, [components[2] doubleValue], [components[3] doubleValue]);
        } break;
        case CWSliderTypeBlue: {
            NSArray *components = self.RGBAValues;
            color = rgba([components[0] doubleValue], [components[1] doubleValue], value, [components[3] doubleValue]);
        } break;
        case CWSliderTypeCyan: {
            NSArray *components = self.CMYKAValues;
            color = cmyka(value, [components[1] doubleValue], [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]);
        } break;
        case CWSliderTypeMagenta: {
            NSArray *components = self.CMYKAValues;
            color = cmyka([components[0] doubleValue], value, [components[2] doubleValue], [components[3] doubleValue], [components[4] doubleValue]);
        } break;
        case CWSliderTypeYellow: {
            NSArray *components = self.CMYKAValues;
            color = cmyka([components[0] doubleValue], [components[1] doubleValue], value, [components[3] doubleValue], [components[4] doubleValue]);
        } break;
        case CWSliderTypeBlack: {
            NSArray *components = self.CMYKAValues;
            color = cmyka([components[0] doubleValue], [components[1] doubleValue], [components[2] doubleValue], value, [components[4] doubleValue]);
        } break;
    }
    
    return color;
}

@end
