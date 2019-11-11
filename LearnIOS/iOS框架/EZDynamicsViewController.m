//
//  EZDynamicsViewController.m
//  LearnIOS
//
//  Created by Even on 2019/9/18.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZDynamicsViewController.h"

@interface EZDynamicsViewController () <UITableViewDelegate, UITableViewDataSource, UICollisionBehaviorDelegate> {
    UITableView *_tableView;
}

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;
@property (nonatomic, strong) UIImageView *frogView;
@property (nonatomic, strong) UIImageView *drogonImageView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation EZDynamicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    self.frogView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 100, 50, 50)];
    self.frogView.image = [UIImage imageNamed:@"dog"];
    self.frogView.userInteractionEnabled = YES;
    [self.view addSubview:self.frogView];
    
    self.drogonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 100, 50, 50)];
    self.drogonImageView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.drogonImageView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @[@"重力效果",
                            @"碰撞效果",
                            @"附着效果",
                            @"弹跳效果",
                            @"瞬间移位",
                            @"推力效果",
                            @"元素属性"][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.frogView.frame = CGRectMake(150, 100, 50, 50);
    self.drogonImageView.frame = CGRectMake(250, 100, 50, 50);
    [self.animator removeAllBehaviors];
    switch (indexPath.row) {
        case 0:
            [self addGravityBehavior:NO];
            break;
        case 1:
            [self addCollisionBehavior];
            [self addGravityBehavior:NO];
            break;
        case 2:
            [self addCollisionBehavior];
            [self addAttachmentBehavior];
            [self addGestureRcognizer];
            break;
        case 3:
            [self addCollisionBehavior];
            [self addGravityBehavior:YES];
            [self addAttachmentBehavior];
            break;
        case 4:
            [self addTap];
            break;
        case 5:
            [self addCollisionBehavior];
            [self addPushBehavior];
            break;
        case 6:
            [self addCollisionBehavior];
            [self addGravityBehavior:NO];
            [self addItemBehavior];
            break;
            
        default:
            break;
    }
}

///  为frogView添加重力效果
- (void)addGravityBehavior:(BOOL)onlyOne {
    if (onlyOne) {
        self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.drogonImageView]];
    }else {
        self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.frogView, self.drogonImageView]];
    }
    [self.gravityBehavior setGravityDirection:CGVectorMake(0, 1)];
    [self.animator addBehavior:self.gravityBehavior];
}

///  为frogView添加碰撞效果
- (void)addCollisionBehavior {
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.frogView, self.drogonImageView]];
    [collisionBehavior setCollisionMode:UICollisionBehaviorModeBoundaries];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    [self.animator addBehavior:collisionBehavior];
}

///  为frogView添加附着效果
- (void)addAttachmentBehavior {
    CGPoint frogCenter = self.frogView.center;
    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.drogonImageView attachedToAnchor:frogCenter];
    
    
    [self.attachmentBehavior setFrequency:0];
    [self.attachmentBehavior setDamping:0];
    [self.attachmentBehavior setLength:200.0f];
    
    [self.animator addBehavior:self.attachmentBehavior];
}

/// 为frogView添加弹跳效果
- (void)addDuang {
    [self.attachmentBehavior setFrequency:1.0f];
    [self.attachmentBehavior setDamping:0.1f];
    [self.attachmentBehavior setLength:100.0f];
}

/// 为frogView添加瞬间移位效果
- (void)addTap {
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:self.tap];
}

/// 为frogView添加推力效果
- (void)addPushBehavior {
    _tableView.userInteractionEnabled = NO;
    
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.frogView] mode:UIPushBehaviorModeContinuous];
    self.pushBehavior.angle = 0.0f;
    self.pushBehavior.magnitude = 0.0f;
    
    [self.animator addBehavior:self.pushBehavior];
}

/// 为frogView设置元素属性
- (void)addItemBehavior {
    UIDynamicItemBehavior *propertiesBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.frogView]];
    propertiesBehavior.elasticity =0.9f;       // 设置弹力
    propertiesBehavior.allowsRotation = NO;     // 是否根据力度旋转
    propertiesBehavior.angularResistance = 0.0f;// 阻尼值，该值越大，旋转速度的减速越快
    propertiesBehavior.density = 3.0f;          // 密度，影响重力和碰撞效果的反应
    propertiesBehavior.friction = 0.5f;         // 两个元素相互滑动时的线性阻力，0.0表示无摩擦力，1.0表示摩擦力最大
    propertiesBehavior.resistance = 0.5f;       // 开放空间中遇到的阻力
    
    [self.animator addBehavior:propertiesBehavior];
}

/// 为self.view添加手势
- (void)addGestureRcognizer {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint p = [pan locationInView:self.view];
    
    self.frogView.center = p;
    [self.attachmentBehavior setAnchorPoint:p];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.frogView snapToPoint:[tap locationInView:self.view]];
    snapBehavior.damping = 0.75f;
    [self.animator removeAllBehaviors];
    [self.animator addBehavior:snapBehavior];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self.view];
    
    CGPoint orign = self.frogView.frame.origin;
    CGFloat distance = sqrtf(powf(p.x - orign.x, 2.0)) + powf(p.y - orign.y, 2.0);
    CGFloat angle = atan2(p.y - orign.y, p.x - orign.x);
    distance = MIN(distance, 100.0f);
    
    [self.pushBehavior setMagnitude:distance/100.0];
    [self.pushBehavior setAngle:angle];
    [self.pushBehavior setActive:YES];
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    
    return _animator;
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p {
    NSLog(@"beganContactForItem1 = %@, item2 = %@, p = (%f, %f)", item1, item2, p.x, p.y);
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 {
    NSLog(@"endedContactForItem1 = %@, item2 = %@", item1, item2);
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSLog(@"beganContactForItem = %@, p = (%f, %f)", item, p.x, p.y);
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier {
    NSLog(@"endedContactForItem = %@", item);
}

@end
