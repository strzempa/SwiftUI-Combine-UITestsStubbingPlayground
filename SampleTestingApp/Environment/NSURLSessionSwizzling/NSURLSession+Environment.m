#ifdef DEBUG

#import <Foundation/Foundation.h>
#import "SampleTestingApp-Swift.h"
#import "MethodSwizzling.h"

@interface NSURLSession (Environment)
@end

@implementation NSURLSession (Environment)

+ (void)load {
    if ([[[[NSProcessInfo processInfo] environment] allKeys] containsObject:NSProcessInfo.environmentKey]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class class = [self class];

            SEL originalSelector = @selector(dataTaskWithRequest:completionHandler:);
            SEL swizzledSelector = @selector(swizzled_dataTaskWithRequest:completionHandler:);

            ReplaceMethod(originalSelector, swizzledSelector, class, NO);
        });
    }
}

- (NSURLSessionDataTask *)swizzled_dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
    NSURLRequest *newRequest = [[EnvironmentApplier new] transformWithRequest:request];
    return [self swizzled_dataTaskWithRequest:newRequest completionHandler: completionHandler];
}

@end

#endif
