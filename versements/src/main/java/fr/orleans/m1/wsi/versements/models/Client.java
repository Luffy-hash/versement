package fr.orleans.m1.wsi.versements.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
public class Client
{

    @Id
    @GeneratedValue
    private Long id;

    private String name;
    private String firstName;
    private String jobs;
    private String phone;
    private String email;

}
