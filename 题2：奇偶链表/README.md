# 1.数据结构
`typedef struct Node *PNode;
struct Node {
    int info;
    PNode link;
};`
# 2.创建链表`
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
}`
# 3.修改链表
把所有的奇数节点和偶数节点分别排在一起,head是头结点，odd为奇结点，even为偶结点，evenHead为偶结点的头结点，算法中先分别把奇数结点和偶数结点各个串成一条链表，最后再把奇链表的尾结点连接到偶链表
`PNode oddEvenList(PNode head) {
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
}`


