public class Question2B {
    public static void main(String[] args) {
        int[] arr = new int[] {3,7,1,2,6,4};
        System.out.println(findMissingNum(arr));
    }

    public static int findMissingNum(int[] arr) {
        int n = arr.length + 1;
        int total = (n * (n+1)) / 2; // Calculate the sum of array if not missing
        int sum = 0;

        for (int j : arr) {
            sum += j;
        }

        return total - sum; // Return the missing number
    }
}
