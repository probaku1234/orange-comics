package data;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PremadeCharacterRepository extends MongoRepository<PremadeCharacter, String> {
}
