//
//  MenuLayer.m
//  DragonFlight
//
//  Created by Jehyeok on 11/28/13.
//  Copyright (c) 2013 com.appcoda. All rights reserved.
//

#import "MenuLayer.h"

@implementation MenuLayer
+(CCScene *)scene {
    CCScene *scene = [CCScene node];
    MenuLayer *layer = [MenuLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init {
    self = [super init];
    if (self) {
        // 다이렉터에서 화면 크기 알아옴
        CGSize size = [[CCDirector sharedDirector] winSize];
        // 제목으로 만들 레이블에 시스템 폰트 사용
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Dragon Flight" fontName:@"HelveticaNeue" fontSize:36];
        // 레이블 위치 지정
        label.position = CGPointMake( size.width/2, size.height/2 + 100 );
        // 레이블 추가
        [self addChild:label];
        
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Made By Jeheyok" fontName:@"HelveticaNeue" fontSize:30];
        label2.position = CGPointMake( size.width/2, size.height/2 + 60 );
        [self addChild:label2];
        
        // 메뉴 아이템 폰트 변경
        [CCMenuItemFont setFontName:@"AppleSDGothicNeo-Medium"];
        // 메뉴 아이템 블럭
        CCMenuItem *startItem = [CCMenuItemFont itemWithString:@"Start" block:^(id sender) {
            // Start 메뉴 버튼 눌렀을 경우, GameScene을 화면 전환과 함께 호출
            [[CCDirector sharedDirector] replaceScene:[GameScene node]];
        }];
        
        // 메뉴 버튼을 메뉴에 추가
        CCMenu *menu = [CCMenu menuWithItems:startItem, nil];
        // 세로 정렬로 각 메뉴의 사잇값으로 20을 줌
        [menu alignItemsVerticallyWithPadding:20];
        // 메뉴 위치 지정
        [menu setPosition:CGPointMake( size.width/2, size.height/2 - 50)];
        // 메뉴를 자식으로 추가
        [self addChild:menu];
    }
    return self;
}
@end
