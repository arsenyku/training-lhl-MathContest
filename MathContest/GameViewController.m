//
//  ViewController.m
//  MathContest
//
//  Created by asu on 2015-08-31.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property (nonatomic, strong) GameController* game;
@property (weak, nonatomic) IBOutlet UILabel *scorePlayer1Label;
@property (weak, nonatomic) IBOutlet UILabel *scorePlayer2Label;

@property (weak, nonatomic) IBOutlet UILabel *livesPlayer1Label;
@property (weak, nonatomic) IBOutlet UILabel *livesPlayer2Label;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;
@end

@implementation GameViewController
- (IBAction)numberButtonPressed:(id)sender {
    NSInteger buttonTag = ((UIButton*)sender).tag;
    
    self.answerLabel.text = [NSString stringWithFormat:@"%@%d", self.answerLabel.text, (int)buttonTag];
    
}
- (IBAction)enterButtonPressed:(id)sender {
    NSNumber *answer = [self numberFromAnswer];
    [self.game submitAnswer:answer];
    self.answerLabel.text = @"";
    [self refresh];
}

- (IBAction)clearButtonPressed:(id)sender {
	self.answerLabel.text = @"";
}

- (IBAction)plusMinusButtonPressed:(id)sender {
    NSNumber *answer = [self numberFromAnswer];
    float answerValue = [answer floatValue];
    
    if (answerValue > 0){
        
        self.answerLabel.text = [NSString stringWithFormat:@"-%@", self.answerLabel.text];
        
    
    } else {
        
        self.answerLabel.text = [self.answerLabel.text substringFromIndex:1];
    }
    
}

-(NSNumber*)numberFromAnswer{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *answer = [formatter numberFromString:self.answerLabel.text];
    return answer;
}

-(void)refresh{
    self.questionLabel.text = [NSString stringWithFormat:@"%@: %@",
                               self.game.playerThisTurn.name,
                               [self.game.currentQuestion displayableString] ];
    self.scorePlayer1Label.text = [NSString stringWithFormat:@"%@ score: %d", self.game.player1.name, self.game.player1.score];
    self.scorePlayer2Label.text = [NSString stringWithFormat:@"%@ score: %d", self.game.player2.name, self.game.player2.score];
    self.livesPlayer1Label.text = [NSString stringWithFormat:@"Lives: %d", self.game.player1.livesLeft];
    self.livesPlayer2Label.text = [NSString stringWithFormat:@"Lives: %d", self.game.player2.livesLeft];

    if ([self.game winner]){
        self.winnerLabel.text = [NSString stringWithFormat:@"WINNER: \n%@", [self.game winner].name];
        self.winnerLabel.alpha = 1.0;
    } else {
        self.winnerLabel.alpha = 0.0;
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.game = [[GameController alloc] initWithPlayer1Name:@"Khareem" player2Name:@"Julius"];
    self.answerLabel.text = @"";
    self.answerLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.answerLabel.layer.borderWidth = 0.3f;
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
