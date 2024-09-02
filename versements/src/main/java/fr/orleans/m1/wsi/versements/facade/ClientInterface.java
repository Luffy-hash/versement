package fr.orleans.m1.wsi.versements.facade;

import fr.orleans.m1.wsi.versements.models.Client;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface ClientInterface
{
    /**
     *
     * @param client
     * @return
     */
    Client addClient(Client client);

    /**
     *
     * @param idClient
     * @param client
     * @return
     */
    Client updateClient (Long idClient, Client client);

    /**
     *
     * @param idClient
     * @param client
     */
    void deleteClient (Long idClient, Client client);

    /**
     *
     * @return
     */
    Optional<List<Client>> myClients();

    /**
     *
     * @param idClient
     * @param client
     * @return
     */
    Client myUniqueClient(Long idClient, Client client);

    // rechercher un client
}
