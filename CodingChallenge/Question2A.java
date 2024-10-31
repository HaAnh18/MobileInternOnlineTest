import java.util.ArrayList;
import java.util.Comparator;

public class Question2A {
    public static void main(String[] args) {
        ProductList productList = new ProductList();

        productList.addProduct("Laptop", 999.99, 5);
        productList.addProduct("Smartphone", 499.99, 10);
        productList.addProduct("Tablet", 299.99, 0);
        productList.addProduct("Smartwatch", 199.99, 3);

        System.out.printf("%.2f%n", productList.calculateTotalInventoryValue());
        System.out.println(productList.findMostExpensive());
        System.out.println(productList.checkProductInStock("Headphones"));
        productList.sortProductList("Ascending", "Quantity");
    }
}

class ProductList {
    ArrayList<Product> productList;

    public ProductList() {
        this.productList = new ArrayList<Product>();
    }

    public void addProduct(String name, double price, int quantity) {
        Product newProduct = new Product(name, price, quantity);
        productList.add(newProduct);
    }

    public double calculateTotalInventoryValue() {
        double total = 0;
        for (Product product : productList) {
            double totalEachProduct = product.price * product.quantity;
            total += totalEachProduct;
        }

        return total;
    }

    public String findMostExpensive() {
        if (productList.size() < 1) {
            return "Don't have any item.";
        }

        Product mostExpensiveP = productList.get(0);

        for (Product product : productList) {
            if (product.price > mostExpensiveP.price) {
                mostExpensiveP = product;
            }
        }

        return mostExpensiveP.name;
    }

    public boolean checkProductInStock(String name) {
        for (Product product : productList) {
            if (product.name.equals(name)) {
                return true;
            }
        }
        return false;
    }

    public void sortProductList(String order, String option) {
        if (order.equals("Ascending") && option.equals("Price")) {
            System.out.println("Sort by price in ascending order: ");
            sortAscPrice();
        } else if (order.equals("Descending") && option.equals("Price")) {
            System.out.println("Sort by price in descending order: ");
            sortDesPrice();
        } else if (order.equals("Ascending") && option.equals("Quantity")) {
            System.out.println("Sort by quantity in ascending order: ");
            sortAscQuantity();
        } else if (order.equals("Descending") && option.equals("Quantity")) {
            System.out.println("Sort by quantity in descending order: ");
            sortDesQuantity();
        }
        displayProducts();
    }

    private void displayProducts() {
        for (Product product : productList) {
            System.out.println(product.toString());
        }
    }

    private void sortAscPrice() {
        productList.sort(Comparator.comparingDouble(Product::getPrice));
    }

    private void sortDesPrice() {
        productList.sort(Comparator.comparingDouble(Product::getPrice).reversed());
    }

    private void sortAscQuantity() {
        productList.sort(Comparator.comparingDouble(Product::getQuantity));
    }

    private void sortDesQuantity() {
        productList.sort(Comparator.comparingDouble(Product::getQuantity).reversed());
    }

}

class Product {
    String name;
    double price;
    int quantity;

    public Product(String name, double price, int quantity) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    @Override
    public String toString() {
        return "Product: " +
                "name='" + name + '\'' +
                ", price=" + price +
                ", quantity=" + quantity;
    }

}