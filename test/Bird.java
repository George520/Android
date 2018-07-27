/**
 * @author Huang Yuguan
 * @date 2018/5/27 16:18
 */
public class Bird implements Animal{
    public void run(){
        System.out.println("I am a bird");
    }
    public static void main(String[] args){
        Bird b = new Bird();
        b.run();
    }
}
