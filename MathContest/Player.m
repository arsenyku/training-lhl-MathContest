//
//  Player.m
//  MathContest
//
//  Created by asu on 2015-08-31.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Player.h"

@interface Player()
@property (nonatomic, assign, readwrite) int livesLeft;
@end

@implementation Player

- (instancetype)init{
    self = [super init];
    if (self) {
        _livesLeft = 3;
    }
    return self;
}



-(void)loseLife{
    if ([self isDead])
        return;
    
    self.livesLeft--;
}

-(BOOL)isDead{
    return (self.livesLeft < 1);
}

@end
