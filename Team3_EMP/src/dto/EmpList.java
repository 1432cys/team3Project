package dto;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="emplist")
public class EmpList {
	
	@XmlElement(name="emp")
	private List<EmpDto> emps;
	
	public EmpList() {
		
	}
	public EmpList(List<EmpDto> emps) {
		this.emps = emps;
	}
	
	public List<EmpDto> getEmps() {
		return emps;
	}
	public void setEmps(List<EmpDto> emps) {
		this.emps = emps;
	}
	
	

	
}
