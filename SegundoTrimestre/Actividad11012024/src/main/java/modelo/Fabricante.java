package modelo;

import javax.persistence.*;

@Entity
@Table (name ="Fabricante")

public class Fabricante {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column (name="nombre")
	private String nombre;
	
	//Constructor por defecto requerido por Hibernate
	public Fabricante() {
		
	}
	
	//Constructor para crear un objeto de tipo Clientes con un nombre y una ciudad
	
	public Fabricante(String nombre) {
		this.nombre=nombre;
	}
	
	//Getter y setter para el atributo id
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id=id;
	}
	
	//Getter y setter para el atributo nombre
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre=nombre;
	}
	
	//Método para imprimir informacion del objeto fabricante
	
	public String toString() {
		
		return "Alumno{"+
				"id="+id+
				", nombre='"+nombre+'\''+
				'}';
	}
}
