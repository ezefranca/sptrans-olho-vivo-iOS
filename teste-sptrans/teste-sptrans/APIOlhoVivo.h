//
//  ViewController.h
//  teste-sptrans
//
//  Created by Ezequiel Franca dos Santos on 12/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIOlhoVivo : UIViewController <NSURLConnectionDelegate>
{
    NSMutableArray *catalogo;
    NSMutableArray *track;
    NSData *jsonDados;
   
}

@property NSString *token;

@end
