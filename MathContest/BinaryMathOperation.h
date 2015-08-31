//
//  BinaryMathOperation.h
//  MathContest
//
//  Created by asu on 2015-08-31.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, Operation) {
    Plus,
    Minus,
    MultiplyBy,
    DivideBy
};

@interface BinaryMathOperation : NSObject

@property (nonatomic, strong) NSNumber *leftOperand;
@property (nonatomic, assign) Operation operation;
@property (nonatomic, strong) NSNumber *rightOperand;

@property (nonatomic, strong, readonly) NSNumber *solution;

-(instancetype)initWithOperand:(NSNumber*)left operation:(Operation)operation otherOperand:(NSNumber*)right;

-(NSString *)displayableString;

@end
