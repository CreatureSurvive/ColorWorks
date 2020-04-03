//
//  CWColorDisplayView.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CWColorDisplayView : UILabel

@property (nonatomic, strong) UIColor *color;

- (instancetype)initWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
