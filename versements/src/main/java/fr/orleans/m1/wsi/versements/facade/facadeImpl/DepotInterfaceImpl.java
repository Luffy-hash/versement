package fr.orleans.m1.wsi.versements.facade.facadeImpl;

import fr.orleans.m1.wsi.versements.facade.DepotInterface;
import fr.orleans.m1.wsi.versements.models.Client;
import fr.orleans.m1.wsi.versements.models.Depot;
import fr.orleans.m1.wsi.versements.repository.DepotRepositories;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepotInterfaceImpl implements DepotInterface
{
    @Autowired
    private DepotRepositories depotRepositories;

    @Override
    public List<Depot> myDepot(Client client) {
        // chercher toutes les enregistrements
        List<Depot> mesDepots = depotRepositories.findDepotByClient(client);
        // verifie s'il en existe
        if (!mesDepots.isEmpty()){
            // si oui on renvoie la liste
            return mesDepots;
        }
        // sinon on leve une exception
        throw new RuntimeException("Pas de versement pour l'instant.");
    }
}
