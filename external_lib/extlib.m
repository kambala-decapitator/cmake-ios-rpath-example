#import <StoreKit/StoreKit.h>

BOOL isStoreAvailable() {
	return [SKPaymentQueue canMakePayments];
}
