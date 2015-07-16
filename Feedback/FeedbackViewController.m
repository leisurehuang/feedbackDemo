//
//  FeedbackViewController.m
//  Feedback
//
//  Created by Lei Huang on 7/16/15.
//  Copyright (c) 2015 Lei Huang. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property(weak, nonatomic) IBOutlet UITextField *kindTextField;
@property(strong, nonatomic) UIPickerView *kindPicker;
@property(strong, nonatomic) NSArray *kinds;
@property(weak, nonatomic) IBOutlet UIStepper *npsStepper;
@property(weak, nonatomic) IBOutlet UILabel *npsLabel;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendFeedback)];
    self.navigationItem.rightBarButtonItem = sendButton;

    self.kindTextField.text = self.kinds[0];
    _kindPicker = [[UIPickerView alloc] init];
    _kindPicker.dataSource = self;
    _kindPicker.delegate = self;
    self.kindTextField.inputView = _kindPicker;

    UIToolbar *kindToolBar = [[UIToolbar alloc] init];
    kindToolBar.barTintColor = [UIColor grayColor];
    kindToolBar.frame = CGRectMake(0, 0, 320, 38);
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    [doneBtn setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    kindToolBar.items = @[spaceBtn, doneBtn];
    self.kindTextField.inputAccessoryView = kindToolBar;

    self.npsStepper.minimumValue = 0;
    self.npsStepper.maximumValue = 10;
    self.npsStepper.value = 5;
    [self.npsStepper addTarget:self action:@selector(stepValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)stepValueChanged:(id)sender {
    UIStepper *stepper = (UIStepper *) sender;
    self.npsLabel.text = [NSString stringWithFormat:@"NPS: %.0f", stepper.value];
}

- (void)sendFeedback {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)doneClick {
    [self.view endEditing:YES];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.kinds.count;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.kinds[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.kindTextField.text = self.kinds[row];
}

- (NSArray *)kinds {
    if (_kinds == nil) {
        _kinds = @[@"Suggestions", @"Crash", @"Other"];
    }
    return _kinds;
}


@end
