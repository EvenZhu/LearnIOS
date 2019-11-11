//
//  EZAddressBookViewController.m
//  LearnIOS
//
//  Created by Even on 2019/10/14.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZAddressBookViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface EZAddressBookViewController ()

@property (nonatomic, strong) NSArray *addressBookEntryArray;
@property (nonatomic, strong) CNContactStore *contactStore;

@end

@implementation EZAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self accessContacts];
}


/// 获取通讯录信息
- (void)accessContacts {
    // 请求权限
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    // 检索联系人
    if (status == CNAuthorizationStatusAuthorized || status == CNAuthorizationStatusRestricted) {
        [self requestContactsInfo];
    } else if (status == CNAuthorizationStatusDenied) {
        [[[UIAlertView alloc] initWithTitle:@"请获取访问相册权限!" message:@"请获取访问相册权限!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else if (status == CNAuthorizationStatusNotDetermined) {
        [[[CNContactStore alloc] init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted && error == nil) {
                [self requestContactsInfo];
            } else {
                // 访问通讯录权限被拒绝
            }
        }];
    }
}

- (void)requestContactsInfo {
    CNContactStore *store = [[CNContactStore alloc] init];
    // 检索条件，检索所有名字中有zhang的联系人
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:@"张"];
    // 检索条件，检索通讯录中所有的联系人信息
    predicate = [CNContact predicateForContactsInContainerWithIdentifier:[store defaultContainerIdentifier]];
    // 提取数据
    NSError *error = nil;
    // keysToFetch是设置提取联系人的哪些数据。
    NSArray<CNContact *> *contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactFamilyNameKey,CNContactGivenNameKey,CNContactOrganizationNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey,CNContactPostalAddressesKey] error:&error];
    for (CNContact *c in contacts) {
        NSLog(@"%@", c);
    }

    // 我们也可以通过keysToFetch获取联系人，并对联系人进行遍历。
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactGivenNameKey,CNContactPhoneNumbersKey]];
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSLog(@"%@", contact);
    }];
}

- (CNContactStore *)contactStore {
    if (_contactStore) {
        _contactStore = [[CNContactStore alloc] init];
    }
    
    return _contactStore;
}

@end
