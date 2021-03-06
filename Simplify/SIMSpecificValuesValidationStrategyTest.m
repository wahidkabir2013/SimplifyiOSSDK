/* Copyright (c) 2013, Asynchrony Solutions, Inc.
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *    * Neither the name of Asynchrony Solutions, Inc. nor the
 *      names of its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *  DISCLAIMED. IN NO EVENT SHALL ASYNCHRONY SOLUTIONS, INC. BE LIABLE FOR ANY
 *  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SIMAbstractTestCase.h"
#import "SIMSpecificValuesValidationStrategy.h"

@interface SIMSpecificValuesValidationStrategyTest : SIMAbstractTestCase {
	NSArray *validValues;
	SIMSpecificValuesValidationStrategy *testObject;
}
@end

@implementation SIMSpecificValuesValidationStrategyTest

- (void)setUp {
	[super setUp];
	validValues = @[@"abc", @"123", @"a"];
	testObject = [[SIMSpecificValuesValidationStrategy alloc] initWithValidValues:validValues];
}

- (void)tearDown {
	[super tearDown];
}

- (void)assertInput:(NSString *)input hasText:(NSString *)text andInputState:(SIMTextInputState)inputState {
	SIMTextFieldState *result = [testObject stateForInput:input];
	GHAssertEqualStrings(result.text, text, nil);
	GHAssertEquals(result.inputState, inputState, nil);
}

- (void)testStateForInput_EmptyStringIsNormalInputState {
	[self assertInput:@"" hasText:@"" andInputState:SIMTextInputStateNormal];
}

- (void)testStateForInput_OnlyAllowsSpecificValues {
	for (NSString *value in validValues) {
		[self assertInput:value hasText:value andInputState:SIMTextInputStateGood];
	}

	[self assertInput:@"23r4g" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"b" hasText:@"" andInputState:SIMTextInputStateNormal];
	[self assertInput:@"@!#Rubgijklfd" hasText:@"" andInputState:SIMTextInputStateNormal];
}

@end
