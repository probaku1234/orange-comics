package data;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PremadeCharacterRepository extends MongoRepository<PremadeCharacter, String> {
    public List<PremadeCharacter> findByIsPublicIsTrue();
}
