//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Chris Anderson on 7/31/12.
//  Copyright (c) 2012 Polutropos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@end
