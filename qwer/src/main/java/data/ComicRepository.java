package data;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.net.URL;
import java.util.List;

@Repository
public interface ComicRepository extends MongoRepository<Comic, String>{
    public List<Comic> findByTitle(String title);
    public List<Comic> findByAuthor(String author);
    public List<Comic> findByTagsContaining(List<String> tags);
    public List<Comic> findByGenresContaining(List<String> genres);
    public Comic findByUrl(URL url);
}
