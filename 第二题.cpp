/*
2、校园导游咨询（为来访的客人提供各种信息服务）
1）参考校园设计平面图，在校园景点选10个左右景点。以图中顶点表示校园内各景点，存放景点名称、代号、简介等信息；以边表示路径，存放路径长度等有关信息。
2）为来访客人提供图中任意景点相关信息的查询。
3）为来访客人提供任意景点的问路查询，即查询任意两个景点之间的一条最短路径。
*/

#include<iostream>
#include<stdlib.h>
#include<string>
#define MX 65535
#define NUM  10
using namespace std;

typedef struct      //顶点
{
	int vex;              /*顶点号*/
	string name;          /*景点名字*/
	string jieshao;       /*景点简介*/
}Vertex;

typedef struct {       //图
	Vertex *vexs;    //顶点
	int * arcs[10];  //边
}GraphMatrix;

typedef struct    //使用算法的辅助结构体
{
	int a[NUM][NUM];   //用于存储边与边间的关系 
	int  nextvex[NUM][NUM];//用于 
}shortPath;

Vertex node[10] =
{
	{ 1, "叠翠山", "叠翠山是河海大学江宁校区中心景观绿地，环境优美四季花开，有亭台花榭错落其中" },
	{ 2, "宿舍区", "宿舍区由新旧两部分学生组团组成，建有研究生与本科生宿舍楼及其配套的一体化餐饮中心" },
	{ 3, "文体中心", "文体中心共有4层，内设有乒乓球，篮球，羽毛球等场地，同时也是重大典礼举办的场所。" },
	{ 4, "西操场", "西操场为临近宿舍区的塑胶足球场，周长300米，常有同学在此晨练夜跑，周末常常举办足球赛和各类素拓" },
	{ 5, "小浪底", "小浪底音乐广场由半圆形看台回音壁组成，常常举办音乐会嘉年华等室外文娱活动，也是江宁校区地标。" },
	{ 6, "图书馆", "图书馆收纳了各个专业的相关书籍，是名副其实的“书的海洋”，提供了丰富的学习资源。" },
	{ 7, "勤学楼", "勤学楼由五个部分组成，是能电院计信院大禹院的院部以及科研办公楼，也是学校基建处办公地。" },
	{ 8, "三峡广场", "位于图书馆于南门之间的草坪，气势雄伟，设有地下停车场，2005年温总理视察河海大学在此发表讲话。" },
	{ 9, "博学楼", "博学楼是江宁校区最高建筑，是商学院的院部和教学楼，环境优雅，设施完善。" },
	{ 10, "南大门", "南大门是河海大学正门，上书邓小平同志亲笔所题校名。" }
};

int arc[NUM][NUM] =                 //arc数组用于存放各路径之间的长度
{
    { 0, 10, 10, 40, 40, MX, MX, MX, MX, MX },
    { 10, 0, 15, 30, MX, MX, MX, MX, MX, MX },
    { 10, 15, 0, MX, 30, MX, MX, MX, MX, MX },
    { 40, 30, MX, 0, 2, MX, MX, MX, MX, MX },
    { 40, MX, 30, 2, 0, 20, MX, MX, MX, MX },
    { MX, MX, MX, MX, 20, 0, 25, 30, MX, MX },
    { MX, MX, MX, MX, MX, 25, 0, 20, MX, MX },
    { MX, MX, MX, MX, MX, 30, 20, 0, 15, 30 },
    { MX, MX, MX, MX, MX, MX, MX, 15, 0, 20 },
    { MX, MX, MX, MX, MX, MX, MX, 30, 20, 0 }
};

void navigation();
void map();
void find();
void Floyd(GraphMatrix *pgragh, shortPath *ppath);
void find_path(GraphMatrix g);

int main()
{
	GraphMatrix g;
	map();
	navigation();
    g.vexs = node;
	for (int i = 0; i < 10; i++) {
		g.arcs[i] = arc[i];
	}
	char c;
	cin>>c;
	while(c<'0'||c>'9'){
		cout<<"输入错误"<<endl;
		cout<<"请输入正确指令"<<endl;
		cin>>c;
	} 
	int a=(int)c-48;
	while(1){
        if(a==1) {
            find();
        }
        else if(a==2) {
            find_path(g);
        }
        else if(a==3)
            break;
        else cout<<"输入错误";
        cout << "请选择数字命令：";
        cin>>c;
		while(c<'0'||c>'9'){
		cout<<"输入错误"<<endl;
		cout<<"请输入正确指令"<<endl;
		cin>>c;
		} 
		a=(int)c-48;
    }
	cout<<endl;
	return 0;
}

void navigation()                      //该函数用于打印导航图
{
	cout << "                        ----------------------------     " << endl;
	cout << "                            河海大学校园导游咨询         " << endl;
	cout << "                                                         " << endl;
	cout << "                               1   景点信息              " << endl;
	cout << "                               2   查询路径              " << endl;
	cout << "                               3   退出系统              " << endl;
	cout << "                                                         " << endl;
    cout << "                              欢迎来到河海大学！         " << endl;
	cout << "                        ----------------------------     " << endl;
	cout << endl;
	cout << "请选择数字命令：";
}

void map()                            //该函数负责打印校园地图
{
	cout << endl;
	cout << "     ★---------★---------★---------★---------★---------★---------★" << endl;
	cout << "                                【1】叠翠山"                               << endl;
	cout << "     ☆                                                                ☆" << endl;
	cout << "            【2】宿舍区                            【3】文体中心         " << endl;
	cout << "                                                                         " << endl;
	cout << "     ☆     【4】西操场         【5】小浪底                            ☆" << endl;
	cout << "                                                                         " << endl;
	cout << "                                【6】图书馆                              " << endl;
	cout << "     ☆                                             【7】勤学楼        ☆" << endl;
	cout << "             北                 【8】三峡广场                            " << endl;
	cout << "         西<-|->东                                                       " << endl;
	cout << "     ☆      南                                     【9】博学楼        ☆" << endl;
	cout << "                                【10】南大门                             " << endl;
	cout << "     ★---------★---------★---------★---------★---------★---------★" << endl;
}

void find()/*查询景点信息*/
{
	char c;
	int a;
	cout << "请输入您想要查询的景点编号" << endl;
	cin >> c;
	while(c>'9'||c<'0'){
		cout<<"输入错误"<<endl;
	 	cout << "请输入您想要查询的景点编号" << endl;
	 	cin>>c;
	}
	a=(int)c-48;
	if (a >= 1 && a <= 10)
	{
		cout << "查询结果如下:" << endl;
		cout << "[" << node[a - 1].vex << "]" << ":";
		cout << node[a - 1].name << endl;
		cout << "该景点简介：" << node[a - 1].jieshao << endl;
	}
	else
	{
		cout << "当前并无该景点" << endl;
	}
}

void find_path(GraphMatrix g)  /*查询最短路径*/
{
	shortPath p;
	Floyd(&g, &p);
	char a, b; 
	int n,m,k;
	cout << "★请输入两个景点（起点和终点）的编号，用空格隔开，按回车查询★"<<endl;
	cin >> a >> b;
	while(a>'9'||a<'0'||b>'9'||b<'0'){
		cout<<"输入的格式是错误的，请重新输入"<<endl;
	 	cout << "★请输入两个景点（起点和终点）的编号，用空格隔开，按回车查询★"<<endl;
	 	cin >> a >> b;
	}
	n=(int)a-48;
	m=(int)b-48;
	cout << "这两个景点之间的距离为" <<endl<< p.a[n - 1][m - 1] <<"0米"<<endl;
	cout << "为您选择的最佳路径为"<<endl<<"★";
	k = p.nextvex[n - 1][m - 1];
	cout << node[n - 1].name<<"->"<< node[k].name;
	while (k != m - 1) {
		cout<<"->";
		k = p.nextvex[k][m - 1];
		cout << node[k].name ;
	}
	cout<<"★"<<endl;
}

void Floyd(GraphMatrix *pgragh, shortPath *ppath)   // 查询最短路径会用到的floyd算法
{
	int i, j, k;
	for (i = 0; i<NUM; i++)  //初始化*ppath
	for (j = 0; j<NUM; j++){
			if (pgragh->arcs[i][j] != MX)ppath->nextvex[i][j] = j;
			else ppath->nextvex[i][j] = -1;
			ppath->a[i][j] = pgragh->arcs[i][j];}
	for (k = 0; k<NUM; k++)  //迭代计算*ppath
			{
				for (i = 0; i<NUM; i++)
				{
					for (j = 0; j<NUM; j++)
					{
						if ((ppath->a[i][k] >= MX) || (ppath->a[k][j] >= MX))continue;
						if (ppath->a[i][j]>(ppath->a[i][k] + ppath->a[k][j])) {

							ppath->a[i][j] = ppath->a[i][k] + ppath->a[k][j];
							ppath->nextvex[i][j] = ppath->nextvex[i][k];
						}   //修改*ppath
					}
				}
			}
}
