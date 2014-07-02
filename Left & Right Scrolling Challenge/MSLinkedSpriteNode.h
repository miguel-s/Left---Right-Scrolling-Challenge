//
//  MSLinkedSpriteNode.h
//  Left & Right Scrolling Challenge
//
//  Created by Miguel Serrano on 02/07/14.
//  Copyright (c) 2014 Miguel Serrano. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MSLinkedSpriteNode : SKSpriteNode

@property (strong, nonatomic) MSLinkedSpriteNode *leftNode;
@property (strong, nonatomic) MSLinkedSpriteNode *rightNode;

@end
