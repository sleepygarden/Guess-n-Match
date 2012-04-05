//
//  basicsViewController.h
//  Memory
//
//  Created by Michael Cornell on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

UIButton *cardArray[16];
@interface basicsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *winnerDisp;
@property (retain) NSArray *imageArray;
@property BOOL cardCompare;
@property int tryCount;
@property int winCheck;
@property (retain) UIButton *card1;
@property (retain) UIButton *card2;
-(void)newGame;
-(void)compareCards;
-(void)delayReset;
@end
