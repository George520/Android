#include<iostream>
using namespace std;
#define MAX 100
struct Stu{
    /*
     * id和name的大小最好弄大一点,否则后面strcpy复制时会出问题
     */
    char id[12];
    char name[20];
    int Chinese;
    int Math;
    int English;
};
typedef Stu ElemType;
struct classes{
    ElemType stu[MAX];
    int len;
};
typedef classes *plist;
/*
 * 初始化
 */
int init(classes *c){
    strcpy(c->stu[c->len].id,"1606020216");
    strcpy(c->stu[c->len].name,"张三");
    c->stu[c->len].Chinese = 130;
    c->stu[c->len].Math = 140;
    c->stu[c->len].English = 150;
    c->len++;
    strcpy(c->stu[c->len].id,"1606020217");
    strcpy(c->stu[c->len].name,"李四");
    c->stu[c->len].Chinese = 110;
    c->stu[c->len].Math = 130;
    c->stu[c->len].English = 145;
    c->len++;
    strcpy(c->stu[c->len].id,"1606020218");
    strcpy(c->stu[c->len].name,"陈五");
    c->stu[c->len].Chinese = 105;
    c->stu[c->len].Math = 123;
    c->stu[c->len].English = 134;
    c->len++;
    printf("学号\t\t姓名\t语文\t数学\t英语\t平均分\n");
    for(int i = 0; i < c->len; i++){
    printf("%s\t%s\t%d\t%d\t%d\t%.2f\n",c->stu[i].id,c->stu[i].name,c->stu[i].Chinese,c->stu[i].Math,c->stu[i].English,(c->stu[i].Chinese+c->stu[i].Math+c->stu[i].English)/3.0);
    }
    return 0;
}
/*
 * 显示数据
 */
void display(classes *c){
    printf("学号\t\t姓名\t语文\t数学\t英语\t平均分\n");
    for(int i = 0; i < c->len; i++){
        printf("%s\t%s\t%d\t%d\t%d\t%.2f\n",c->stu[i].id,c->stu[i].name,c->stu[i].Chinese,c->stu[i].Math,c->stu[i].English,(c->stu[i].Chinese+c->stu[i].Math+c->stu[i].English)/3.0);
    }
}
/*
 * 插入数据
 */
plist insert(classes *c){
    printf("请输入学号、姓名、语文、数学、英语成绩:\n");
    scanf("%s%s%d%d%d",c->stu[c->len].id,c->stu[c->len].name,&c->stu[c->len].Chinese,&c->stu[c->len].Math,&c->stu[c->len].English);
    c->len++;
    return c;
}
/*
 * 删除数据
 */
plist del(classes *c){
    int row;
    printf("删除第几行？\n");
    scanf("%d",&row);
    for(int i = row - 1; i < c->len - 1; i++){
        strcpy(c->stu[i].id,c->stu[i+1].id);
        strcpy(c->stu[i].name,c->stu[i+1].name);
        c->stu[i].Chinese = c->stu[i+1].Chinese;
        c->stu[i].Math = c->stu[i+1].Math;
        c->stu[i].English = c->stu[i+1].English;
    }
    c->len--;
    return c;
}
/*
 * 数据排序
 */
plist sort(classes *c){
    int temp1,temp2,temp3;
    int i,j;
    char a[12],b[20];
    for(j = 0; j < c->len; j++)
        for(i = 0; i < c->len-1; i++){
            if((c->stu[i].Chinese+c->stu[i].Math+c->stu[i].English)/3.0 < (c->stu[i+1].Chinese+c->stu[i+1].Math+c->stu[i+1].English)/3.0){
                strcpy(a,c->stu[i].id);
                strcpy(c->stu[i].id,c->stu[i+1].id);
                strcpy(c->stu[i+1].id,a);

                strcpy(b,c->stu[i].name);
                strcpy(c->stu[i].name,c->stu[i+1].name);
                strcpy(c->stu[i+1].name,b);

                temp1 = c->stu[i].Chinese;
                c->stu[i].Chinese = c->stu[i+1].Chinese;
                c->stu[i+1].Chinese = temp1;

                temp2 = c->stu[i].Math;
                c->stu[i].Math = c->stu[i+1].Math;
                c->stu[i+1].Math = temp2;

                temp3 = c->stu[i].English;
                c->stu[i].English = c->stu[i+1].English;
                c->stu[i+1].English = temp3;
            }
        }
    return c;
}
int main(){
    int d,k = 1;
    plist p = new classes;
    init(p);
    while(k){
    printf("1.插入数据\n2.删除数据\n3.排序\n4.退出\n");
    scanf("%d",&d);
    switch(d){
        case 1:insert(p);
               display(p);
               break;
        case 2:del(p);
               display(p);
               break;
        case 3:sort(p);
               display(p);
               break;
        case 4:k = 0;
               break;
    }
    }
    return 0;
}
