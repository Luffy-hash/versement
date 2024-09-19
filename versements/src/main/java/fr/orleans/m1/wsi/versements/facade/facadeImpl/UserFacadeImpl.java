package fr.orleans.m1.wsi.versements.facade.facadeImpl;

import fr.orleans.m1.wsi.versements.facade.UserFacade;
import fr.orleans.m1.wsi.versements.models.Utilisateur;
import fr.orleans.m1.wsi.versements.repository.UserRepositories;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserFacadeImpl implements UserFacade
{
    @Autowired
    private UserRepositories userRepository;

    /**
     *
     * @param utilisateur
     * @return
     */
    @Override
    public Utilisateur registerUser(Utilisateur utilisateur) {
        Optional<Utilisateur> useropt = Optional.ofNullable(userRepository.findUserByEmail(utilisateur.getEmail()));
        if (useropt.isPresent()){ throw new RuntimeException("Cet utilisateur est déjà inscrit"); }
        else {
            return userRepository.save(utilisateur);
        }
    }

    @Override
    public boolean loginUser(String email, String mdp) {
        Optional<Utilisateur> useropt = Optional.ofNullable(userRepository.findUserByEmail(email));
        return useropt.isPresent() && useropt.get().getMdp().equals(mdp);
    }
}
