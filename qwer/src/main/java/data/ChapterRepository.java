package data;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.net.URL;

@Repository
public interface ChapterRepository extends MongoRepository<Chapter, String>{
    public Chapter findByUrl(URL url);
}
