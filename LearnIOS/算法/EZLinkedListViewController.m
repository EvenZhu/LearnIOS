//
//  EZLinkedListViewController.m
//  LearnIOS
//
//  Created by Even on 2019/8/1.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZLinkedListViewController.h"

struct Node {
    int data;
    struct Node *next;
};

@interface EZLinkedListViewController ()

@property (nonatomic, assign) struct Node *head;

@end

@implementation EZLinkedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.head = [self constructList];
    [self printList:self.head];
    self.head = [self reverseList:self.head];
    [self printList:self.head];
    
    char ch[] = "Hello World";
    char_reverse (ch);
    
    // 有兴趣的可以验证
    printf ("%s\n",ch);
}

char * char_reverse (char *cha) {
    
    // 定义头部指针
    char *begin = cha;
    // 定义尾部指针
    char *end = cha + strlen(cha) -1;
    
    
    while (begin < end) {
        
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
    
    return cha;
}

/**
 翻转链表

 @param head 链表头部
 @return 翻转之后的链表
 */
- (struct Node *)reverseList:(struct Node *)head {
    // 定义遍历指针，初始化为头结点
    struct Node *p = head;
    
    // 反转后的链表头部
    struct Node *newH = NULL;
    
    // 遍历链表
    while (p != NULL) {
        
        // 记录下一个结点
        struct Node *temp = p->next;
        // 当前结点的next指向新链表头部
        p->next = newH;
        // 更改新链表头部为当前结点
        newH = p;
        // 移动p指针
        p = temp;
    }
    
    // 返回反转后的链表头结点
    return newH;
}

/**
 构建一个链表

 @return 链表
 */
- (struct Node*)constructList {
    // 头结点定义
    struct Node *head = NULL;
    // 记录当前尾结点
    struct Node *cur = NULL;
    
    for (int i = 1; i < 5; i++) {
        struct Node *node = malloc(sizeof(struct Node));
        node->data = i;
        node->next = nil;
        
        // 头结点为空，新结点即为头结点
        if (head == NULL) {
            head = node;
        }
        // 当前结点的next为新结点
        else{
            cur->next = node;
        }
        
        // 设置当前结点为新结点
        cur = node;
    }
    
    return head;
}

/**
 遍历打印链表中的元素

 @param head 链表头部
 */
- (void)printList:(struct Node *)head {
    struct Node *temp = head;
    printf("nodes is:\n");
    while (temp != NULL) {
        printf("%d\n", temp->data);
        temp = temp->next;
    }
}

@end
