//
//  ViewController.m
//  Alcolator
//
//  Created by Ellen Thuy Le on 11/23/15.
//  Copyright (c) 2015 Ellen Thuy Le. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    if (enteredNumber == 0) {
        // user typed 0, or something that's not a number - clear the field!
        sender.text = nil;
    }
}
- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Wine slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    self.title = [NSString stringWithFormat:@"Wine (%@)", [self calculateNumberOfGlasses]];
}


//method to calculate number of glasses
- (NSString *)calculateNumberOfGlasses {
    
    // first - calculate how much alcohol is in all of those beers
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; //assume 12oz beer bottles
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    //then, calculate the equivalent of wine
    float ouncesInOneWineGlass = 5; // wine glass volume is 5 oz
    float alcoholPercentageOfWine = 0.13; // 13% average amount of alcohol
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    //decide whether to use 'beer', 'wine', or their plural counterparts
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    NSString *wineText;
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1 ) {
        wineText = NSLocalizedString(@"glass", "singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", "plural of glass");
    }
    
    return [NSString stringWithFormat:NSLocalizedString(@"%.1f %@", nil), numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
}

- (IBAction)buttonPressed:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    //calculate how much alcohol is in all of those beers
    int numberOfBeers = self.beerCountSlider.value;
    
    //decide whether to use 'beer', 'wine', or their plural counterparts
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    //generate restul text, display it on the label
    NSString *resultTest = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %@ of wine.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], [self calculateNumberOfGlasses]];
    self.resultLabel.text = resultTest;
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end

