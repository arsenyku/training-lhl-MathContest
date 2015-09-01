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

#pragma mark - IBAction

- (IBAction)numberButtonPressed:(id)sender {
    NSInteger buttonTag = ((UIButton*)sender).tag;
    
    self.answerLabel.text = [NSString stringWithFormat:@"%@%d", self.answerLabel.text, (int)buttonTag];
    
}
- (IBAction)enterButtonPressed:(id)sender {
    NSNumber *answer = [self numberFromAnswer];
    Player* submitter = self.game.playerThisTurn;
    BinaryMathOperation *question = self.game.currentQuestion;
    BOOL isCorrect = [self.game submitAnswer:answer];
    self.answerLabel.text = @"";
    [self refresh];
    
    if ([self.game winner] == nil){
        NSString *correctAnswer = nil;
        if (!isCorrect)
            correctAnswer = [NSString stringWithFormat:@"%@ = %@", question.displayableString, question.solution];
        
        [self showGameAlertWithMessage:[NSString stringWithFormat:@"%@'s answer is %@correct", submitter.name, isCorrect ? @"" : @"NOT "]
                               message:correctAnswer
               dismissalDelayInSeconds:1
                           actionTitle:nil
                                action:nil];
    }
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

#pragma mark - Overrides


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.answerLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.answerLabel.layer.borderWidth = 0.3f;
    [self newGame];
}

#pragma mark - Private

-(NSNumber*)numberFromAnswer{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *answer = [formatter numberFromString:self.answerLabel.text];
    return answer;
}

-(void)showGameAlertWithMessage:(NSString*)messageTitle
                        message:(NSString*)message
        dismissalDelayInSeconds:(int)delay
                    actionTitle:(NSString*)actionTitle
                         action:(void (^)(UIAlertAction *action))handler{
    
    UIAlertController* alert =
    [UIAlertController alertControllerWithTitle:messageTitle
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    if (actionTitle && handler){
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:actionTitle
                                                                style:UIAlertActionStyleDefault
                                                              handler:handler];
        
        [alert addAction:defaultAction];
    }
    
    if (delay > 0){
        [NSTimer scheduledTimerWithTimeInterval:delay
                                         target:self
                                       selector:@selector(dismissAlert)
                                       userInfo:nil
                                        repeats:NO];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)dismissAlert{
    [self dismissViewControllerAnimated:YES completion:nil];
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
                               message:nil
               dismissalDelayInSeconds:0
                           actionTitle:@"New Game!"
                                action:^(UIAlertAction *action) {
                                    [self newGame];
                                }];
    }
    
}

-(void)newGame{
    self.game = [[GameController alloc] initWithPlayer1Name:@"Khareem" player2Name:@"Julius"];
    self.answerLabel.text = @"";
    [self refresh];
}


@end
