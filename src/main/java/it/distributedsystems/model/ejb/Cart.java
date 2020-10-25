package it.distributedsystems.model.ejb;

import it.distributedsystems.model.dao.Customer;
import it.distributedsystems.model.dao.Product;

import javax.ejb.Stateful;
import java.util.HashSet;
import java.util.Set;

@Stateful (mappedName = "cart", name = "cart")
public class Cart{

    Customer customer = null;
    Set<Product> products;

    public Cart(){
        products = new HashSet<>();
    }

    public Set<Product> getProducts() {
        return products;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public void addProduct(Product product){
        products.add(product);
    }

    public void emptyCart(){
        products = new HashSet<>();
    }

    @Override
    public String toString() {
        return "Cart{" +
                "customer=" + customer +
                ", products=" + products +
                '}';
    }
}
