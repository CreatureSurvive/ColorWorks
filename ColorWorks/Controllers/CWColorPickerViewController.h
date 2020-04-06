//
//  CWColorPickerViewController.h
//  ColorWorks
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWColorPickerDelegate.h"
#import "CWColorSpaceType.h"
#import "CWColorCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface CWColorPickerViewController : UIViewController <CWColorPickerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong, nullable) CWColorCollection *colorCollection;

@property (nonatomic, weak) id <CWColorPickerDelegate> delegate;

- (instancetype)initWithColor:(UIColor *)color stackType:(CWColorSpaceType)stackType delegate:(id<CWColorPickerDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
