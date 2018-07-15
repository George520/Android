# 1.judge函数查找唯一字符
`       OnlyChar only = new OnlyChar();
        String str;
        do {
            Scanner sc = new Scanner(System.in);
            str = sc.nextLine();
            char[] a = str.toCharArray();
            only.judege(a);
        } while (str != null);
        `
    judge函数
`    public int judege(char[] letter) {
        int i, j, k = 0,m,count = 0;
        boolean boo = false;
        int len = letter.length;
        char [] storage = new char[26];
        enc:for (i = 0; i < len - 1; i ++) {
            k = i;
            for (j = i + 1; j < len; j++) {
                for (m = 0; m < count; m++) {
                    //假如storage数组中有要比较的字符，则进行下一次循环
                    if (storage[m] ==letter[k]) {
                        continue enc;
                    }
                }
                //把重复出现的字符放入storage数组
                if (letter[k] == letter[j]) {
                    k = j;
                    storage[count++] = letter[k];
                    break;
                }
            }
            if (k == i) {
                boo = true;
                break;
            }
        }
        //判断是否是唯一字符
        if (boo == true) {
            System.out.println(k);
            return k;
        }
        else {
            System.out.println(-1);
            return -1;
        }
    }`
# 2.创建多个数组来记录输入内容
`    public int judege(char[] letter) {
        int i, j, k = 0,m,count = 0;
        boolean boo = false;
        int len = letter.length;
        char [] storage = new char[26];
        enc:for (i = 0; i < len - 1; i ++) {
            k = i;
            for (j = i + 1; j < len; j++) {
                for (m = 0; m < count; m++) {
                    //假如storage数组中有要比较的字符，则进行下一次循环
                    if (storage[m] ==letter[k]) {
                        continue enc;
                    }
                }
                //把重复出现的字符放入storage数组
                if (letter[k] == letter[j]) {
                    k = j;
                    storage[count++] = letter[k];
                    break;
                }
            }
            if (k == i) {
                boo = true;
                break;
            }
        }
        //判断是否是唯一字符
        if (boo == true) {
            System.out.println(k);
            return k;
        }
        else {
            System.out.println(-1);
            return -1;
        }
    }`



