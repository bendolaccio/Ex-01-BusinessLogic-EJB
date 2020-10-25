<%@ page import="it.distributedsystems.model.dao.*" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session ="true"%>
<jsp:useBean id="cart" class="it.distributedsystems.model.ejb.Cart" scope="session"></jsp:useBean>
<%!
    String printTableRow(Product product, String url) {
        StringBuffer html = new StringBuffer();
        html
                .append("<tr>")
                .append("<td>")
                .append(product.getName())
                .append("</td>")

                .append("<td>")
                .append(product.getProductNumber())
                .append("</td>")

                .append("<td>")
                .append( (product.getProducer() == null) ? "n.d." : product.getProducer().getName() )
                .append("</td>");

        html
                .append("</tr>");

        return html.toString();
    }
    String printTableRows(List products, String url) {
        StringBuffer html = new StringBuffer();
        Iterator iterator = products.iterator();
        while ( iterator.hasNext() ) {
            html.append( printTableRow( (Product) iterator.next(), url ) );
        }
        return html.toString();
    }
%>
<html>
<head>
    <title>Customer page</title>
</head>
<body>
<h1>Hello to the Professoare Shop!</h1>
<br/>
<%
    DAOFactory daoFactory = DAOFactory.getDAOFactory( application.getInitParameter("dao") );
    CustomerDAO customerDAO = daoFactory.getCustomerDAO();
    PurchaseDAO purchaseDAO = daoFactory.getPurchaseDAO();
    ProductDAO productDAO = daoFactory.getProductDAO();
    ProducerDAO producerDAO = daoFactory.getProducerDAO();

    String operation = request.getParameter("operation");
    if ( operation != null && operation.equals("login") ) {
        String customerStr = request.getParameter("name");
        Customer customer = customerDAO.findCustomerByName(customerStr);
        cart.setCustomer(customer);
    }
    if ( operation != null && operation.equals("addtocart") ) {
        String productNumStr = request.getParameter("product");
        Product product = productDAO.findProductByNumber(Integer.parseInt(productNumStr));
        Boolean flag = true;
        for (Product item : cart.getProducts()) {
            if(item.getId() == product.getId()) flag = false;
        }
        if(flag) cart.addProduct(product);
    }
    if ( operation != null && operation.equals("emptycart") ) {
        cart.emptyCart();
    }
    if ( operation != null && operation.equals("finalize") ) {
        Purchase purchase = new Purchase();
        purchase.setCustomer(cart.getCustomer());
        purchase.setProducts(cart.getProducts());
        purchaseDAO.insertPurchase(purchase);
    }
%>
<div>
    <%
        if(cart.getCustomer() == null){

    %>
    <p>Chi sei?</p>
    <form>
        Nome: <input type="text" name="name">
        <input type="hidden" name="operation" value="login"/>
        <input type="submit" name="submit" value="submit"/>
    </form>
    <%
        }
    %>

    <div>
        <p>Products currently in the database:</p>
        <table>
            <tr><th>Name</th><th>ProductNumber</th><th>Publisher</th><th></th></tr>
            <%= printTableRows( productDAO.getAllProducts(), request.getContextPath() ) %>
        </table>
    </div>
    <form>
        Prodotto: <input type="number" name="product">
        <input type="hidden" name="operation" value="addtocart"/>
        <input type="submit" name="submit" value="submit"/>
    </form>
    <form>
        <input type="hidden" name="operation" value="emptycart"/>
        <input type="submit" name="emptycart" value="Empty cart"/>
    </form>

    <form>
        <input type="hidden" name="operation" value="finalize"/>
        <input type="submit" name="emptycart" value="Finalizza acquisto"/>
    </form>

    <p>Il cart è <%= cart.toString()%></p>
    <div>
        <a href="<%= request.getContextPath() %>">Ricarica lo stato iniziale di questa pagina</a>
    </div>
    <div>
        <a href="./index.jsp">Vai alla pagina management</a>
    </div>
</div>
<br/>

</body>
</html>
