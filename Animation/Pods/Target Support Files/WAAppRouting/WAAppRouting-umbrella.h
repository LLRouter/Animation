#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSMutableDictionary+WAAppRoutingParameters.h"
#import "NSString+WAAdditions.h"
#import "NSURL+WAAdditions.h"
#import "UINavigationController+WAAdditions.h"
#import "UITabBarController+WAAppRoutingContainerPresentationProtocol.h"
#import "UIViewController+WAAppLinkParameters.h"
#import "WAAppLink.h"
#import "WAAppLinkParameters.h"
#import "WAAppMacros.h"
#import "WAAppRouteEntity.h"
#import "WAAppRouteHandler.h"
#import "WAAppRouteHandlerProtocol.h"
#import "WAAppRouteMatcher.h"
#import "WAAppRouter+WADefaultRouter.h"
#import "WAAppRouter.h"
#import "WAAppRouteRegistrar.h"
#import "WAAppRouterMatcherProtocol.h"
#import "WAAppRouterParametersProtocol.h"
#import "WAAppRouterTargetControllerProtocol.h"
#import "WAAppRouting.h"
#import "WAAppRoutingContainerPresentationProtocol.h"
#import "WARoutePattern.h"

FOUNDATION_EXPORT double WAAppRoutingVersionNumber;
FOUNDATION_EXPORT const unsigned char WAAppRoutingVersionString[];

