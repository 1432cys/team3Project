package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.EmpDao;
import dto.EmpDto;




@Service
public class EmpService {

	@Autowired
	private SqlSession sqlsession;
	
	public List<EmpDto> getEmpList(){
		List<EmpDto> result = new ArrayList<>();
		EmpDao dao = sqlsession.getMapper(EmpDao.class);
		result = dao.getEmpList();
		return result;
	}
	
	
	public int deleteEmp(String empno) {
		EmpDao empDao = sqlsession.getMapper(EmpDao.class);
		System.out.println(empDao);
		return empDao.deleteEmp(empno);
	}
	
	public int updateEmp(EmpDto empdto) {
		EmpDao empDao = sqlsession.getMapper(EmpDao.class);
		System.out.println(empDao);
		return empDao.updateEmp(empdto);
	}
	
	/*
	 	// 사원정보조회
	public List<Emp> selectByEmpno(int q) {	
		List<Emp> emp = null;	
		EmpDao empdao = sqlsession.getMapper(EmpDao.class);
		try {
			emp =empdao.selectByEmpno(q);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return emp;
	} 
	 
	 */
	public List<EmpDto> selectEmp(String empno) {
		List<EmpDto> emp = null;
		EmpDao empDao = sqlsession.getMapper(EmpDao.class);
		System.out.println(empDao);
		emp =  empDao.selectEmp(empno);
		return  emp;
	}
	
	public int insertEmp(EmpDto dto) {
		EmpDao empDao = sqlsession.getMapper(EmpDao.class);
		return  empDao.insertEmp(dto);
	}

	/*
	 public List<Emp> selectByDeptno(int q) {	
		List<Emp> emp = null;	
		EmpDao empdao = sqlsession.getMapper(EmpDao.class);
		try {
			emp =empdao.selectByDeptno(q);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return emp;
	} 
	 
	 */
	public List<EmpDto> selectByDeptno(String empnum) throws ClassNotFoundException, SQLException {
		List<EmpDto> emp = null;
		EmpDao empDao = sqlsession.getMapper(EmpDao.class);
		emp =empDao.selectByDeptno(empnum);
		return emp;
	}


	public List<EmpDto> selectByEname(String empnum) {
		List<EmpDto> emp = null;
		EmpDao empDao = sqlsession.getMapper(EmpDao.class);
		emp =empDao.selectByEname(empnum);
		return emp;
	}


	public List<EmpDto> sortByEname() {
		List<EmpDto> emp = null;
		EmpDao empDao = sqlsession.getMapper(EmpDao.class);
		emp =empDao.sortByEname();
		return emp;
	}
	
}
