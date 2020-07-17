//
//  UIImageView+PPImageView.m
//  MJRefresh
//
//  Created by 郝鹏飞 on 2020/7/17.
//

#import "UIImageView+PPImageView.h"
#import <SDWebImage/SDWebImage.h>
@implementation UIImageView (PPImageView)

- (void)pp_setImageWithUrl:(NSString *)url placeholderImage:(UIImage *)image {
    
    NSURL *u = [NSURL URLWithString:url];
    [self sd_setImageWithURL:u placeholderImage:image];
}

@end
