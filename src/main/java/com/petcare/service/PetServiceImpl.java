package com.petcare.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.petcare.domain.Pet;
import com.petcare.mapper.PetMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class PetServiceImpl implements PetService {
	private PetMapper pmapper;	
	@Override
	public void signupPS(Pet pet) {
		pmapper.signupP(pet);
	}
	@Override
	public List<Pet> getPetinfoS(String id) {
		return pmapper.getPetinfo(id);
	}
	@Override
	public Pet getOnePetS(String petseq) {
		return pmapper.getOnePet(petseq);
	}
	@Override
	public void updatePS(Pet pet) {
		pmapper.updateP(pet);
	}
	@Override
	public void deletePS(String petseq) {
		pmapper.deleteP(petseq);
	}
}