package com.petcare.service;

import java.util.List;
import com.petcare.domain.Pet;

public interface PetService {
	void signupPS(Pet pet);
	List<Pet> getPetinfoS(String id);
	Pet getOnePetS(String petseq);
	void updatePS(Pet pet);
	void deletePS(String petseq);
}