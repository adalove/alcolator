//
//  ViewController.m
//  Alcolator
//
//  Created by Shefali Kumar Friesen on 3/6/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>


@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;
@property (weak, nonatomic) UILabel *sliderLabel;
@property (weak, nonatomic) UISlider *slider;

@end

@implementation ViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    self.resultLabel.numberOfLines = 0;
    self.view.backgroundColor = [UIColor colorWithRed:0.741 green:0.925 blue:0.714 alpha:1];
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat viewWidth = 320;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 30;
    
    self.beerPercentTextField.frame = CGRectMake(60, 60, itemWidth, itemHeight);
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    if (enteredNumber == 0) {
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    NSString * sliderValue = [NSString stringWithFormat:@"%f", self.slider.value];
    self.sliderLabel.text = sliderValue;
    self.title = NSLocalizedString(@"Glasses of wine", @"wine");
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
}

//- (void)tabBarController:(UITabBarController *)tabBarController
// didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"the %@ controller has been selected");
//}

- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    NSString *wineText;
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    

}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    CGFloat viewWidth = size.width;
    CGFloat itemHeight = size.height;

}



@end
