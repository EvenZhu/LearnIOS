//
//  EZSortOperationViewController.m
//  LearnIOS
//
//  Created by Even on 2019/8/2.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZSortOperationViewController.h"

@interface EZSortOperationViewController ()

@end

@implementation EZSortOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int s[] = {48,6,57,42,60,72,83,73,88,85};
    int count = sizeof(s) / sizeof(s[0] - 1);
//    NSLog(@"找到了中位点：%d", findMedian(s,count));
    quick_sort(s,0,count);
}

//快速排序
void quick_sort(int s[], int l, int r)
{
    if (l < r)
    {
        //将中间的这个数和第一个数交换 参见注1
        int i = l, j = r, x = s[l];
        while (i < j)   // 当i==j时即处理结束，s[i]左侧的数均大于s[l],右侧均大于s[l]
        {
            while(i < j && s[j] >= x) // 从右向左找第一个小于x的数
                j--;    // 右侧取值下标前移
            if(i < j)   // 右侧取值下标前移可能小于左侧下标i，所以需要进行判断
                s[i++] = s[j];
            
            while(i < j && s[i] < x) // 从左向右找第一个大于等于x的数
                i++;    // 左侧取值下标后移
            if(i < j)   // 左侧取值下标后移可能大于于右侧下标j，所以需要进行判断
                s[j--] = s[i];
        }
        s[i] = x;
        quick_sort(s, l, i - 1);    // 递归调用处理左侧
        quick_sort(s, i + 1, r);    // 递归调用处理右侧
    }
}


//求一个无序数组的中位数
int findMedian(int a[], int aLen)
{
    int low = 0;
    int high = aLen - 1;
    
    int mid = (aLen - 1) / 2;
    int div = PartSort(a, low, high);
    
    while (div != mid)
    {
        if (mid < div)
        {
            //左半区间找
            div = PartSort(a, low, div - 1);
        }
        else
        {
            //右半区间找
            div = PartSort(a, div + 1, high);
        }
    }
    //找到了
    return a[mid];
}

int PartSort(int a[], int start, int end)
{
    int low = start;
    int high = end;
    
    //选取关键字
    int key = a[end];
    
    while (low < high)
    {
        //左边找比key大的值
        while (low < high && a[low] <= key)
        {
            ++low;
        }
        
        //右边找比key小的值
        while (low < high && a[high] >= key)
        {
            --high;
        }
        
        if (low < high)
        {
            //找到之后交换左右的值
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    
    return low;
}

@end
