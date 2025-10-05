package spring.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import spring.entity.Farmerdetails;

public interface Farmerdata extends JpaRepository<Farmerdetails,Long>{
	
	@Query(value="Select * from farmerdetails where setteled=0",nativeQuery=true)
	public List<Farmerdetails> getFarmerdetails();
	@Query(value="Select * from farmerdetails where setteled=1 and fmobile=:mob",nativeQuery=true)
	public List<Farmerdetails> findByFmobile(@Param("mob")String mob);
	@Query(value="Select * from farmerdetails where setteled=0 and fmobile=:mob",nativeQuery=true)
	public List<Farmerdetails> findByFmobile1(@Param("mob")String mob);
	@Query(value="select COALESCE(fvariety,0) from farmerdetails where setteled=0 group by fvariety",nativeQuery=true)
	public List<String> items();
	@Query(value="select COALESCE(sum(fbags),0) from farmerdetails where setteled=0 group by fvariety",nativeQuery=true)
	public List<String> totalbags();
	
	@Query(value="SELECT COALESCE(sum(fbags),0) FROM farmerdetails WHERE date = CURDATE() && setteled=1 group by fvariety",nativeQuery=true)
	public List<String> totalloadingbags();
	@Query(value="SELECT COALESCE(fvariety,0) FROM farmerdetails WHERE date = CURDATE() && setteled=1 group by fvariety",nativeQuery=true)
	public List<String> todaytotalitems();
	
	@Query(value="Select * from farmerdetails where fmobile=:mob",nativeQuery=true)
	public List<Farmerdetails> findByFmobileEditform(@Param("mob")String mob);
}