package fr.orleans.m1.wsi.versements.facade;

import fr.orleans.m1.wsi.versements.models.Client;
import fr.orleans.m1.wsi.versements.models.Depot;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface DepotInterface
{
    /**
     *
     * @return List<Depot>
     */
    public List<Depot> myDepot(Client client);
}
