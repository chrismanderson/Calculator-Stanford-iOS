//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Chris Anderson on 7/31/12.
//  Copyright (c) 2012 Polutropos. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userEnteredADecimal;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize brainText;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}
- (IBAction)clearAll
{
    [_brain clearState];
    self.display.text = @"";
    self.brainText.text = @"";
}

- (void)appendToBrainLabel:(NSString *)value
{
    self.brainText.text = [self.brainText.text stringByAppendingFormat:@"%@", value];
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    [self appendToBrainLabel:digit];
}

- (IBAction)decimalPressed
{
    if ([self.display.text rangeOfString:@"."].location == NSNotFound) {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        [self appendToBrainLabel:@"."];
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    [self appendToBrainLabel:@" "];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}
- (IBAction)operationPressed:(id)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    [self appendToBrainLabel:[NSString stringWithFormat:@" %@ ", operation]];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}
@end
