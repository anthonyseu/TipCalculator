//
//  TipViewController.m
//  tipCalculator
//
//  Created by Li Jiao on 1/20/15.
//  Copyright (c) 2015 Li Jiao. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void) updateValues;
- (void) onSettingsButton;
@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self) {
        self.title = @"Tip Calculator";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
        }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tipRateArray = [defaults arrayForKey: @"tipRateArray"];
    NSUInteger count = [tipRateArray count];
    for (NSUInteger i = 0; i < count; i++) {
        float rate = [tipRateArray[i] floatValue];
        int intRate = rate * 100;
        NSString *rateStr = [NSString stringWithFormat:@"%d%%", intRate];
        [self.tipControl setTitle:rateStr forSegmentAtIndex:i];
        [self updateValues];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation`
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tipValues = [defaults arrayForKey: @"tipRateArray"];
    if ([tipValues count] == 0) {
        tipValues = @[@(0.1), @(0.15), @(0.2)];
    }
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex ] floatValue];
    float totalAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void) onSettingsButton {
        [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
