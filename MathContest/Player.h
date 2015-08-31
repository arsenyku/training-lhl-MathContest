//
//  Player.h
//  MathContest
//
//  Created by asu on 2015-08-31.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign, readonly) int score;
@property (nonatomic, assign, readonly) int livesLeft;

-(void)addPoint;
-(void)loseLife;
-(BOOL)isDead;
@end
