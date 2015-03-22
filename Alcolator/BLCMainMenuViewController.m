//
//  BLCMainMenuViewController.m
//  Alcolator
//
//  Created by Shefali Kumar Friesen on 3/20/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCMainMenuViewController.h"
#import "ViewController.h"
#import "BLCWhiskeyViewController.h"

@interface BLCMainMenuViewController ()
@property(weak, nonatomic) UIButton *wineButton;
@property(weak, nonatomic) UIButton *whiskeyButton;

@end



@implementation BLCMainMenuViewController

- (void) loadView {
    self.wineButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine") forState:UIControlStateNormal];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey") forState:UIControlStateNormal];
    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = [[UIView alloc] init];
    
    [self.view addSubview:self.wineButton];
    [self.view addSubview:self.whiskeyButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.91f alpha:1];
    
    UIFont *bigFont = [UIFont boldSystemFontOfSize:20];
    
    [self.wineButton.titleLabel setFont:bigFont];
    [self.whiskeyButton.titleLabel setFont:bigFont];
    
    self.title = NSLocalizedString(@"Select Alcolator", @"Select Alcolator");
    // Do any additional setup after loading the view.
    
}

- (void) viewWillLayoutSubviews {
    CGRect wineButtonFrame, whiskeyButtonFrame;
    CGRectDivide(self.view.bounds, &wineButtonFrame, &whiskeyButtonFrame, CGRectGetWidth(self.view.bounds) / 2, CGRectMinXEdge);
    
    self.wineButton.frame = wineButtonFrame;
    self.whiskeyButton.frame = whiskeyButtonFrame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) winePressed:(UIButton *) sender {
    ViewController *wineVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void) whiskeyPressed:(UIButton *) sender {
    BLCWhiskeyViewController *whiskeyVC = [[BLCWhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end