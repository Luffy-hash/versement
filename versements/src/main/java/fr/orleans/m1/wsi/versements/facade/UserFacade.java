package fr.orleans.m1.wsi.versements.facade;

import fr.orleans.m1.wsi.versements.models.Utilisateur;
import org.springframework.stereotype.Service;

@Service
public interface UserFacade
{
    /**
     * inscription d'un utilisateur
     * @param utilisateur
     * @return
     */
    public Utilisateur registerUser (Utilisateur utilisateur);

    /**
     * connection d'un utilisateur
     * @param email
     * @param mdp
     * @return
     */
    public boolean loginUser (String email, String mdp);
}
