//
//  CWColorDisplayView.m
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "CWColorDisplayView.h"
#import "UIColor+ColorWorks_Internal.h"

@implementation CWColorDisplayView

- (instancetype)initWithColor:(UIColor *)color {
    
    if (self == [super init]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize: 30 weight:UIFontWeightBold];
        self.adjustsFontSizeToFitWidth = YES;
        self.layer.cornerRadius = 12;
        self.layer.masksToBounds = YES;
        self.layer.cornerCurve = kCACornerCurveContinuous;
        self.color = color;
        
//        UILabel *accessory = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
//        accessory.font = [UIFont systemFontOfSize: 30 weight:UIFontWeightBold];
//        accessory.backgroundColor = UIColor.systemBackgroundColor;
//        accessory.adjustsFontSizeToFitWidth = YES;
//        self.inputAccessoryView = accessory;
    }
    
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.text = color.hexStringValue;
    self.backgroundColor = color;
    self.textColor = color.isDarkColor ? UIColor.lightTextColor : UIColor.darkTextColor;
}


@end
