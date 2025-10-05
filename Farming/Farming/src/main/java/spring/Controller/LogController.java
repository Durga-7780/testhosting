package spring.Controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import spring.entity.Farmerdetails;
import spring.entity.Milldetails;
import spring.entity.Registration;
import spring.service.ServiceClass;

@Controller
public class LogController {
	
	@Autowired
	public ServiceClass s;
	@GetMapping("/")
	public String login()
	{
		return "login";
	}
	@GetMapping("/login")
	public String log(HttpSession ses)
	{
		ses.setAttribute("username", "");
		ses.setAttribute("name","");
		return "login";
	}
	
	@GetMapping("/registerPage")
	public String register()
	{
		 return "registerjsp";
	}
	@GetMapping("/regi")
	public String regi()
	{
		 return "register";
	}
	@GetMapping("/other")
	String samplepage()
	{
		return "/Login/login";
	}
	@PostMapping("/saveregdata")
	public @ResponseBody Map<String,String> savereg(@RequestBody Map<String,String> mp)
	{
		Registration reg=new Registration();
		reg.setName(mp.get("empname"));
		reg.setMobile(mp.get("mobile"));
		reg.setUsername(mp.get("user"));
		reg.setPassword(mp.get("pass"));
		if(mp.get("user").equals("admin"))
			reg.setAccepted(1);
		s.registerdata(reg);
		
		Map<String,String> op=new HashMap<String,String>();
		op.put("messg","login");
		return op;
	}
	
	@PostMapping("/checklogindata")
	public @ResponseBody Map<String,String> checklogdata(@RequestBody Map<String,String> mp, HttpSession session)
	{
		Map<String,String> obj=new HashMap<String,String>();
		String op=s.checklogin(mp);
		String name=s.getNameForDashboard(mp);
		if(op.equals("true"))
		{
		  obj.put("messg", "success");
		  session.setAttribute("name",name);
		  session.setAttribute("username", mp.get("username"));
		  return obj;
		}
		else if(op.equals("admin"))
		{
			obj.put("messg", "admin");
			session.setAttribute("username", mp.get("username"));
			session.setAttribute("name",name);
			return obj;
		}
		obj.put("messg", "failed");
		return obj;
	}
	
	@PostMapping("/checkusername")
	public @ResponseBody boolean checkusername(@RequestBody Map<String,String> mp)
	{
		if(s.checkusername(mp.get("id")))
		 return true;
		return false;
	}
	
	@GetMapping("getAdmindata")
	public String getAdmindata(Model m,HttpSession session)
	{
		if(session.getAttribute("username")!="") {
			List<Registration> obj=s.getAdmindata();
			m.addAttribute("data",obj);
			return "adminpage";
		}
		return "login";
	}
	
	@GetMapping("/index")
	String index()
	{
		return "/adminpage/dist/dashboard/index";
	}
	
	@GetMapping("/dashboard")
	public String dash(HttpSession ses,Model m)
	{
		if(ses.getAttribute("username") != null && !ses.getAttribute("username").equals("")) {
			
		  m.addAttribute("name",ses.getAttribute("name"));
		  m.addAttribute("username",ses.getAttribute("username"));
		  
		  List<Milldetails>md=s.getMilldata();
		  m.addAttribute("milldata",md);
		  
		  List<Farmerdetails> li=s.getFarmerData();
		  m.addAttribute("lidata",li);
		  return "dashboard";
		}
		return "login";
	}
	
	@GetMapping("getFarmerDetail")
	public @ResponseBody List<Map<String,String>> getFarmerDetails()
	{
		List<Map<String,String>> mp=s.getFarmerDetail();
		return mp;
	}
	
	@PostMapping("/addmill")
	public @ResponseBody Map<String,String> addmill(@RequestBody Map<String,String>mp)
	{
		s.addmilldata(mp);
		Map<String,String> m=new HashMap<String,String>();
		m.put("messg", "success");
		return m;
	}
	
	@PostMapping("/acceptadmin")
	public @ResponseBody String acceptadmin(@RequestBody Map<String,String>mp)
	{
		s.acceptadmin(mp.get("user"));
		return "success";
	}
	
	@PostMapping("/rejectadmin")
	public @ResponseBody String rejectadmin(@RequestBody Map<String,String>mp)
	{
		s.rejectadmin(mp.get("user"));
		return "success";
	}
	@PostMapping("/addfarmer")
	public @ResponseBody Map<String,String> farmerdetail(@RequestBody Map<String,String> mp)
	{
		Map<String,String>m=new HashMap<String,String>();
		m.put("messge", "success");
		s.addfarmer(mp);
		return m;
	}
	
	@PostMapping("settlefarmer")
	public @ResponseBody Map<String,String> settlefarmer(@RequestBody Map<String,String>mp)
	{
		Map<String,String>m=new HashMap<String,String>();
		m.put("messge", "success");
		s.settlefarmer(mp.get("mobile"));
		return m;
	}
	@PostMapping("/rejectFarmer")
	public @ResponseBody Map<String,String> rejectfarmer(@RequestBody Map<String,String>mp)
	{
		Map<String,String>m=new HashMap<String,String>();
		m.put("messge", "success");
		s.rejectFarmer(mp.get("mobile"));
		return m;
	}
	@GetMapping("imagedata")
	public @ResponseBody Map<String,String> imagedata()
	{
		return s.getimagedata();
	}
	
	@GetMapping("getTodayGraph")
	public @ResponseBody Map<String,String> getTodayGraph()
	{
		return s.getTodayGraph();
	}
	
	@PostMapping("getSelectedMilldata")
	public @ResponseBody List<LinkedHashMap<String,String>> getSelectedMilldata(@RequestBody Map<String,String> m)
	{	
		List<LinkedHashMap<String,String>> mp=s.getSelectedMilldata(m);
		return mp;
	}
	@GetMapping("ComDetails")
	public @ResponseBody Map<String,String> getCommissionDetails()
	{
		return s.getCommissionDetails();
	}
	
	@PostMapping("saveComDetails")
	public @ResponseBody String saveComdetails(@RequestBody Map<String,String> m)
	{ 
		s.ComDetails(m);
		return "success";
	}
	@PostMapping("savemillbilldata")
	public @ResponseBody Map<String,String> savemillbilldata(@RequestBody Map<String,String> m) throws ClassNotFoundException, SQLException
	{
		s.savemillbilldata(m);
		Map<String,String> mp=new HashMap<String,String>();
		mp.put("messg", "success");
		return mp;
	}
	@PostMapping("getFarmerBill")
	public @ResponseBody Map<String,String> getFarmerBill(@RequestBody Map<String,String> m)
	{
		Map<String,String> mmp=s.getFarmerBill(m);
		return mmp;
	}
	@PostMapping("getFarmerDetailsForMillBill")
	public @ResponseBody Map<String,String> getFarmerDetailsForMillBill(@RequestBody Map<String,String>m)
	{
		Map<String,String>mp=s.getFarmerDetailsForMillBill(m);
		return mp;
	}
	@PostMapping("getEditFarmerdetails")
	public @ResponseBody Map<String,String> getEditFarmerdetails(@RequestBody Map<String,String>m)
	{
		Map<String,String> mp=s.getEditFarmerdetails(m.get("mobile"));
		return mp;
	}
	@PostMapping("updateFarmerdata")
	public @ResponseBody Map<String,String> updateFarmerdata(@RequestBody Map<String,String>m)
	{
		String me=s.updateFarmerdata(m);
		Map<String,String> mm=new HashMap<String,String>();
		mm.put("messg", me);
		return mm;
	}
	@PostMapping("modifyFarmerdetails")
	public @ResponseBody String modifyFarmerdetails(@RequestBody Map<String,String> m) throws ClassNotFoundException, SQLException
	{
		s.modifyFarmerdetails(m);
		return "";
	}
	@PostMapping("displayComdetails")
	public @ResponseBody List<LinkedHashMap<String,String>> displayComdetails(@RequestBody Map<String,String> m) throws ClassNotFoundException, SQLException
	{
		List<LinkedHashMap<String,String>> mp=s.displayComdetails(m);
		return mp;
	}
}
