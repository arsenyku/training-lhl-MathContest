//
//  GameController.h
//  MathContest
//
//  Created by asu on 2015-08-31.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "BinaryMathOperation.h"

@interface GameController : NSObject

@property (nonatomic, strong, readonly) Player *player1;
@property (nonatomic, strong, readonly) Player *player2;

@property (nonatomic, strong, readonly) Player *playerThisTurn;
@property (nonatomic, strong, readonly) BinaryMathOperation *currentQuestion;


-(BinaryMathOperation*)newQuestion;
-(BOOL)submitAnswer:(NSNumber*)answer;

@end
