package fr.orleans.m1.wsi.versements.controllers;

import fr.orleans.m1.wsi.versements.facade.UserFacade;
import fr.orleans.m1.wsi.versements.models.Utilisateur;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/versement")
public class UserController
{
    @Autowired
    private UserFacade userFacade;

    @PostMapping("/registration")
    public ResponseEntity<?> register(@RequestBody Utilisateur utilisateur){
        try{
            Utilisateur registerUtilisateur = userFacade.registerUser(utilisateur);
            return new ResponseEntity<>(registerUtilisateur, HttpStatus.CREATED);
        }
        catch (Exception e){
            return new ResponseEntity<>("Vous n'êtes pas eligible à créer un compte", HttpStatus.UNAUTHORIZED);
        }
    }

    @GetMapping("/login")
    public ResponseEntity<?> loginUser(@RequestParam String email, @RequestParam String mdp){
        try {
            Boolean isConnected = userFacade.loginUser(email, mdp);
            return new ResponseEntity<>(isConnected, HttpStatus.OK);
        }
        catch (Exception e){
            return new ResponseEntity<>(false, HttpStatus.UNAUTHORIZED);
        }
    }


}
