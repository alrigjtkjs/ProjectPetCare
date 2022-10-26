package com.petcare.mapper;

import java.util.List;
import com.petcare.domain.Pet;

public interface PetMapper {	
	void signupP(Pet pet);//C
	List<Pet> getPetinfo(String id);//R
	Pet getOnePet(String petseq);
	void updateP(Pet pet);//U
	void deleteP(String petseq);//D
}