package data;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.net.URL;
import java.util.List;

@Repository
public interface ComicRepository extends MongoRepository<Comic, String>{
    public Page<Comic> findByTitleIgnoreCase(String title, Pageable pageable);
    public List<Comic> findByAuthor(String author);
    public Page<Comic> findByTagsContaining(List<String> tags, Pageable pageable);
    public Page<Comic> findByGenresContaining(List<String> genres, Pageable pageable);
    public Comic findByUrl(URL url);

    public Page<Comic> findByTitleIgnoreCaseAndPublishedStatus(String title, String publishedStatus, Pageable pageable);
    public Page<Comic> findByTitleMatchesRegexAndPublishedStatus(String regex, String publishedStatus, Pageable pageable);
    public Page<Comic> findByAuthorAndPublishedStatus(String author, String publishedStatus, Pageable pageable);
    public Page<Comic> findByTagsContainingAndPublishedStatus(List<String> tags, String publishedStatus, Pageable pageable);
    public Page<Comic> findByGenresContainingAndPublishedStatus(List<String> genres, String publishedStatus, Pageable pageable);

    public Page<Comic> findByTagsContainingAndGenresContainingAndPublishedStatus(List<String> tags, List<String> genres, String publishedStatus, Pageable pageable);

    long count();
}
