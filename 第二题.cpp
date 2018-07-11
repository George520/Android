/*
2��У԰������ѯ��Ϊ���õĿ����ṩ������Ϣ����
1���ο�У԰���ƽ��ͼ����У԰����ѡ10�����Ҿ��㡣��ͼ�ж����ʾУ԰�ڸ����㣬��ž������ơ����š�������Ϣ���Ա߱�ʾ·�������·�����ȵ��й���Ϣ��
2��Ϊ���ÿ����ṩͼ�����⾰�������Ϣ�Ĳ�ѯ��
3��Ϊ���ÿ����ṩ���⾰�����·��ѯ������ѯ������������֮���һ�����·����
*/

#include<iostream>
#include<stdlib.h>
#include<string>
#define MX 65535
#define NUM  10
using namespace std;

typedef struct      //����
{
	int vex;              /*�����*/
	string name;          /*��������*/
	string jieshao;       /*������*/
}Vertex;

typedef struct {       //ͼ
	Vertex *vexs;    //����
	int * arcs[10];  //��
}GraphMatrix;

typedef struct    //ʹ���㷨�ĸ����ṹ��
{
	int a[NUM][NUM];   //���ڴ洢����߼�Ĺ�ϵ 
	int  nextvex[NUM][NUM];//���� 
}shortPath;

Vertex node[10] =
{
	{ 1, "����ɽ", "����ɽ�ǺӺ���ѧ����У�����ľ����̵أ����������ļ���������̨ͤ��鿴�������" },
	{ 2, "������", "���������¾�������ѧ��������ɣ������о����뱾��������¥�������׵�һ�廯��������" },
	{ 3, "��������", "�������Ĺ���4�㣬������ƹ����������ë��ȳ��أ�ͬʱҲ���ش����ٰ�ĳ�����" },
	{ 4, "���ٳ�", "���ٳ�Ϊ�ٽ����������ܽ����򳡣��ܳ�300�ף�����ͬѧ�ڴ˳���ҹ�ܣ���ĩ�����ٰ��������͸�������" },
	{ 5, "С�˵�", "С�˵����ֹ㳡�ɰ�Բ�ο�̨��������ɣ������ٰ����ֻ���껪������������Ҳ�ǽ���У���رꡣ" },
	{ 6, "ͼ���", "ͼ��������˸���רҵ������鼮����������ʵ�ġ���ĺ��󡱣��ṩ�˷ḻ��ѧϰ��Դ��" },
	{ 7, "��ѧ¥", "��ѧ¥�����������ɣ����ܵ�Ժ����Ժ����Ժ��Ժ���Լ����а칫¥��Ҳ��ѧУ�������칫�ء�" },
	{ 8, "��Ͽ�㳡", "λ��ͼ���������֮��Ĳ�ƺ��������ΰ�����е���ͣ������2005���������Ӳ�Ӻ���ѧ�ڴ˷�������" },
	{ 9, "��ѧ¥", "��ѧ¥�ǽ���У����߽���������ѧԺ��Ժ���ͽ�ѧ¥���������ţ���ʩ���ơ�" },
	{ 10, "�ϴ���", "�ϴ����ǺӺ���ѧ���ţ������Сƽͬ־�ױ�����У����" }
};

int arc[NUM][NUM] =                 //arc�������ڴ�Ÿ�·��֮��ĳ���
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
		cout<<"�������"<<endl;
		cout<<"��������ȷָ��"<<endl;
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
        else cout<<"�������";
        cout << "��ѡ���������";
        cin>>c;
		while(c<'0'||c>'9'){
		cout<<"�������"<<endl;
		cout<<"��������ȷָ��"<<endl;
		cin>>c;
		} 
		a=(int)c-48;
    }
	cout<<endl;
	return 0;
}

void navigation()                      //�ú������ڴ�ӡ����ͼ
{
	cout << "                        ----------------------------     " << endl;
	cout << "                            �Ӻ���ѧУ԰������ѯ         " << endl;
	cout << "                                                         " << endl;
	cout << "                               1   ������Ϣ              " << endl;
	cout << "                               2   ��ѯ·��              " << endl;
	cout << "                               3   �˳�ϵͳ              " << endl;
	cout << "                                                         " << endl;
    cout << "                              ��ӭ�����Ӻ���ѧ��         " << endl;
	cout << "                        ----------------------------     " << endl;
	cout << endl;
	cout << "��ѡ���������";
}

void map()                            //�ú��������ӡУ԰��ͼ
{
	cout << endl;
	cout << "     ��---------��---------��---------��---------��---------��---------��" << endl;
	cout << "                                ��1������ɽ"                               << endl;
	cout << "     ��                                                                ��" << endl;
	cout << "            ��2��������                            ��3����������         " << endl;
	cout << "                                                                         " << endl;
	cout << "     ��     ��4�����ٳ�         ��5��С�˵�                            ��" << endl;
	cout << "                                                                         " << endl;
	cout << "                                ��6��ͼ���                              " << endl;
	cout << "     ��                                             ��7����ѧ¥        ��" << endl;
	cout << "             ��                 ��8����Ͽ�㳡                            " << endl;
	cout << "         ��<-|->��                                                       " << endl;
	cout << "     ��      ��                                     ��9����ѧ¥        ��" << endl;
	cout << "                                ��10���ϴ���                             " << endl;
	cout << "     ��---------��---------��---------��---------��---------��---------��" << endl;
}

void find()/*��ѯ������Ϣ*/
{
	char c;
	int a;
	cout << "����������Ҫ��ѯ�ľ�����" << endl;
	cin >> c;
	while(c>'9'||c<'0'){
		cout<<"�������"<<endl;
	 	cout << "����������Ҫ��ѯ�ľ�����" << endl;
	 	cin>>c;
	}
	a=(int)c-48;
	if (a >= 1 && a <= 10)
	{
		cout << "��ѯ�������:" << endl;
		cout << "[" << node[a - 1].vex << "]" << ":";
		cout << node[a - 1].name << endl;
		cout << "�þ����飺" << node[a - 1].jieshao << endl;
	}
	else
	{
		cout << "��ǰ���޸þ���" << endl;
	}
}

void find_path(GraphMatrix g)  /*��ѯ���·��*/
{
	shortPath p;
	Floyd(&g, &p);
	char a, b; 
	int n,m,k;
	cout << "���������������㣨�����յ㣩�ı�ţ��ÿո���������س���ѯ��"<<endl;
	cin >> a >> b;
	while(a>'9'||a<'0'||b>'9'||b<'0'){
		cout<<"����ĸ�ʽ�Ǵ���ģ�����������"<<endl;
	 	cout << "���������������㣨�����յ㣩�ı�ţ��ÿո���������س���ѯ��"<<endl;
	 	cin >> a >> b;
	}
	n=(int)a-48;
	m=(int)b-48;
	cout << "����������֮��ľ���Ϊ" <<endl<< p.a[n - 1][m - 1] <<"0��"<<endl;
	cout << "Ϊ��ѡ������·��Ϊ"<<endl<<"��";
	k = p.nextvex[n - 1][m - 1];
	cout << node[n - 1].name<<"->"<< node[k].name;
	while (k != m - 1) {
		cout<<"->";
		k = p.nextvex[k][m - 1];
		cout << node[k].name ;
	}
	cout<<"��"<<endl;
}

void Floyd(GraphMatrix *pgragh, shortPath *ppath)   // ��ѯ���·�����õ���floyd�㷨
{
	int i, j, k;
	for (i = 0; i<NUM; i++)  //��ʼ��*ppath
	for (j = 0; j<NUM; j++){
			if (pgragh->arcs[i][j] != MX)ppath->nextvex[i][j] = j;
			else ppath->nextvex[i][j] = -1;
			ppath->a[i][j] = pgragh->arcs[i][j];}
	for (k = 0; k<NUM; k++)  //��������*ppath
			{
				for (i = 0; i<NUM; i++)
				{
					for (j = 0; j<NUM; j++)
					{
						if ((ppath->a[i][k] >= MX) || (ppath->a[k][j] >= MX))continue;
						if (ppath->a[i][j]>(ppath->a[i][k] + ppath->a[k][j])) {

							ppath->a[i][j] = ppath->a[i][k] + ppath->a[k][j];
							ppath->nextvex[i][j] = ppath->nextvex[i][k];
						}   //�޸�*ppath
					}
				}
			}
}
