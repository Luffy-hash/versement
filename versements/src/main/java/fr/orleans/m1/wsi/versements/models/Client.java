package fr.orleans.m1.wsi.versements.models;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
@Entity
public class Client
{

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;
    private String firstName;
    private String jobs;
    private String phone;
    private String image;

    @Column(unique = true)
    private String email;

    @OneToMany(mappedBy = "client")
    @JsonManagedReference
    private List<Depot> depot;

}
