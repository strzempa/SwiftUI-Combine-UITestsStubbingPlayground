#import "MethodSwizzling.h"

void ReplaceMethod(SEL originalSelector,
                   SEL swizzledSelector,
                   Class class,
                   BOOL isClassMethod) {
    Method originalMethod;
    Method swizzledMethod;
    if (isClassMethod) {
        originalMethod = class_getClassMethod(class, originalSelector);
        swizzledMethod = class_getClassMethod(class, swizzledSelector);
    } else {
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    }

    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
