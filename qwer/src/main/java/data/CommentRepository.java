package data;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends MongoRepository<Comment, String> {
    public Page<Comment> findByUser(String user, Pageable pageable);
    public Page<Comment> findByComic(String comic, Pageable pageable);
    public Page<Comment> findByMessageGroup(String messageGroup, Pageable pageable);
}
