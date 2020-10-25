package it.distributedsystems.model.ejb;

import java.util.Hashtable;
import javax.naming.InitialContext;

import it.distributedsystems.model.dao.*;
import org.apache.log4j.Logger;
import org.jboss.system.server.ServerInfo;

public class EJB3DaoFactory extends DAOFactory {
    private static Logger logger = Logger.getLogger("DAOFactory");

    public EJB3DaoFactory() {


    }

    private static InitialContext getInitialContext() throws Exception {
        return new InitialContext();
    }

    public CustomerDAO getCustomerDAO() {
        try {
            InitialContext context = getInitialContext();
            //CustomerDAO result = (CustomerDAO)context.lookup("distributed-systems-demo/EJB3CustomerDAO/local");
            CustomerDAO result = (CustomerDAO)context.lookup("java:module/EJB3CustomerDAO");
            return result;
        } catch (Exception var3) {
            logger.error("Error looking up EJB3CustomerDAO", var3);
            return null;
        }
    }

    public PurchaseDAO getPurchaseDAO() {
        try {
            InitialContext context = getInitialContext();
            //PurchaseDAO result = (PurchaseDAO)context.lookup("distributed-systems-demo/EJB3PurchaseDAO/local");
            PurchaseDAO result = (PurchaseDAO)context.lookup("java:module/EJB3PurchaseDAO");
            return result;
        } catch (Exception var3) {
            logger.error("Error looking up EJB3PurchaseDAO", var3);
            return null;
        }
    }

    public ProductDAO getProductDAO() {
        try {
            InitialContext context = getInitialContext();
            //ProductDAO result = (ProductDAO)context.lookup("distributed-systems-demo/EJB3ProductDAO/local");
            ProductDAO result = (ProductDAO)context.lookup("java:module/EJB3ProductDAO");
            return result;
        } catch (Exception var3) {
            logger.error("Error looking up EJB3ProductDAO", var3);
            return null;
        }
    }

    public ProducerDAO getProducerDAO() {
        try {
            InitialContext context = getInitialContext();
            //ProducerDAO result = (ProducerDAO)context.lookup("distributed-systems-demo/EJB3ProducerDAO/local");
            ProducerDAO result = (ProducerDAO)context.lookup("java:module/EJB3ProducerDAO");
            return result;
        } catch (Exception var3) {
            logger.error("Error looking up EJB3ProducerDAO", var3);
            return null;
        }
    }
}
