//
//  OpenCV.h
//  testing
//
//  Created by 橋口　巧 on 2018/11/02.
//  Copyright © 2018年 大家拓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCV : NSObject
{
@public
    UIImage *image;
    int rectPointX;
    int rectPointY;
    int rectPointWidth;
    int rectPointHeight;
}
- (id)init;
- (UIImage *)recognizeFace:(UIImage *)image;
- (int)getRectPointX;
- (int)getRectPointY;
- (int)getRectPointHeight;
- (int)getRectPointWidth;
//- (int *)pointList;
@end
