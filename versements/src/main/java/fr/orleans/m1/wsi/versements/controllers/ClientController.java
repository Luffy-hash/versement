package fr.orleans.m1.wsi.versements.controllers;

import fr.orleans.m1.wsi.versements.facade.ClientInterface;
import fr.orleans.m1.wsi.versements.models.Client;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@CrossOrigin(origins = "http://localhost:8080", allowedHeaders = "*")
@RestController
@RequestMapping("/api/versement")
public class ClientController
{

    private ClientInterface clientInterface;

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

}
