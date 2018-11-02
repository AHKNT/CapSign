//
//  OpenCV.m
//  testing
//
//  Created by 橋口　巧 on 2018/11/02.
//  Copyright © 2018年 大家拓. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "OpenCV.h"
#include <vector>

using namespace std;

@implementation OpenCV

cv::CascadeClassifier cascade;


bool checkFileExistence(const std::string& str)
{
    std::ifstream ifs(str);
    return ifs.is_open();
}


- (id)init {
    self = [super init];
    
    // 分類器の読み込み
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"haarcascade_frontalface_alt" ofType:@"xml"];
    
    std::string cascadeName = (char *)[path UTF8String];
    
    if(!cascade.load(cascadeName)) {
        return nil;
    }
    return self;
}


- (UIImage *)recognizeFace:(UIImage *)image {
    // UIImage -> cv::Mat変換
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat mat(rows, cols, CV_8UC4);
    
    CGContextRef contextRef = CGBitmapContextCreate(mat.data,
                                                    cols,
                                                    rows,
                                                    8,
                                                    mat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    // 顔検出
    std::vector<cv::Rect> faces;
    cascade.detectMultiScale(mat, faces,1.1, 2,CV_HAAR_SCALE_IMAGE,cv::Size(40, 40));
    
    // 顔の位置に四角を描く
    std::vector<cv::Rect>::const_iterator r = faces.begin();
    for(; r != faces.end(); ++r) {
        //顔を切り取る
        cv::Mat cut_image(mat, cv::Rect(20,20,10,10));
        cv::rectangle (mat, cv::Point(r->x, r->y), cv::Point(r->x + r->width , r->y + r->height),cv::Scalar(0,255,0), 4, 5);
        rectPointX = cv::Point(r->x, r->y).x;
        rectPointY = cv::Point(r->x, r->y).y;
        rectPointWidth = cv::Point(r->x + r->width).x;
        rectPointHeight = cv::Point(r->y + r->height).x;
        //        for(int i = 0; i < 4; i++ ){
        //            printf("%d",rectPoint[i]);
        //            printf("\n");
        //        }
        //        printf("x座標：");
        //        printf("%d",cv::Point(r->x, r->y).x);
        //        printf("\n");
    }
    
    // cv::Mat -> UIImage変換
    image= MatToUIImage(mat);
    //    printf("%d",self->rectPointX);
    //    printf("%d",self->rectPointY);
    //    printf("%d",self->rectPointHeight);
    //    printf("%d",self->rectPointWidth);
    
    return image;
}

- (int) getRectPointX{
    return rectPointX;
}
- (int) getRectPointY{
    return rectPointY;
}
- (int) getRectPointHeight{
    return rectPointHeight;
}
- (int) getRectPointWidth{
    return rectPointWidth;
}

@end

