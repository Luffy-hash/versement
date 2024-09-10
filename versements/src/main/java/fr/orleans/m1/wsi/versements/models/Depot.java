package fr.orleans.m1.wsi.versements.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class depot
{

    @Id
    private Long id;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}
