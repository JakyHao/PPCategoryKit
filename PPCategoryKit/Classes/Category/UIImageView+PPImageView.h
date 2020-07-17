//
//  UIImageView+PPImageView.h
//  MJRefresh
//
//  Created by 郝鹏飞 on 2020/7/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (PPImageView)

- (void)pp_setImageWithUrl:(NSString *)url placeholderImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
