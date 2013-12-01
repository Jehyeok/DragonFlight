//
//  HUDLayer.h
//  DragonFlight
//
//  Created by Jehyeok on 11/29/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "CCLayer.h"
#import "CCLabelTTF.h"

@interface HUDLayer : CCLayer {
    CCLabelTTF *scoreLabel;
}

-(void)setScoreText:(int)score;
@end
