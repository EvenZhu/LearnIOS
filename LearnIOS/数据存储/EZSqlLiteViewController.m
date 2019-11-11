//
//  EZSqlLiteViewController.m
//  LearnIOS
//
//  Created by Even on 2019/7/12.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZSqlLiteViewController.h"
#import <objc/runtime.h>
#import <sqlite3.h>

@interface EZSqlLiteViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    NSArray *_datas;
    sqlite3 *_db;
    
    UIButton *select;
}

@end

@implementation EZSqlLiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    sqlite3_close(_db);
}

- (void)setupView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)openAction:(UIButton *)sender {
    //1.打开数据库(如果指定的数据库文件存在就直接打开，不存在就创建一个新的数据文件)
    //参数1:需要打开的数据库文件路径(iOS中一般将数据库文件放到沙盒目录下的Documents下)
    NSString *nsPath = [NSString stringWithFormat:@"%@/Documents/Person.db", NSHomeDirectory()];
    const char *path = [nsPath UTF8String];
    
    //参数2:指向数据库变量的指针的地址
    //返回值:数据库操作结果
    int ret = sqlite3_open(path, &_db);
    
    //判断执行结果
    if (ret == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
}

- (void)createAction:(UIButton *)sender {
    //1.设计创建表的sql语句
    const char * sql = "CREATE TABLE IF NOT EXISTS t_Student(id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, score real DEFAULT 0, sex text DEFAULT '不明');";
    
    //2.执行sql语句
    //通过sqlite3_exec方法可以执行创建表、数据的插入、数据的删除以及数据的更新操作；但是数据查询的sql语句不能使用这个方法来执行
    //参数1:数据库指针(需要操作的数据库)
    //参数2:需要执行的sql语句
    //返回值:执行结果
    int ret = sqlite3_exec(_db, sql, NULL, NULL, NULL);
    
    //3.判断执行结果
    if (ret == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
}

- (void)insertAction:(UIButton *)sender {
    //1.创建插入数据的sql语句
    //===========插入单条数据=========
    const char * sql = "INSERT INTO t_Student (name,score,sex) VALUES ('小明',65,'男');";
    
    //==========同时插入多条数据=======
    NSMutableString * mstr = [NSMutableString string];
    for (int i = 0; i < 50; i++) {
        NSString * name = [NSString stringWithFormat:@"name%d", i];
        CGFloat score = arc4random() % 101 * 1.0;
        NSString * sex = arc4random() % 2 == 0 ? @"男" : @"女";
        NSString * tsql = [NSString stringWithFormat:@"INSERT INTO t_Student (name,score,sex) VALUES ('%@',%f,'%@');", name, score, sex];
        [mstr appendString:tsql];
    }
    //将OC字符串转换成C语言的字符串
    sql = mstr.UTF8String;
    //2.执行sql语句
    int ret = sqlite3_exec(_db, sql, NULL, NULL, NULL);
    //3.判断执行结果
    if (ret==SQLITE_OK) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
    [self selectAction:nil];
}

- (void)selectAction:(UIButton *)sender {
    //1.创建数据查询的sql语句
    const char * sql = "SELECT name,score FROM t_Student;";
    
    //2.执行sql语句
    //参数1:数据库
    //参数2:sql语句
    //参数3:sql语句的长度(-1自动计算)
    //参数4:结果集(用来收集查询结果)
    sqlite3_stmt * stmt;
    //参数5:NULL
    //返回值:执行结果
    int ret = sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL);
    if (ret == SQLITE_OK) {
        NSLog(@"查询成功");
        NSMutableArray *temp = [NSMutableArray new];
        
        //遍历结果集拿到查询到的数据
        //sqlite3_step获取结果集中的数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //参数1:结果集
            //参数2:列数
            const unsigned char * name = sqlite3_column_text(stmt, 0);
            double score = sqlite3_column_double(stmt, 1);
//            NSLog(@"%s %.2lf", name, score);
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:name], @"name", [NSString stringWithFormat:@"%lf", score], @"score", nil];
            [temp addObject:dict];
        }
        _datas = temp;
        [select setTitle:[NSString stringWithFormat:@"查询(%zu条数据)", _datas.count] forState:UIControlStateNormal];
    }else{
        NSLog(@"查询失败");
        _datas = nil;
    }
    sqlite3_finalize(stmt);
    [_tableView reloadData];
}

- (void)updateAction:(UIButton *)sender {
    //1.创建插入数据的sql语句
    //===========插入单条数据=========
    const char * sql = "UPDATE t_Student SET score = 60 where name in (select name from t_Student order by name limit 0,3);";
    
    //2.执行sql语句
    int ret = sqlite3_exec(_db, sql, NULL, NULL, NULL);
    //3.判断执行结果
    if (ret==SQLITE_OK) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败");
    }
    [self selectAction:nil];
}

- (void)deleteTableAction:(UIButton *)sender {
    //1.创建插入数据的sql语句
    //===========插入单条数据=========
    const char * sql = "DROP TABLE if EXISTS t_Student;";
    
    //2.执行sql语句
    int ret = sqlite3_exec(_db, sql, NULL, NULL, NULL);
    //3.判断执行结果
    if (ret==SQLITE_OK) {
        NSLog(@"删除表格成功");
    }else{
        NSLog(@"删除表格失败");
    }
    [self selectAction:nil];
}

- (void)deleteDataAction:(UIButton *)sender {
    //1.创建插入数据的sql语句
    //===========插入单条数据=========
    const char * sql = "DELETE FROM t_Student where name in (select name from t_Student order by name limit 0,1);";
    
    //2.执行sql语句
    int ret = sqlite3_exec(_db, sql, NULL, NULL, NULL);
    //3.判断执行结果
    if (ret==SQLITE_OK) {
        NSLog(@"删除第一条数据成功");
    }else{
        NSLog(@"删除第一条数据失败");
    }
    [self selectAction:nil];
}

- (void)conditionSelectAction:(UIButton *)sender {
    const char * sql = "SELECT name,score FROM t_Student WHERE name in (select name from t_Student order by name limit 0,5);";
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL);
    if (ret==SQLITE_OK) {
        NSLog(@"查询成功");
        NSMutableArray *temp = [NSMutableArray new];
        
        //遍历结果集拿到查询到的数据
        //sqlite3_step获取结果集中的数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //参数1:结果集
            //参数2:列数
            const unsigned char * name = sqlite3_column_text(stmt, 0);
            double score = sqlite3_column_double(stmt, 1);
            //            NSLog(@"%s %.2lf", name, score);
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:name], @"name", [NSString stringWithFormat:@"%lf", score], @"score", nil];
            [temp addObject:dict];
        }
        _datas = temp;
    }else{
        NSLog(@"查询失败");
        _datas = nil;
    }
    sqlite3_finalize(stmt);
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"sqlCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _datas[indexPath.row][@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"score:%.1f", [_datas[indexPath.row][@"score"] floatValue]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    
    CGFloat startX = 10;
    CGFloat height = 30;
    
    UIButton *open = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [open setTitle:@"打开数据库" forState:UIControlStateNormal];
    [open addTarget:self action:NSSelectorFromString(@"openAction:") forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:open];
    
    UIButton *create = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [create setTitle:@"创建表格" forState:UIControlStateNormal];
    [create addTarget:self action:NSSelectorFromString(@"createAction:") forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:create];
    
    UIButton *insert = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insert setTitle:@"插入数据" forState:UIControlStateNormal];
    [insert addTarget:self action:NSSelectorFromString(@"insertAction:") forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:insert];
    
    select = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    select.tag = 100;
    [select setTitle:@"查询" forState:UIControlStateNormal];
    [select addTarget:self action:NSSelectorFromString(@"selectAction:") forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:select];
    
    UIButton *update = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [update setTitle:@"更新分数" forState:UIControlStateNormal];
    [update addTarget:self action:NSSelectorFromString(@"updateAction:") forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:update];
    
    UIButton *deleteTable = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleteTable setTitle:@"删除表格" forState:UIControlStateNormal];
    [deleteTable addTarget:self action:NSSelectorFromString(@"deleteTableAction:") forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:deleteTable];
    
    UIButton *deleteData = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleteData setTitle:@"删除前3" forState:UIControlStateNormal];
    [deleteData addTarget:self action:NSSelectorFromString(@"deleteDataAction:") forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:deleteData];
    
    UIButton *conditionSelect = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [conditionSelect setTitle:@"查询前5" forState:UIControlStateNormal];
    [conditionSelect addTarget:self action:NSSelectorFromString(@"conditionSelectAction:") forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:conditionSelect];
    
    open.sd_layout
    .widthRatioToView(headerView, 0.25)
    .heightIs(height)
    .leftEqualToView(headerView)
    .topSpaceToView(headerView, startX);
    
    create.sd_layout
    .widthRatioToView(open, 1)
    .heightIs(height)
    .leftSpaceToView(open, 0)
    .topSpaceToView(headerView, startX);
    
    insert.sd_layout
    .widthRatioToView(open, 1)
    .heightIs(height)
    .leftSpaceToView(create, 0)
    .topSpaceToView(headerView, startX);
    
    select.sd_layout
    .widthRatioToView(open, 1)
    .heightIs(height)
    .leftSpaceToView(insert, 0)
    .topSpaceToView(headerView, startX);
    
    update.sd_layout
    .widthRatioToView(headerView, 0.25)
    .heightIs(height)
    .leftEqualToView(headerView)
    .topSpaceToView(headerView, startX + 50);
    
    deleteTable.sd_layout
    .widthRatioToView(open, 1)
    .heightIs(height)
    .leftSpaceToView(open, 0)
    .topSpaceToView(headerView, startX + 50);
    
    deleteData.sd_layout
    .widthRatioToView(open, 1)
    .heightIs(height)
    .leftSpaceToView(create, 0)
    .topSpaceToView(headerView, startX + 50);
    
    conditionSelect.sd_layout
    .widthRatioToView(open, 1)
    .heightIs(height)
    .leftSpaceToView(insert, 0)
    .topSpaceToView(headerView, startX + 50);
    
    return headerView;
}

@end
