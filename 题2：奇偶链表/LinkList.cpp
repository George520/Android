#include<iostream>
using namespace std;
typedef struct Node *PNode;
struct Node {
    int info;
    PNode link;
};
PNode create() {
    int node;
    bool boo = true;
    PNode head,p,q;
    q = new Node;
    head = new Node;
    do {
        //输入链表各个值，以0结束
        scanf("%d",&node);
        p = new Node;
        p->info = node;
        p->link = NULL;
        //判断是否是头结点
        if (boo == true) {
            head = p;
            boo = false;
        }
        q->link = p;
        q = p;
    }while (node);
    return head;
}
PNode oddEvenList(PNode head) {
    if (head == NULL) return NULL;
    PNode odd = head, even = head->link, evenHead = even;
    while (even != NULL && even->link != NULL) {
        odd->link = even->link;
        odd = odd->link;
        even->link = odd->link;
        even = even->link;
    }
    odd->link = evenHead;
    return head;
}
int main()
{
    srand((int)(time(NULL)));
    PNode head = create();
    PNode root = head;
    //初始链表
    while(head->link!= NULL) {
        cout << head->info << "->";
        head = head->link;

    }
    cout << "NULL" << endl;
    root = oddEvenList(root);
    //奇偶链表
    while(root->link != NULL) {
        cout << root->info << "->";
        root = root->link;
    }
    cout << "NULL" << endl;
    return 0;
}
