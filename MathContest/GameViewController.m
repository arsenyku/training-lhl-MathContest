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

@end

@implementation GameViewController
- (IBAction)numberButtonPressed:(id)sender {
    NSInteger buttonTag = ((UIButton*)sender).tag;
    
    self.answerLabel.text = [NSString stringWithFormat:@"%@%d", self.answerLabel.text, (int)buttonTag];
    
}
- (IBAction)enterButtonPressed:(id)sender {
    NSNumber *answer = [self numberFromAnswer];
    Player* submitter = self.game.playerThisTurn;
    BOOL isCorrect = [self.game submitAnswer:answer];
    self.answerLabel.text = @"";
    [self refresh];
    
    [self showGameAlertWithMessage:[NSString stringWithFormat:@"%@'s answer is %@correct", submitter.name, isCorrect ? @"" : @"NOT "]
                       actionTitle:nil
           dismissalDelayInSeconds:1];
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

-(void)showGameAlertWithMessage:(NSString*)messageTitle
                    actionTitle:(NSString*)actionTitle
                         action:(void (^)(UIAlertAction *action))handler{
    
    UIAlertController* alert =
    	[UIAlertController alertControllerWithTitle:messageTitle
                                            message:nil
                                     preferredStyle:UIAlertControllerStyleAlert];
    
    if (actionTitle && handler){
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:actionTitle
                                                                style:UIAlertActionStyleDefault
                                                              handler:handler];
        
        [alert addAction:defaultAction];
    }
     [self presentViewController:alert animated:YES completion:nil];

}

-(void)dismissAlert{
    NSLog(@"dismiss alert");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showGameAlertWithMessage:(NSString*)messageTitle actionTitle:(NSString*)actionTitle dismissalDelayInSeconds:(int)delay{
    
    [NSTimer scheduledTimerWithTimeInterval:delay
                                     target:self
                                   selector:@selector(dismissAlert)
                                   userInfo:nil
                                    repeats:NO];
    
    [self showGameAlertWithMessage:messageTitle
                       actionTitle:actionTitle
                            action:nil];
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
        [self showGameAlertWithMessage:[NSString stringWithFormat:@"%@ won the game!",[self.game winner].name]
                           actionTitle:@"New Game!"
                                action:^(UIAlertAction *action) {
                                    [self newGame];
                                }];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.answerLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.answerLabel.layer.borderWidth = 0.3f;
    [self newGame];
}

-(void)newGame{
    self.game = [[GameController alloc] initWithPlayer1Name:@"Khareem" player2Name:@"Julius"];
    self.answerLabel.text = @"";
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
