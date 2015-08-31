//
//  GameController.m
//  MathContest
//
//  Created by asu on 2015-08-31.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "GameController.h"

@interface GameController()

@property (nonatomic, strong, readwrite) Player *player1;
@property (nonatomic, strong, readwrite) Player *player2;

@property (nonatomic, strong, readwrite) Player *playerThisTurn;
@property (nonatomic, strong, readwrite) BinaryMathOperation *currentQuestion;
@end


@implementation GameController

- (instancetype)init{
    return [self initWithPlayer1Name:@"P1" player2Name:@"P2"];
}

- (instancetype)initWithPlayer1Name:(NSString*)player1Name player2Name:(NSString*)player2Name{
    self = [super init];
    if (self) {
        _player1 = [Player new];
        _player1.name = player1Name;
        
        _player2 = [Player new];
        _player2.name = player2Name;
        
        _playerThisTurn = _player1;
        [self newQuestion];
    }
    return self;
}

-(NSNumber*)randomValueFromLow:(int)low upToAndIncludingHigh:(int)high{
    return [NSNumber numberWithInt:(arc4random_uniform(high-low+1) + low)];
}

-(Player*)switchCurrentPlayer{
    self.playerThisTurn = (self.playerThisTurn == self.player1) ? self.player2 : self.player1;
    return self.playerThisTurn;
}

-(BinaryMathOperation*)newQuestion{
    NSNumber *left = [self randomValueFromLow:1 upToAndIncludingHigh:20];
    NSNumber *right = [self randomValueFromLow:1 upToAndIncludingHigh:20];
    Operation operation = [[self randomValueFromLow:(int)Plus upToAndIncludingHigh:(int)Minus] intValue];
    
    self.currentQuestion = [[BinaryMathOperation alloc] initWithOperand:left operation:operation otherOperand:right];
    return self.currentQuestion;
}

-(BOOL)checkAnswer:(NSNumber*)answer{
	return [self.currentQuestion.solution isEqual:answer];
}

-(BOOL)submitAnswer:(NSNumber*)answer{
    NSLog(@"submitAnswer received: %@", answer);
    BOOL isCorrect = [self checkAnswer:answer];
    
    if (isCorrect){
        [self.playerThisTurn addPoint];
    } else {
        [self.playerThisTurn loseLife];
    }
    
    [self switchCurrentPlayer];
    [self newQuestion];
    
    
    return isCorrect;
    
}
@end
