//
//  Player.h
//  MathContest
//
//  Created by asu on 2015-08-31.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic, assign, readonly) int livesLeft;
@property (nonatomic, strong) NSString* name;

-(void)loseLife;
-(BOOL)isDead;
@end
