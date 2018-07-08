import java.util.Scanner;

/**
 * @author Huang Yuguan
 * @date 2018/7/8 16:37
 */
public class ArraySort {
    public void swap(int[] a) {
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
    }

    public static void main(String[] args) {
        int i = 0, k = 1, j, count = -2, m = 0;
        ArraySort as = new ArraySort();
        String[] str = new String[10];
        String [] st = new String[10];
        Scanner sc = new Scanner(System.in);
        do {
            str[i++] = sc.nextLine();
            count++;
        } while (!str[i - 1].equals("]"));
        int[] array = new int[count];
        int[] record = new int[count];
        for (j = 0; j < count; j++) {
            if (Character.isDigit(str[k].charAt(0))) {
                array[j] = Integer.parseInt(str[k]);
                k++;
            } else {
                array[j] = (int)str[k].charAt(0);
                record[m] = (int)str[k].charAt(0);
                st[m] = str[k];
                k++;
                m++;
            }
        }
            as.swap(array);
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
        }
    }
