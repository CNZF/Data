//
//  ViewController.m
//  Data
//
//  Created by lxy on 2019/3/12.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * array = [NSMutableArray arrayWithObjects:@8,@7,@6,@5,@4,@3,@2,@1, nil];
    //调用排序
    [self mergeSortArray:array];
    NSLog(@"%@",array);
}


#pragma mark --冒泡排序
/*
 1, 最差时间复杂度 O(n^2)
 　　2, 平均时间复杂度 O(n^2)
 */
-(void)maoPao{
    
    NSMutableArray *arr=[NSMutableArray arrayWithArray:@[@"31",@"12",@"59",@"66",@"78",@"36",@"48"]];
    
    if (arr.count  == 0) {
        return;
    }
    
    for (int i = 0;i < arr.count ; i++) {
        
        for (int j = 0; j < arr.count-i-1 ; j++) {
            
            if ([arr[j] intValue] < [arr[j+1] intValue]) {
                
                int temp=[arr[j] intValue];
                
                arr[j]=arr[j+1];
                
                arr[j+1]=[NSString stringWithFormat:@"%d",temp];
            }
        }
    }
    NSLog(@"%@",arr);
}

#pragma mark --快速p排序
//选0为基数，左右来回查找，找到的占0当前的这个坑，知道i=j的时候，把0这个值给到 i的坑。剩下两边的，递归继续原理一样
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}

#pragma mark --插入排序
/*
 思路
 1.选定第一个元素，认为该元素已经是排序好的
 2.取下一个元素，在已拍好的元素序列中从后向前扫描
 3如果排好的y元素大于新元素，则将该元素向右移一个位置
 4重复3，直到排序好的元素小于或者等于新元素
 5直到插入新的元素
 6.重复步骤2，选取新元素
 
 平均时间复杂度O(n²)
 平均控件复杂度O(1)
 
 */
- (void)selectionAscendingOrderSortWithArray:(NSMutableArray *)arr
{
    if ( arr.count == 0) {
        return;
    }
    for (int i = 1; i<arr.count; i++) {
        int temp = [arr[i] intValue];
        for (int j = i-1 ; j>= 0 && temp < [arr[j] intValue]; j--) {
            arr[j+1] = arr[j];
            arr[j] = [NSNumber numberWithInt:temp];
        }
    }
    
    NSLog(@"%@",arr);
}



#pragma mark-- 选择排序
/*
    1. 设数组内存放了n个待排数字，数组下标从1开始，到n结束。
 　　 2. i=1
 　　 3. 从数组的第i个元素开始到第n个元素，寻找最小的元素。（具体过程为:先设arr[i]为最小，逐一比较，若遇到比之小的则交换）
 　　 4. 将上一步找到的最小元素和第i位元素交换。
 　　 5. 如果i=n－1算法结束，否则回到第3步
 
 平均时间复杂度：O(n^2)
 　　平均空间复杂度：O(1)
 */
- (void)XZPXAscendingOrderSortWithArray:(NSMutableArray *)ascendingArr
{
    for (int i = 0; i<ascendingArr.count; i++) {
        for (int j = i+1; j<ascendingArr.count; j++) {
            if ([ascendingArr[i] integerValue] > [ascendingArr[j] integerValue]) {
                int temp = [ascendingArr[i] intValue];
                ascendingArr[i] = ascendingArr[j];
                ascendingArr[j] = [NSNumber numberWithInt:temp];
            }
        }
    }
     NSLog(@"%@",ascendingArr);
}


#pragma mark --基数排序

/*
 以LSD为例
 最低位优先(Least Significant Digit first)法，简称LSD法：先从kd开始排序，再对kd-1进行排序，依次重复，直到对k1排序后便得到一个有序序列。
 1.首先根据个位数的数值，在走访数值时将它们分配至编号0到9的桶子中
 2.接下来将这些桶子中的数值重新串接起来，成为以下的数列，接着再进行一次分配，这次是根据十位数来分配
 3.接下来将这些桶子中的数值重新串接起来，成为以下的数列，若还有百位什么的，继续循环
 
 
 
 MSD是是从高位向地位进行的
 
 时间复杂度为O(d(n+radix))
 */

- (void)JishuSort:(NSMutableArray *)arr
{
    NSMutableArray *buckt = [self createBucket];
    //待排数组的最大数值
    NSNumber *maxnumber = [self listMaxItem:arr];
    //最大数值的数字位数
    NSInteger maxLength = numberLength(maxnumber);
    // 按照从低位到高位的顺序执行排序过程
    for (int digit = 1; digit <= maxLength; digit++) {
        //y由后向前取数据的每一位，根据位数入桶
        // 入桶
        if (digit != 1) {
            for (NSMutableArray * subArr in buckt) {
                [subArr removeAllObjects];
            }
        }
        
        for (NSNumber *item in arr) {
            
            //确定item 归属哪个桶 以digit位数为基数
            NSInteger baseNumber = [self fetchBaseNumber:item digit:digit];
            NSMutableArray *mutArray = buckt[baseNumber];
            //将数据放入空桶上
            [mutArray addObject:item];
        }
        NSInteger index = 0;
        //出桶
        [arr removeAllObjects];
        for (int i = 0; i < buckt.count; i++) {
            
            NSMutableArray *array = buckt[i];
            //将桶的数据放回待排数组中
            while (index < array.count) {
                
                NSNumber *number = [array objectAtIndex:index];
                [arr addObject:number];
                index++;
            }
            index = 0;
        }
    }
    NSLog(@"基数升序排序结果：%@", arr);
}
//创建空桶
- (NSMutableArray *)createBucket {
    NSMutableArray *bucket = [NSMutableArray array];
    for (int index = 0; index < 10; index++) {
        NSMutableArray *array = [NSMutableArray array];
        [bucket addObject:array];
    }
    return bucket;
}

//数据最大值
- (NSNumber *)listMaxItem:(NSMutableArray *)list {
    NSNumber *maxNumber = list[0];
    
    for (NSNumber *number in list) {
        if ([maxNumber integerValue] < [number integerValue]) {
            maxNumber = number;
        }
    }
    return maxNumber;
}


//数字的位数
NSInteger numberLength(NSNumber *number) {
    NSString *string = [NSString stringWithFormat:@"%ld", (long)[number integerValue]];
    return string.length;
}

//h获取当前位数排序的数值，将该数值对应的元素放入 桶内
-  (NSInteger)fetchBaseNumber:(NSNumber *)number digit:(NSInteger)digit {
    //digit为基数位数
    if (digit > 0 && digit <= numberLength(number)) {
        NSMutableArray *numbersArray = [NSMutableArray array];
        //        number的位数确定
        NSString *string = [NSString stringWithFormat:@"%ld", [number integerValue]];
        for (int index = 0; index < numberLength(number); index++) {
            [numbersArray addObject:[string substringWithRange:NSMakeRange(index, 1)]];
        }
        //        number的位数 是几位数的
        NSString *str = numbersArray[numbersArray.count - digit];
        
        
        return [str integerValue];
    }
    return 0;
}

#pragma mark --归并排序
- (void)mergeSortArray:(NSMutableArray *)array {
    //创建一个副本数组
    NSMutableArray * auxiliaryArray = [[NSMutableArray alloc]initWithCapacity:array.count];
    
    //对数组进行第一次二分，初始范围为0到array.count-1
    [self mergeSort:array auxiliary:auxiliaryArray low:0 high:array.count-1];
}
- (void)mergeSort:(NSMutableArray *)array auxiliary:(NSMutableArray *)auxiliaryArray low:(int)low high:(int)high {
    //递归跳出判断
    if (low>=high) {
        return;
    }
    //对分组进行二分
    int middle = (high - low)/2 + low;
    
    //对左侧的分组进行递归二分 low为第一个元素索引，middle为最后一个元素索引
    [self mergeSort:array auxiliary:auxiliaryArray low:low high:middle];
    
    //对右侧的分组进行递归二分 middle+1为第一个元素的索引，high为最后一个元素的索引
    [self mergeSort:array auxiliary:auxiliaryArray low:middle + 1 high:high];
    
    //对每个有序数组进行回归合并
    [self merge:array auxiliary:auxiliaryArray low:low middel:middle high:high];
}
- (void)merge:(NSMutableArray *)array auxiliary:(NSMutableArray *)auxiliaryArray low:(int)low middel:(int)middle high:(int)high {
    //将数组元素复制到副本
    for (int i=low; i<=high; i++) {
        auxiliaryArray[i] = array[i];
    }
    //左侧数组标记
    int leftIndex = low;
    //右侧数组标记
    int rightIndex = middle + 1;
    
    //比较完成后比较小的元素要放的位置标记
    int currentIndex = low;
    
    while (leftIndex <= middle && rightIndex <= high) {
        //此处是使用NSNumber进行的比较，你也可以转成NSInteger再比较
        if ([auxiliaryArray[leftIndex] compare:auxiliaryArray[rightIndex]]!=NSOrderedDescending) {
            //左侧标记的元素小于等于右侧标记的元素
            array[currentIndex] = auxiliaryArray[leftIndex];
            currentIndex++;
            leftIndex++;
        }else{
            //右侧标记的元素小于左侧标记的元素
            array[currentIndex] = auxiliaryArray[rightIndex];
            currentIndex++;
            rightIndex++;
        }
    }
    //如果完成后左侧数组有剩余
    if (leftIndex <= middle) {
        for (int i = 0; i<=middle - leftIndex; i++) {
            array[currentIndex +i] = auxiliaryArray[leftIndex +i ];
        }
    }
}

@end
