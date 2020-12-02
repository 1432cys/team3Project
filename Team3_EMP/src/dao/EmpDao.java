package dao;

import java.util.List;

import dto.EmpDto;
import dto.EmpList;

public interface EmpDao {
	 List<EmpDto> getEmpList();
	 int deleteEmp(String empno);
	 int updateEmp(EmpDto dto);
	 List<EmpDto> selectEmp(String empno);
	 int insertEmp(EmpDto dto);
	List<EmpDto> selectByDeptno(String empnum);
	List<EmpDto> selectByEname(String empnum);
	List<EmpDto> sortByEname();   
}
