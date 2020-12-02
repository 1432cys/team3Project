package kosta.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.fasterxml.jackson.databind.ObjectMapper;

import dto.EmpDto;
import service.EmpService;


@Controller
public class AjaxController {

	//org.springframework.web.servlet.view.json.MappingJackson2JsonView
	@Autowired
	private View jsonview;
	
	@Autowired
	private EmpService empservice;
	
	@RequestMapping(value="response.ajax")
	public void ajaxResponse(HttpServletResponse response){
		String empJson="[";
		
		List<EmpDto> list = empservice.getEmpList();
		for(int i=0;i<list.size();i++) {
			  empJson +=
			           "{\"empno\":\""+list.get(i).getEmpno()
			           +"\",\"ename\":\""+list.get(i).getEname()
			           +"\",\"job\":\""+list.get(i).getJob()
			           +"\",\"mgr\":\""+list.get(i).getMgr()
			           +"\",\"hiredate\":\""+list.get(i).getHiredate()
			           +"\",\"sal\":\""+list.get(i).getSal()
			           +"\",\"comm\":\""+list.get(i).getComm()
			           +"\",\"deptno\":\""+list.get(i).getDeptno()+"\"}";
			            if(i!=list.size()-1) {
			                empJson+=",";
			            }
		}
		empJson += "]";
		try {
			response.getWriter().print(empJson);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="objMapper.ajax")
	public void ajaxObjMapper(HttpServletResponse response){
		
		ObjectMapper mapper = new ObjectMapper();
		List<EmpDto> list = empservice.getEmpList();
		
		try {
			response.getWriter().print(mapper.writeValueAsString(list));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="responseBody.ajax")
	public @ResponseBody List<EmpDto> ajaxResponseBody(){
	
		List<EmpDto> list = empservice.getEmpList();
		
		return list;  
	}
	
	
	@RequestMapping(value="json.ajax")
	public View jsonkosta(Model model){
		
		List<EmpDto> list = empservice.getEmpList();
		model.addAttribute("emp", list);
		
		return jsonview;  //private View jsonview 타입으로 리턴
	}
	
	
	///////////////////////////////////////////////////////////
	
	@RequestMapping(value="delete.ajax")
	
	public View delete(String empno,Model model) {
		empservice.deleteEmp(empno);
		List<EmpDto> list = empservice.getEmpList();
		model.addAttribute("emp", list);
		return jsonview;
	}
	
	
	@RequestMapping(value="update.ajax",method=RequestMethod.GET)
	public View update(String empno, Model model){
		model.addAttribute("emp",empservice.selectEmp(empno));
		
		return jsonview;  
	}
	
	@RequestMapping(value="update.ajax",method=RequestMethod.POST)
	public View update(EmpDto empdto, Model model){
		empservice.updateEmp(empdto);
		List<EmpDto> list = empservice.getEmpList();
		model.addAttribute("emp", list);
		
		return jsonview;  
	}
	
	@RequestMapping(value="insert.ajax",method=RequestMethod.POST)
	public View insert(EmpDto empdto, Model model){
		empservice.insertEmp(empdto);
		List<EmpDto> list = empservice.getEmpList();
		model.addAttribute("emp", list);		
		return jsonview;  
	}
	
	@RequestMapping(value="select.ajax",method=RequestMethod.POST)
	public View select(String empno, Model model){
		System.out.println("select");
		List<EmpDto> emp = empservice.selectEmp(empno);
		System.out.println(emp);
		/* List<EmpDto> list = empservice.getEmpList(); */
		model.addAttribute("emp", emp);		
		return jsonview;  
	}
	
	@RequestMapping(value="selectby.ajax",method=RequestMethod.POST)
	public View selectby(String selectoption, String empnum, Model model) throws ClassNotFoundException, SQLException{
		System.out.println("selectby.ajax");
		System.out.println(selectoption + empnum);
		if(selectoption.equals("Empno")) {
			List<EmpDto> emp = empservice.selectEmp(empnum);
			model.addAttribute("emp", emp);	
		//}else(selectoption.equals(""))
		//List<EmpDto> emp = empservice.selectEmp(empno);
		//System.out.println(emp);
		/* List<EmpDto> list = empservice.getEmpList(); */
		//model.addAttribute("emp", emp);		
	 
	}else if(selectoption.equals("Ename")) {
		List<EmpDto> emp = empservice.selectByEname(empnum);
		model.addAttribute("emp", emp);	
	}else {
		List<EmpDto> emp = empservice.selectByDeptno(empnum);
		model.addAttribute("emp", emp);	
	}
		return jsonview;
	}
//sortBy.ajax
	@RequestMapping(value="sortBy.ajax",method=RequestMethod.POST)
	public View sortBy(String sort, Model model) throws ClassNotFoundException, SQLException{
		System.out.println("sortBy.ajax");
		System.out.println(sort);
		if(sort.equals("Ename")) {
			List<EmpDto> emp = empservice.sortByEname();
			model.addAttribute("emp", emp);	
		//}else(selectoption.equals(""))
		//List<EmpDto> emp = empservice.selectEmp(empno);
		//System.out.println(emp);
		/* List<EmpDto> list = empservice.getEmpList(); */
		//model.addAttribute("emp", emp);		
	 
	} /*
		 * else if(selectoption.equals("Ename")) { List<EmpDto> emp =
		 * empservice.selectByEname(empnum); model.addAttribute("emp", emp); }else {
		 * List<EmpDto> emp = empservice.selectByDeptno(empnum);
		 * model.addAttribute("emp", emp); }
		 */
		return jsonview;
	}
}

