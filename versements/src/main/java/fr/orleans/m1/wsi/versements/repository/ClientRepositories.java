package fr.orleans.m1.wsi.versements.repository;

import fr.orleans.m1.wsi.versements.models.Client;
import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Repository
public interface ClientRepositories extends JpaRepository<Client, Long>
{
    Optional<Client> findClientByEmail(String email);

}
