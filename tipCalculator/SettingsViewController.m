//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Li Jiao on 1/20/15.
//  Copyright (c) 2015 Li Jiao. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tipTextField1;
@property (weak, nonatomic) IBOutlet UITextField *tipTextField2;
@property (weak, nonatomic) IBOutlet UITextField *tipTextField3;
- (IBAction)doUpdate:(id)sender;
- (void)updateDefaultTipRate;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tipRateArray = [defaults arrayForKey: @"tipRateArray"];
    NSUInteger count = [tipRateArray count];
    if (count > 0) {
        float rate = [tipRateArray[0] floatValue];
        NSString *rateStr = [NSString stringWithFormat:@"%0.2f", rate];
        [self.tipTextField1 setText:rateStr];
        
        rate = [tipRateArray[1] floatValue];
        rateStr = [NSString stringWithFormat:@"%0.2f", rate];
        [self.tipTextField2 setText:rateStr];
        
        rate = [tipRateArray[2] floatValue];
        rateStr = [NSString stringWithFormat:@"%0.2f", rate];
        [self.tipTextField3 setText:rateStr];
    }
}

- (IBAction)doUpdate:(id)sender {
    [self updateDefaultTipRate];
}
- (void)updateDefaultTipRate {
    float tip1 = [self.tipTextField1.text floatValue];
    float tip2 = [self.tipTextField2.text floatValue];
    float tip3 = [self.tipTextField3.text floatValue];
    NSArray *tipRateArray = [NSArray arrayWithObjects:@(tip1), @(tip2), @(tip3), nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tipRateArray forKey:@"tipRateArray"];
    [defaults synchronize];
}
@end
