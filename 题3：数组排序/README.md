# 1.首先输入要排序的内容
`       int i = 0, k = 1, j, count = -2, m = 0;
        ArraySort as = new ArraySort();
        //以字符串数组形式储存输入的所有内容
        String[] str = new String[10];
        //以字符串数组的形式储存输入内容中的字母
        String [] st = new String[10];
        Scanner sc = new Scanner(System.in);
        do {
            str[i++] = sc.nextLine();
            count++;
        } while (!str[i - 1].equals("]"));`
# 2.接着创建多个数组来记录输入内容
`        //存放输入内容中的第一个字符对应的askii值
        int[] array = new int[count];
        //如果输入的内容有字母，则记录第一个字母
        int[] record = new int[count];
        for (j = 0; j < count; j++) {
        //输入的内容为数字则直接转化为整型数然后存放到array数组
            if (Character.isDigit(str[k].charAt(0))) {
                array[j] = Integer.parseInt(str[k]);
                k++;
            } 
        //输入的内容为非数字则把第一个字母对应的askii值放到array数组，第一个字母放到record数组，输入的内容放到st数组
        else {
                array[j] = (int)str[k].charAt(0);
                record[m] = (int)str[k].charAt(0);
                st[m] = str[k];
                k++;
                m++;
            }
        }`
# 3.排序并输出排序结果
`           as.swap(array);
            System.out.print("[ ");
            enc:for (i = 0; i < array.length; i++) {
                    for (j = 0; j < m; j++) {
                        if (array[i] == record[j]) {
                            System.out.print(st[j] + " ");
                            continue enc;
                    }
                }
                    System.out.print(array[i] + " ");
            }
                System.out.println("]");
        }`
        选择排序
        `    public void swap(int[] a) {
        int i, j, k;
        int temp;
        for (i = 0; i < a.length - 1; i++) {
            k = i;
            for (j = i + 1; j < a.length; j++) {
                if (a[k] > a[j]) {
                    k = j;
                }
            }
            if (k != i) {
                temp = a[k];
                a[k] = a[i];
                a[i] = temp;
            }
        }
    }`

