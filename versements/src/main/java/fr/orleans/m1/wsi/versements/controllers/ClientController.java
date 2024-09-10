package fr.orleans.m1.wsi.versements.controllers;

import fr.orleans.m1.wsi.versements.facade.ClientInterface;
import fr.orleans.m1.wsi.versements.facade.DepotInterface;
import fr.orleans.m1.wsi.versements.models.Client;
import fr.orleans.m1.wsi.versements.models.Depot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@CrossOrigin(origins = "http://localhost:8080")
@RestController
@RequestMapping("/api/versement/client")
public class ClientController
{
    @Autowired
    private ClientInterface clientInterface;
    @Autowired
    private DepotInterface depotInterface;

    @PostMapping("/add-client")
    public ResponseEntity<?> clientAdding(@RequestBody Client client){
        try{
            Client newClient = clientInterface.addClient(client);
            return new ResponseEntity<>(newClient, HttpStatus.CREATED);
        }
        catch (RuntimeException exception){
            return new ResponseEntity<>(exception.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/mes-clients")
    public ResponseEntity<?> getClients(){
        Optional<List<Client>> clientLists = clientInterface.myClients();
        if (clientLists.isPresent()){ return new ResponseEntity<>(clientLists.get(), HttpStatus.OK); }
        else { return new ResponseEntity<>("Pas de client trouvé!", HttpStatus.NOT_FOUND); }
    }

    @GetMapping("/{emailClient}")
    public ResponseEntity<?> myClient(@PathVariable String emailClient){
        Optional<Client> clientOptional = Optional.ofNullable(clientInterface.myUniqueClient(emailClient));
        if (clientOptional.isPresent()){ return new ResponseEntity<>(clientOptional.get(), HttpStatus.OK);}
        else { return new ResponseEntity<>("Pas de client trouvé!", HttpStatus.NOT_FOUND); }
    }

    // listes de tous les versement d'un client
    @GetMapping("/{emailClient}/versements")
    public ResponseEntity<?> depotLieAUnClient(@PathVariable String emailClient){
        // on cherche le client correspondant
        Optional<Client> clientOptional = Optional.ofNullable(clientInterface.myUniqueClient(emailClient));
        // si client existe alors on renvoie la liste de ces versements
        if (clientOptional.isPresent()){
            Optional<List<Depot>> listDepotOptional = Optional.ofNullable(depotInterface.myDepot(clientOptional.get()));
            if (listDepotOptional.isPresent()){ return new ResponseEntity<>(listDepotOptional.get(), HttpStatus.OK);}
            else { return new ResponseEntity<>("Pas de versement actuelle;.", HttpStatus.NOT_FOUND);}
        }
        // sinon on leve une exception
        else { return new ResponseEntity<>("Pas de client trouvé!", HttpStatus.NOT_FOUND); }
    }

}
