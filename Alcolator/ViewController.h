//
//  ViewController.h
//  Alcolator
//
//  Created by Ellen Thuy Le on 11/23/15.
//  Copyright (c) 2015 Ellen Thuy Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (void)buttonPressed:(UIButton *)sender;

@end

