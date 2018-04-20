//
//  AIFMasonryMacro.m
//  AFNetworking
//
//  Created by Erick on 2017/12/13.
//
#import "AIFMasonryMacro.h"

MASConstraint *_make_left_equalTo(MASConstraintMaker *make, id attribute) {
    return make.left.equalTo(attribute);
}

MASConstraint *_make_right_equalTo(MASConstraintMaker *make, id attribute) {
    return make.right.equalTo(attribute);
}

MASConstraint *_make_left_greaterThanOrEqualTo(MASConstraintMaker *make, id attribute) {
    return make.left.greaterThanOrEqualTo(attribute);
}

MASConstraint *_make_right_lessThanOrEqualTo(MASConstraintMaker *make, id attribute) {
    return make.right.lessThanOrEqualTo(attribute);
}

MASConstraint *_make_top_equalTo(MASConstraintMaker *make, id attribute) {
    return make.top.equalTo(attribute);
}

MASConstraint *_make_bottom_equalTo(MASConstraintMaker *make, id attribute) {
    return make.bottom.equalTo(attribute);
}

MASConstraint *_make_top_greaterThanOrEqualTo(MASConstraintMaker *make, id attribute) {
    return make.top.greaterThanOrEqualTo(attribute);
}

MASConstraint *_make_bottom_lessThanOrEqualTo(MASConstraintMaker *make, id attribute) {
    return make.bottom.lessThanOrEqualTo(attribute);
}

MASConstraint *_make_center_equalTo(MASConstraintMaker *make, id attribute) {
    return make.center.equalTo(attribute);
}

MASConstraint *_make_centerX_equalTo(MASConstraintMaker *make, id attribute) {
    return make.centerX.equalTo(attribute);
}

MASConstraint *_make_centerY_equalTo(MASConstraintMaker *make, id attribute) {
    return make.centerY.equalTo(attribute);
}

MASConstraint *_make_width_equalTo(MASConstraintMaker *make, id attribute) {
    return make.width.equalTo(attribute);
}

MASConstraint *_make_width_lessThanOrEqualTo(MASConstraintMaker *make, id attribute) {
    return make.width.lessThanOrEqualTo(attribute);
}

MASConstraint *_make_width_greaterThanOrEqualTo(MASConstraintMaker *make, id attribute) {
    return make.width.greaterThanOrEqualTo(attribute);
}

MASConstraint *_make_height_equalTo(MASConstraintMaker *make, id attribute) {
    return make.height.equalTo(attribute);
}

MASConstraint *_make_height_lessThanOrEqualTo(MASConstraintMaker *make, id attribute) {
    return make.height.lessThanOrEqualTo(attribute);
}

MASConstraint *_make_height_greaterThanOrEqualTo(MASConstraintMaker *make, id attribute) {
    return make.height.greaterThanOrEqualTo(attribute);
}

MASConstraint *_make_size_equalTo(MASConstraintMaker *make, id attribute) {
    return make.size.equalTo(attribute);
}

MASConstraint *_make_edges_equalTo(MASConstraintMaker *make, id attribute) {
    return make.edges.equalTo(attribute);
}

MASConstraint *_make_left_right_equalTo(MASConstraintMaker *make, id attribute) {
    return make.left.right.equalTo(attribute);
}

MASConstraint *_make_top_bottom_equalTo(MASConstraintMaker *make, id attribute) {
    return make.top.bottom.equalTo(attribute);
}

MASConstraint *_make_leading_equalTo(MASConstraintMaker *make, id attribute) {
    return make.leading.equalTo(attribute);
}

MASConstraint *_make_trailing_equalTo(MASConstraintMaker *make, id attribute) {
    return make.trailing.equalTo(attribute);
}

MASConstraint *_make_baseline_equalTo(MASConstraintMaker *make, id attribute) {
    return make.baseline.equalTo(attribute);
}

id _AIFBoxValue(const char *type, ...) {
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(v, CGPoint);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(v, CGSize);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(MASEdgeInsets)) == 0) {
        MASEdgeInsets actual = (MASEdgeInsets)va_arg(v, MASEdgeInsets);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}

