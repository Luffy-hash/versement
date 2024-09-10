package fr.orleans.m1.wsi.versements.facade.facadeImpl;

import fr.orleans.m1.wsi.versements.facade.ClientInterface;
import fr.orleans.m1.wsi.versements.models.Client;
import fr.orleans.m1.wsi.versements.repository.ClientRepositories;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ClientInterfaceImpl implements ClientInterface
{
    // mon repositorie
    @Autowired
    private ClientRepositories clientRepositories;

    @Override
    public Client addClient(Client client) {
        // verifions si ce utilisateur existe déjà
        Optional<Client> isExistingClient = clientRepositories.findClientByEmail(client.getEmail());
        // s'il existe on leve une exception
        if(isExistingClient.isPresent()){ throw new RuntimeException("Cet client existe déjà!"); }
        // sinon on enregistre l'utilsateur
        return clientRepositories.save(client);
    }

    @Override
    public Client updateClient(Long idClient, Client client) {
        return null;
    }

    @Override
    public void deleteClient(Long idClient, Client client) {

    }

    @Override
    public Optional<List<Client>> myClients() {
        // on recupère tous nos clients enregistrés
        List<Client> clients = clientRepositories.findAll();
        // on test pour voir si ma liste est vide sinon on renvoie une listes pleine
        return clients.isEmpty() ? Optional.empty() : Optional.of(clients);

    }

    @Override
    public Client myUniqueClient(String emailClient) {
        // recupérer le client
        Optional<Client> optionalClient = clientRepositories.findClientByEmail(emailClient);
        // tester s'il existe dans ma base de donnée
        if (optionalClient.isPresent()){
            // si oui renvoie le client
            return optionalClient.get();
        }
        // sinon retourne une exception
        throw new RuntimeException("Cet client n'existe pas");
    }
}
