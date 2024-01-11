package modelo;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.context.internal.ThreadLocalSessionContext;
import org.hibernate.engine.spi.SessionFactoryImplementor;

public class Main {

	public static void main(String[] args) {
		//Configurar la sesion de Hibernate
		SessionFactory sessionFactory= new Configuration().configure().buildSessionFactory();
		
		ThreadLocalSessionContext context = new ThreadLocalSessionContext ((SessionFactoryImplementor) sessionFactory);
				context.bind(sessionFactory.openSession());
				try {
					Fabricante fabrica=new Fabricante ("GOOGLE ESPAÑA");
					
					Session session = context.currentSession();
					
					session.beginTransaction();
					
					session.save(fabrica);
					
					session.getTransaction().commit();
					
					System.out.println("Cliente: "+fabrica);
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					ThreadLocalSessionContext.unbind(sessionFactory);
					sessionFactory.close();

				}
				
	}

}
