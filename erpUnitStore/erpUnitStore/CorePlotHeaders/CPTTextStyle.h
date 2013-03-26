#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

///	@file

@class CPTColor;

/**
 *	@brief Enumeration of paragraph alignments.
 **/
typedef enum  _CPTTextAlignment {
	CPTTextAlignmentLeft,   ///< Left alignment
	CPTTextAlignmentCenter, ///< Center alignment
	CPTTextAlignmentRight   ///< Right alignment
}
CPTTextAlignment;

@interface CPTTextStyle : NSObject<NSCoding, NSCopying, NSMutableCopying> {
	@protected
	NSString *fontName;
	CGFloat fontSize;
	CPTColor *color;
	CPTTextAlignment textAlignment;
}

@property ( copy, nonatomic) NSString *fontName;
@property ( assign, nonatomic) CGFloat fontSize;
@property ( copy, nonatomic) CPTColor *color;
@property ( assign, nonatomic) CPTTextAlignment textAlignment;

/// @name Factory Methods
/// @{
+(id)textStyle;
///	@}

@end

/**	@category NSString(CPTTextStyleExtensions)
 *	@brief NSString extensions for drawing styled text.
 **/
@interface NSString(CPTTextStyleExtensions)

/// @name Measurement
/// @{
-(CGSize)sizeWithTextStyle:(CPTTextStyle *)style;
///	@}

/// @name Drawing
/// @{
-(void)drawInRect:(CGRect)rect withTextStyle:(CPTTextStyle *)style inContext:(CGContextRef)context;
///	@}

@end
