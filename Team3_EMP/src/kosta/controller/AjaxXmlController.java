package kosta.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.EmpDto;
import dto.EmpList;
import service.EmpService;

@Controller
public class AjaxXmlController {
	
	@Autowired
	private EmpService empsevice;
	
	@RequestMapping(value="xmllist.ajax")
	@ResponseBody
	public EmpList lisxml(){
		return getEmplist();
	}
	
	private EmpList getEmplist() {
		
		List<EmpDto> list = empsevice.getEmpList();
		return new EmpList(list);
		
	}
	
	
}
