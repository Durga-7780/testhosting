package spring.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import spring.entity.CommissionDetails;
import spring.entity.Farmerdetails;
import spring.entity.MillBill;
import spring.entity.Milldetails;
import spring.entity.Registration;
import spring.repository.ComDetails;
import spring.repository.Datastore;
import spring.repository.Farmerdata;
import spring.repository.MillBilldata;
import spring.repository.MilldataInt;

@Service
@Transactional
public class ServiceClass {
	@Autowired
	public Datastore d;
	@Autowired
	public Farmerdata fdt;
	@Autowired
	public MilldataInt md;
	@Autowired
	public ComDetails cmd;
	@Autowired
	public MillBilldata mbill;
	
	public boolean registerdata(Registration reg)
	{
		d.save(reg);
		return true;
	}

	public String checklogin(Map<String, String> mp) {
		List<Registration> li=d.findByUsername(mp.get("username"));
		if(!li.isEmpty()&& !li.get(0).getUsername().equals("admin") && li.get(0).getPassword().equals(mp.get("password")) && li.get(0).getUsername().equals(mp.get("username")) && li.get(0).getAccepted()==1)
		{
			return "true";
		}
		else if(!li.isEmpty()&& li.get(0).getUsername().equals("admin") && li.get(0).getPassword().equals(mp.get("password")))
		{
		  return "admin";	
		}
		else
		return "false";
	}
	
	public boolean checkusername(String username)
	{
		List<Registration> li=d.findByUsername(username);
		if(!li.isEmpty())
		{
			return true;
		}
		return false;
	}
	
	public List<Registration> getAdmindata()
	{
		List<Registration> li=d.findAgentsByAccept();
		return li;
	}
	
	public String acceptadmin(String user)
	{
		List<Registration> reg=d.findByUsername(user);
		Registration r=reg.get(0);
		r.setAccepted(1);
		d.save(r);
		return "";
	}
	
	public String rejectadmin(String user)
	{
		d.deleteByUsername(user);
		return "";
	}
	
	public String getNameForDashboard(Map<String,String> mp)
	{
		 List<Registration> li=d.findByUsername(mp.get("username"));
		 if(li.isEmpty())
			 return null;
		 else
		 return li.get(0).getName();
	}
	public String addfarmer(Map<String,String> mp)
	{
		Farmerdetails fd=new Farmerdetails();
		fd.setFname(mp.get("fname"));
		fd.setFmobile(mp.get("fmobile"));
		fd.setFlocation(mp.get("flocation"));
		fd.setFbags(mp.get("fbags"));
		fd.setFvariety(mp.get("fvariety"));
		fdt.save(fd);
		return "success";
	}
	
	public List<Farmerdetails> getFarmerData()
	{
		return fdt.getFarmerdetails();
	}
	
	public List<Map<String,String>> getFarmerDetail()
	{
		List<Map<String,String>> m =new LinkedList<Map<String,String>>();
		List<Farmerdetails> li=fdt.getFarmerdetails();
		for(Farmerdetails f:li)
		{
			Map<String,String> mp =new HashMap<String,String>();
			mp.put("farmer", f.getFname());
			mp.put("bags", f.getFbags());
			mp.put("place", f.getFlocation());
			mp.put("mobile",f.getFmobile());
			mp.put("variety", f.getFvariety());
			m.add(mp);
		}
		return m;
	}
	
	public String settlefarmer(String m)
	{
		System.out.println("mobile "+m);
		List<Farmerdetails>li=fdt.findByFmobile1(m);
		Farmerdetails fd=li.get(0);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String formattedDate = formatter.format(new Date()); 
		System.out.println(formattedDate);
		fd.setDate(formattedDate);
		fd.setSetteled(1);
		fdt.save(fd);
		return "success";
	}
	
	public String rejectFarmer(String m)
	{
		List<Farmerdetails>li=fdt.findByFmobile1(m);
		System.out.println(li.get(0).getSno());
		fdt.deleteById(li.get(0).getSno());
		return "success";
	}
	public List<Milldetails> getMilldata()
	{
		return md.findAll();
	}
	public String addmilldata(Map<String,String> mp)
	{
		Milldetails mdata=new Milldetails();
		mdata.setMname(mp.get("mname"));
		mdata.setMmobile(mp.get("mmobile"));
		mdata.setMlocation(mp.get("mlocation"));
		md.save(mdata);
		return "success";
	}
	
//	public int todayTotalLoads()
//	{
//		int val=fdt.todayTotalLoads();
//		return val;
//	}
//	
//	public int todayTotalBags()
//	{
//		int val=fdt.todayTotalBags();
//		return val;
//	}

	public Map<String,String> getimagedata() {
		List<String> li1=fdt.totalbags();
		List<String> li2=fdt.items();
		Map<String,String> mp=new HashMap<String,String>();
		for(int i=0;i<li1.size();i++)
		{
			mp.put(li2.get(i), li1.get(i));
		}
		return mp;
	}
	
	public Map<String,String> getTodayGraph()
	{
		List<String> li1=fdt.totalloadingbags();
		List<String> li2=fdt.todaytotalitems();
		Map<String,String> mp=new HashMap<String,String>();
		for(int i=0;i<li1.size();i++)
		{
			mp.put(li2.get(i), li1.get(i));
		}
		return mp;
	}
	public Map<String,String> getCommissionDetails()
	{
		List<CommissionDetails>li= cmd.findAll();
		Map<String,String> ls=new HashMap<String,String>();
		for(int i=0;i<li.size();i++)
		{
			ls.put(li.get(i).getComname(),li.get(i).getComname());
		}
		return ls;
	}
	
	public String ComDetails(Map<String,String> m)
	{
		CommissionDetails cd=new CommissionDetails();
		cd.setComname(m.get("name"));
		cd.setMobile(m.get("mobile"));
		cd.setLocation(m.get("clocation"));
		cmd.save(cd);
		return "";
	}
	
	public Connection getJdbcCon() throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/farming","root","123456");
		return con;
	}
	public String savemillbilldata(Map<String,String>m) throws ClassNotFoundException, SQLException
	{
		MillBill mb=new MillBill();
		mb.setFarmername(m.get("farmer"));
		mb.setFarmerplace(m.get("farmerplace"));
		mb.setDate(m.get("dt"));
		mb.setBags(m.get("bag"));
		mb.setMillname(m.get("mill"));
		mb.setRate(m.get("amt"));
		mb.setVariety(m.get("item"));
		mb.setWeight(m.get("weights"));
		mb.setVehicle(m.get("vehicleno"));
		
		List<Farmerdetails> fm=fdt.findByFmobile1(m.get("mobile"));
		
		Connection con=getJdbcCon();
		Statement st=con.createStatement();
		
		String millname=(m.get("mill")).replaceAll(" ", "_");
		
		st.execute("CREATE TABLE IF NOT EXISTS `" + millname + "` AS SELECT date, vehicle, farmername, variety, bags, rate, weight, amount FROM mill_bill WHERE FALSE");	
		
		String modify="ALTER TABLE `"+millname+"`MODIFY `date` varchar(25), MODIFY `vehicle` VARCHAR(25), MODIFY `farmername` VARCHAR(40),\r\n"
				+ "MODIFY `variety` VARCHAR(25),\r\n"
				+ "MODIFY `bags` varchar(5),\r\n"
				+ "MODIFY `rate` varchar(7),\r\n"
				+ "MODIFY `weight` varchar(10),\r\n"
				+ "MODIFY `amount` varchar(20);";
		st.execute(modify);
		
		String sql = "ALTER TABLE `" + millname + "` ADD UNIQUE (date, vehicle,farmername, variety, bags, rate, weight, amount)";
		st.execute(sql);
		String query = "INSERT IGNORE INTO `" +millname+"` (farmername, variety, vehicle, weight, bags, rate, date, amount) " +
	               "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement p = con.prepareStatement(query);
		p.setString(1, m.get("farmer"));
		p.setString(2, m.get("item"));
		p.setString(3, m.get("vehicleno"));
		p.setString(4, m.get("weights"));
		p.setString(5, m.get("bag"));
		p.setString(6, m.get("amt"));
		p.setString(7, m.get("dt"));
		int amt=(int)((Integer.parseInt(m.get("weights"))-Integer.parseInt(m.get("bag")))/75)*(Integer.parseInt(m.get("amt")));
		
		mb.setAmount(amt+"");
		p.setString(8, amt+"");
		p.executeUpdate();
		mbill.save(mb);
		
		if(!m.get("comm").equals("") || m.get("comm")!=null)
		{
		String com=m.get("comm").replace(" ", "_");
		
		st.execute("CREATE TABLE IF NOT EXISTS `" + com + "` (sno int primary key auto_increment,date varchar(20),fname varchar(30),fbags varchar(5),fplace varchar(20),mobile varchar(12), variety varchar(8),rate varchar(10),weight varchar(10),amount varchar(10))");	
		
		String place=fm.get(0).getFlocation();
		String mobile=m.get("mobile");
		
		String comquery = "INSERT IGNORE INTO `" + com + "` (date, fname, fbags, fplace, mobile, variety, rate, weight, amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement pp = con.prepareStatement(comquery);
		pp.setString(1, m.get("dt"));
		pp.setString(2, m.get("farmer"));
		pp.setString(3, m.get("bag"));
		pp.setString(4, place);
		pp.setString(5, mobile);
		pp.setString(6, m.get("item"));
		pp.setString(7, m.get("amt"));
		pp.setString(8, m.get("weights"));
		pp.setString(9, amt+"");
		pp.executeUpdate();
		}
		if(fm.size()>0) {
			fm.get(0).setWeight(m.get("weights"));
			fm.get(0).setLoaddate(m.get("dt"));
			fm.get(0).setDate(m.get("dt"));
			fdt.save(fm.get(0));
		}
		return "";
	}
	
	public List<LinkedHashMap<String,String>> getSelectedMilldata(Map<String,String> m)
	{
		List<MillBill> li=mbill.findByMillnameAndDateBetween(m.get("mill"),m.get("from"),m.get("to"));
		List<LinkedHashMap<String,String>> mp1=new LinkedList<LinkedHashMap<String,String>>();
		for(int i=0;i<li.size();i++)
		{
			LinkedHashMap<String,String> mp=new LinkedHashMap<String,String>();
			mp.put("sno",(i+1)+"");
			mp.put("date", li.get(i).getDate());
			mp.put("vehicle",li.get(i).getVehicle());
			mp.put("farmername",li.get(i).getFarmername());
			mp.put("variety", li.get(i).getVariety());
			mp.put("bags", li.get(i).getBags());
			mp.put("rate", li.get(i).getRate());
			mp.put("weight", li.get(i).getWeight());
			mp.put("amt", li.get(i).getAmount());
			mp1.add(mp);
		}
		return mp1;
	}
	public Map<String,String> getFarmerBill(Map<String,String> m)
	{
		List<Farmerdetails> li=fdt.findByFmobile(m.get("mobile"));
		Map<String,String> mp=new HashMap<String,String>();
		for(Farmerdetails f:li)
		{
			mp.put("name", f.getFname());
			mp.put("mobile", f.getFmobile());
			mp.put("place", f.getFlocation());
			mp.put("variety", f.getFvariety());
			mp.put("bags", f.getFbags());
			mp.put("weight", f.getWeight());
			mp.put("date", f.getLoaddate());
		}
		return mp;
	}

	public Map<String, String> getFarmerDetailsForMillBill(Map<String, String> m) {
		
		List<Farmerdetails>li= fdt.findByFmobile1(m.get("mobile"));
		 Map<String, String> mp=new  HashMap<String, String>();
		 for(Farmerdetails f:li) {
		    mp.put("name", f.getFname());
		    mp.put("location", f.getFlocation());
		    mp.put("bags", f.getFbags());
		    mp.put("variety", f.getFvariety());
		 }
		return mp;
	}

	public Map<String, String> getEditFarmerdetails(String mob) {
		List<Farmerdetails> li=fdt.findByFmobileEditform(mob);
		Map<String,String> mp=new HashMap<String,String>();
	
		if(li.size()>0) {
		for(Farmerdetails f:li)
		{
			mp.put("name", f.getFname());
			mp.put("bag", f.getFbags());
			mp.put("place", f.getFlocation());
			mp.put("mobile", f.getFmobile());
			mp.put("variety", f.getFvariety());
		}
		return mp;
		}
		return null;
	}

	public String updateFarmerdata(Map<String, String> m) {
		List<Farmerdetails>li=fdt.findByFmobileEditform(m.get("mobile"));
		Farmerdetails f=li.get(0);
		if(li.size()>0)
		{
			f.setFname(m.get("name"));
			f.setFbags(m.get("bag"));
			f.setFvariety(m.get("variety"));
			f.setFlocation(m.get("place"));
			f.setFmobile(m.get("chmobile"));
			fdt.save(f);
			return "success";
		}
		return "failed";
	}

	public void modifyFarmerdetails(Map<String, String> m) throws ClassNotFoundException, SQLException {
		Connection con=getJdbcCon();
		Statement st=con.createStatement();
		
		List<CommissionDetails> li=cmd.findAll();
		if(li.size()>0) {
			for(CommissionDetails c:li)
			{
				String comname=c.getComname().replace(" ", "_");
				try (ResultSet rs = st.executeQuery("SELECT * FROM " + comname + " WHERE fmobile='" + m.get("mobile") + "'")) {
			        if (rs.next()) {
			            int rowsAffected = st.executeUpdate("UPDATE " + comname + " SET rate='" + m.get("cost") + "', amount='" + m.get("amt") + "' WHERE fmobile='" + m.get("mobile") + "'");
			            System.out.println(rowsAffected + " rows updated.");
			            break;
			        }
			    } catch (SQLException e) {
			        e.printStackTrace(); 
			    }
			}
		}
		
	}

	public List<LinkedHashMap<String, String>> displayComdetails(Map<String, String> m) throws ClassNotFoundException, SQLException {
		Connection con=getJdbcCon();
		Statement st=con.createStatement();
		
		ResultSet rs=st.executeQuery("Select date,fname,fbags,variety,rate,weight,amount from "+m.get("comm")+" where date between '"+m.get("from")+"' and '"+m.get("to")+"'");
		List<LinkedHashMap<String,String>> lm=new ArrayList<LinkedHashMap<String,String>>();
		int i=0;
		while(rs.next())
		{
			
			LinkedHashMap<String,String> mp=new LinkedHashMap<String,String>();
			mp.put("Sno",(i+1)+"");
		    mp.put("Date", rs.getString("date"));
		    mp.put("Farmer_Name", rs.getString("fname"));
		    mp.put("Bags", rs.getString("fbags"));
//		    mp.put("fplace", rs.getString("fplace"));
//		    mp.put("mobile", rs.getString("mobile"));
		    mp.put("Variety", rs.getString("variety"));
		    mp.put("Rate", rs.getString("rate"));
		    mp.put("Weight", rs.getString("weight"));
		    mp.put("Amount", rs.getString("amount"));
			i++;
			lm.add(mp);
		}
		
		return lm;
	}
}
