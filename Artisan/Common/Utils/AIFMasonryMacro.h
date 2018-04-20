//
//  AIFMasonryMacro.h
//  Pods
//
//  Created by Erick on 2017/12/13.
//

#ifndef AIFMasonryMacro_h
#define AIFMasonryMacro_h

#import <Masonry/Masonry.h>

#define make_left_equalTo(...) _make_left_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_right_equalTo(...) _make_right_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_left_greaterThanOrEqualTo(...) _make_left_greaterThanOrEqualTo(make, AIFBoxValue(__VA_ARGS__))
#define make_right_lessThanOrEqualTo(...) _make_right_lessThanOrEqualTo(make, AIFBoxValue(__VA_ARGS__))
#define make_top_equalTo(...) _make_top_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_bottom_equalTo(...) _make_bottom_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_top_greaterThanOrEqualTo(...) _make_top_greaterThanOrEqualTo(make, AIFBoxValue(__VA_ARGS__))
#define make_bottom_lessThanOrEqualTo(...) _make_bottom_lessThanOrEqualTo(make, AIFBoxValue(__VA_ARGS__))
#define make_center_equalTo(...) _make_center_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_centerX_equalTo(...) _make_centerX_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_centerY_equalTo(...) _make_centerY_equalTo(make, AIFBoxValue(__VA_ARGS__))

#define make_width_equalTo(...) _make_width_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_width_lessThanOrEqualTo(...) _make_width_lessThanOrEqualTo(make, AIFBoxValue(__VA_ARGS__))
#define make_width_greaterThanOrEqualTo(...) _make_width_greaterThanOrEqualTo(make, AIFBoxValue(__VA_ARGS__))
#define make_height_equalTo(...) _make_height_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_height_lessThanOrEqualTo(...) _make_height_lessThanOrEqualTo(make, AIFBoxValue(__VA_ARGS__))
#define make_height_greaterThanOrEqualTo(...) _make_height_greaterThanOrEqualTo(make, AIFBoxValue(__VA_ARGS__))

#define make_size_equalTo(...) _make_size_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_edges_equalTo(...) _make_edges_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_left_right_equalTo(...) _make_left_right_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_top_bottom_equalTo(...) _make_top_bottom_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_leading_equalTo(...) _make_leading_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_trailing_equalTo(...) _make_trailing_equalTo(make, AIFBoxValue(__VA_ARGS__))
#define make_baseline_equalTo(...) _make_baseline_equalTo(make, AIFBoxValue(__VA_ARGS__))

FOUNDATION_EXPORT MASConstraint *_make_left_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_right_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_left_greaterThanOrEqualTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_right_lessThanOrEqualTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_top_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_bottom_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_top_greaterThanOrEqualTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_bottom_lessThanOrEqualTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_center_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_centerX_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_centerY_equalTo(MASConstraintMaker *make, id attribute);

FOUNDATION_EXPORT MASConstraint *_make_width_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_width_lessThanOrEqualTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_width_greaterThanOrEqualTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_height_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_height_lessThanOrEqualTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_height_greaterThanOrEqualTo(MASConstraintMaker *make, id attribute);

FOUNDATION_EXPORT MASConstraint *_make_size_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_edges_equalTo(MASConstraintMaker *make, id attribute);

FOUNDATION_EXPORT MASConstraint *_make_left_right_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_top_bottom_equalTo(MASConstraintMaker *make, id attribute);

FOUNDATION_EXPORT MASConstraint *_make_leading_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_trailing_equalTo(MASConstraintMaker *make, id attribute);
FOUNDATION_EXPORT MASConstraint *_make_baseline_equalTo(MASConstraintMaker *make, id attribute);

FOUNDATION_EXPORT id _AIFBoxValue(const char *type, ...);
#define AIFBoxValue(value) _AIFBoxValue(@encode(__typeof__((value))), (value))

#endif /* AIFMasonryMacro_h */

