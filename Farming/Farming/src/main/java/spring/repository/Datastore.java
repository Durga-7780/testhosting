package spring.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import spring.entity.Registration;

public interface Datastore extends JpaRepository<Registration,Long> {
	public List<Registration> findByUsername(String name);
	
	@Query(value = "SELECT * FROM registration WHERE accepted = 0", nativeQuery = true)
    List<Registration> findAgentsByAccept();
	
	public void deleteByUsername(String user);
}

