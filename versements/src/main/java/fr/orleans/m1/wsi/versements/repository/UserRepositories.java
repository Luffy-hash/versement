package fr.orleans.m1.wsi.versements.repository;

import fr.orleans.m1.wsi.versements.models.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepositories extends JpaRepository<Utilisateur, Long> {
    public Utilisateur findUserByEmail(String email);
}
