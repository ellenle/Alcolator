//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Ellen Thuy Le on 11/24/15.
//  Copyright (c) 2015 Ellen Thuy Le. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Whiskey slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    self.title = [NSString stringWithFormat:@"Whiskey (%@)", [self calculateNumberOfShots]];
}


//method to calculate number of shots
- (NSString *)calculateNumberOfShots {
    
    // first - calculate how much alcohol is in all of those beers
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; //assume 12oz beer bottles
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    //then, calculate the equivalent of whiskey
    float ouncesInOneWhiskeyGlass = 1;  // a 1 oz shot
    float alcoholPercentageOfWhiskey = 0.4;  // 40% is average alc content of whiskey
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    //decide whether to use 'beer' or 'beers'
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    return [NSString stringWithFormat:NSLocalizedString(@"%.1f %@", nil), numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
}



-(void)buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; //assume 12 oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %@ of whiskey.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], [self calculateNumberOfShots]];
    self.resultLabel.text = resultText;
}

@end
