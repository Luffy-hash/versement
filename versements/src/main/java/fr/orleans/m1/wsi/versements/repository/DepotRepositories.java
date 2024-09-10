package fr.orleans.m1.wsi.versements.repository;

import fr.orleans.m1.wsi.versements.models.Client;
import fr.orleans.m1.wsi.versements.models.Depot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DepotRepositories extends JpaRepository<Depot, Long>
{

    List<Depot> findDepotByClient(Client client);

}
