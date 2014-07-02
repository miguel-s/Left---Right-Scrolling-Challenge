//
//  MSMyScene.m
//  Left & Right Scrolling Challenge
//
//  Created by Miguel Serrano on 02/07/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import "MSMyScene.h"
#import "MSLinkedSpriteNode.h"

@interface MSMyScene ()

@property (strong, nonatomic) NSMutableArray *tileArray;
@property (strong, nonatomic) MSLinkedSpriteNode *leftmostTile;
@property (strong, nonatomic) MSLinkedSpriteNode *rightmostTile;
@property (nonatomic, assign) CGFloat horizontalScrollingSpeed;

@end

static const CGFloat kMSMinFPS = 10.0 / 60.0;

@implementation MSMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
        
        self.tileArray = [[NSMutableArray alloc] initWithCapacity:3];
        
        for (int i = 0; i < 3; i++) {
            MSLinkedSpriteNode *node = [[MSLinkedSpriteNode alloc] initWithTexture:[atlas textureNamed:@"desert_BG"]];
            node.anchorPoint = CGPointZero;
            node.position = CGPointMake(node.size.width * i, node.size.height);
            
            if (i == 0) {
                self.leftmostTile = node;
            } else if (i == 2) {
                self.rightmostTile = node;
            }
            
            [self.tileArray addObject:node];
            [self addChild:node];
        }
        self.horizontalScrollingSpeed = -15.0;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        self.horizontalScrollingSpeed = -1.0 * self.horizontalScrollingSpeed;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    static NSTimeInterval lastCalltime;
    NSTimeInterval elapsedTime = currentTime - lastCalltime;
    lastCalltime = currentTime;
    if (elapsedTime > kMSMinFPS) {
        elapsedTime = kMSMinFPS;
    }
    
    for (MSLinkedSpriteNode *node in self.tileArray) {
        node.position = CGPointMake(node.position.x + (self.horizontalScrollingSpeed * elapsedTime), node.position.y);
        
        if (self.horizontalScrollingSpeed < 0) {
            if (node.position.x + node.frame.size.width < -self.frame.size.width * self.scene.anchorPoint.x) {
                node.position = CGPointMake(self.rightmostTile.position.x + self.rightmostTile.size.width, node.position.y);
                self.rightmostTile = node;
            }
        } else {
            if (node.position.x - node.frame.size.width > self.frame.size.width * self.scene.anchorPoint.x) {
                node.position = CGPointMake(self.leftmostTile.position.x - self.leftmostTile.size.width, node.position.y);
                self.leftmostTile = node;
            }
        }
    }
}

@end
