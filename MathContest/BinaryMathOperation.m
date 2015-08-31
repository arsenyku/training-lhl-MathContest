//
//  BinaryMathOperation.m
//  MathContest
//
//  Created by asu on 2015-08-31.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "BinaryMathOperation.h"

@implementation BinaryMathOperation

- (instancetype)init{
    return [self initWithOperand:@0 operation:Plus otherOperand:@0];
}

-(instancetype)initWithOperand:(NSNumber*)left operation:(Operation)operation otherOperand:(NSNumber*)right{
    self = [super init];
    if (self) {
        _leftOperand = left;
        _operation = operation;
        _rightOperand = right;
    }
    return self;
    
}


-(NSNumber*)solution{
    switch (self.operation) {
        case Plus:
            return [NSNumber numberWithFloat:[self.leftOperand floatValue] + [self.rightOperand floatValue]];
            break;
            
        case Minus:
            return [NSNumber numberWithFloat:[self.leftOperand floatValue] - [self.rightOperand floatValue]];
            break;
            
        case MultiplyBy:
            return [NSNumber numberWithFloat:[self.leftOperand floatValue] * [self.rightOperand floatValue]];
            break;
            
        case DivideBy:
            return [NSNumber numberWithFloat:[self.leftOperand floatValue] / [self.rightOperand floatValue]];
            break;
            
        default:
            return @0;
            break;
    }
}

-(NSString *)displayableString{
    switch (self.operation) {
        case Plus:
            return [NSString stringWithFormat:@"%@ + %@", self.leftOperand, self.rightOperand];
            break;
            
        case Minus:
            return [NSString stringWithFormat:@"%@ - %@", self.leftOperand, self.rightOperand];
            break;
            
        case MultiplyBy:
            return [NSString stringWithFormat:@"%@ * %@", self.leftOperand, self.rightOperand];
            break;
            
        case DivideBy:
            return [NSString stringWithFormat:@"%@ / %@", self.leftOperand, self.rightOperand];
            break;
            
        default:
            return @"";
            break;
    }
}


@end
