#import <objc/runtime.h>

/**
 *  Replaces the selector's associated method implementation with the
 *  given implementation (or adds it, if there was no existing one).
 *
 *  @param originalSelector The selector entry in the dispatch table.
 *  @param swizzledSelector The implementation that will be associated with
 *                       the given selector.
 *  @param class The class whose dispatch table will be altered.
 *  @param isClassMethod Set to YES if the selector denotes a class
 *                       method, or NO if it is an instance method.
 */
void ReplaceMethod(SEL originalSelector,
                   SEL swizzledSelector,
                   Class class,
                   BOOL isClassMethod);
