//
//  ViewController.m
//  ColorWorks-App
//
//  Created by Dana Buehre on 4/2/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "ViewController.h"
#import <ColorWorks/ColorWorks.h>

@interface ViewController () <CWColorPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)openColorPickerTapped:(UIButton *)sender {
    [self presentViewController:[[CWColorPickerViewController alloc] initWithColor:self.view.backgroundColor stackType:CWColorSpaceTypeHSBA delegate:self] animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.view.backgroundColor isDarkColor] ? UIStatusBarStyleLightContent : UIStatusBarStyleDarkContent;
}

- (void)colorUpdated:(UIColor *)color {
    self.view.backgroundColor = color;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)colorPicked:(UIColor *)color {
    self.view.backgroundColor = color;
}

@end
