package data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.Optional;
import java.net.URL;

@Component
public class ComicServices {
    public static final String STATUS_PRIVATE = "PRIVATE";
    public static final String STATUS_PUBLIC = "PUBLIC";

    public static final String SORT_NEW = "NEW";
    public static final String SORT_OLD = "OLD";
    public static final String SORT_ALPHABETICAL = "ALPHA";
    public static final String SORT_REV_ALPHABETICAL = "R_ALPHA";

    @Autowired
    ComicRepository comicRepository;

    @Autowired
    ChapterRepository chapterRepository;

    public void createComic(String title, String authorID, URL url, String publishedStatus){
        if(comicRepository.findByUrl(url) != null){
            System.out.println("Given URL is already in use.");
            return;
        }

        if(!publishedStatus.equals(STATUS_PRIVATE) && !publishedStatus.equals(STATUS_PUBLIC)){
            System.out.println("Invalid published status.");
            return;
        }

        Comic comic = new Comic(title, authorID, url);
        comic.publishedStatus = publishedStatus;
        comic.publishedDate = new Date();
        comic.lastUpdate = comic.publishedDate;
        comicRepository.save(comic);
    }

    public void deleteComic(String comicID, String userID){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        for (String chapID: comic.chapters) {
            deleteChapter(chapID, comicID, userID);
        }

        comicRepository.delete(comic);
    }

    public Comic getComicbyID(String comicID){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return null;
        }
        return optComic.get();
    }

    public Comic getComicbyURL(URL url, String userID){
        Comic comic = comicRepository.findByURL(url);

        if(comic == null){
            System.out.println("Comic doesn't exist.");
            return null;
        }

        if(comic.publishedStatus != STATUS_PUBLIC && comic.author != userID){
            System.out.println("Comic isn't public and user isn't author.");
            return null;
        }

        return comic;
    }

    public ArrayList<Comic> getUsersComics(String userID){
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userID));
        return comics;
    }

    /**
     *
     * @param sortType way comics will be sorted (uses public static final variables from this class labels SORT_...), defaults to newest update
     * @param amount number of comics you want returned
     * @param page how many sections of comic you want to skip over (0 gives you the first *amount* of comics, 1 gives you the next *amount*, etc)
     * @param tags list of tags you are searching for
     * @param genres list of genres you are searching for
     * @return
     */
    public ArrayList<Comic> advancedComicSearch(String sortType, int amount, int page, ArrayList<String> tags, ArrayList<String> genres){
        Sort sort;
        switch (sortType){
            case SORT_ALPHABETICAL:
                sort = Sort.by(Sort.Direction.ASC, "title");
                break;
            case SORT_REV_ALPHABETICAL:
                sort = Sort.by(Sort.Direction.DESC, "title");
                break;
            case SORT_OLD:
                sort = Sort.by(Sort.Direction.DESC, "lastUpdate");
                break;
            case SORT_NEW:
            default:
                sort = Sort.by(Sort.Direction.ASC, "lastUpdate");
                break;
        }

        Page<Comic> comics = comicRepository.findByTagsContainingAndGenresContainingAndPublishedStatus(tags, genres,
                STATUS_PUBLIC, PageRequest.of(page, amount, sort));
        return new ArrayList<>(comics.getContent());
    }

    public ArrayList<Comic> getRecentComics(int amount, int page){
        Comic publicComic = new Comic();
        publicComic.publishedStatus = STATUS_PUBLIC;
        Example<Comic> example = Example.of(publicComic, ExampleMatcher.matchingAll().withIgnorePaths("id", "title", "author",
                "description", "url", "publishedDate", "lastUpdate", "genres", "tags", "chapters"));
        Page<Comic> comics = comicRepository.findAll(example, PageRequest.of(page, amount, Sort.by(Sort.Direction.DESC, "lastUpdate")));
        return new ArrayList<>(comics.getContent());
    }

    public ArrayList<Comic> getComicsByTags(ArrayList<String> tags, int amount, int page){
        Page<Comic> comics = comicRepository.findByTagsContainingAndPublishedStatus(tags, STATUS_PUBLIC,
                PageRequest.of(page, amount, Sort.by(Sort.Direction.DESC, "lastUpdate")));
        return new ArrayList<>(comics.getContent());
    }

    public ArrayList<Comic> getComicsByGenres(ArrayList<String> genres, int amount, int page){
        Page<Comic> comics = comicRepository.findByGenresContainingAndPublishedStatus(genres, STATUS_PUBLIC,
                PageRequest.of(page, amount, Sort.by(Sort.Direction.DESC, "lastUpdate")));
        return new ArrayList<>(comics.getContent());
    }

    public ArrayList<Comic> findComicsByTitle(String title, int amount, int page){
        Page<Comic> comics = comicRepository.findByTitleIgnoreCaseAndPublishedStatus(title, STATUS_PUBLIC,
                PageRequest.of(page, amount, Sort.by(Sort.Direction.DESC, "lastUpdate")));
        return new ArrayList<>(comics.getContent());
    }

    public void createChapter(String comicID, String userID, URL url){
        if(chapterRepository.findByUrl(url) != null){
            System.out.println("Given URL is already in use.");
            return;
        }

        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        Chapter chapter = new Chapter(url);
        chapterRepository.save(chapter);

        comic.chapters.add(chapter.id);
        comicRepository.save(comic);
    }

    public void publishChapter(String chapID, String comicID, String userID){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        if(!comic.chapters.contains(chapID)){
            System.out.println("Comic does not contain chapter");
            return;
        }

        Optional<Chapter> optChapter = chapterRepository.findById(chapID);

        if(!optChapter.isPresent()){
            System.out.println("Chapter doesn't exist.");
            comic.chapters.remove(chapID);
            comicRepository.save(comic);
            return;
        }

        Chapter chapter = optChapter.get();

        if(!chapter.isDraft){
            System.out.println("Chapter is already published");
            return;
        }
        System.out.println("ssssss");
        chapter.isDraft = false;
        chapter.publishedDate = new Date();
        chapterRepository.save(chapter);
        comic.lastUpdate = chapter.publishedDate;
        comicRepository.save(comic);
    }

    public void deleteChapter(String chapID, String comicID, String userID){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        if(!comic.chapters.contains(chapID)){
            System.out.println("Comic does not contain chapter");
            return;
        }

        Optional<Chapter> optChapter = chapterRepository.findById(chapID);

        if(!optChapter.isPresent()){
            System.out.println("Chapter doesn't exist.");
            comic.chapters.remove(chapID);
            comicRepository.save(comic);
            return;
        }

        Chapter chapter = optChapter.get();

        comic.chapters.remove(chapID);
        comicRepository.save(comic);
        chapterRepository.delete(chapter);
    }

    public ArrayList<String> getChapters(String comicID){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return null;
        }

        Comic comic = optComic.get();
        return comic.chapters;
    }

    public void updateDescription(String comicID, String userID, String description){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        comic.description = description;
        comicRepository.save(comic);
    }

    public String getDescription(String comicID){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return null;
        }

        Comic comic = optComic.get();
        return comic.description;
    }

    public void changePublishedStatus(String comicID, String userID, String status){
        if(!status.equals(STATUS_PRIVATE) && !status.equals(STATUS_PUBLIC)){
            System.out.println("Invalid published status.");
            return;
        }

        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        comic.publishedStatus = status;
        comicRepository.save(comic);
    }

    public void updatePages(String chapID, String comicID, String userID, ArrayList<String> pages){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        if(!comic.chapters.contains(chapID)){
            System.out.println("Comic does not contain chapter");
            return;
        }

        Optional<Chapter> optChapter = chapterRepository.findById(chapID);

        if(!optChapter.isPresent()){
            System.out.println("Chapter doesn't exist.");
            comic.chapters.remove(chapID);
            comicRepository.save(comic);
            return;
        }

        Chapter chapter = optChapter.get();

        if(!chapter.isDraft){
            System.out.println("Chapter has been published and can't be changed");
            return;
        }

        chapter.pages = pages;
        chapterRepository.save(chapter);
    }

    public ArrayList<String> getPages(String chapID, String comicID){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return null;
        }

        Comic comic = optComic.get();

        if(!comic.chapters.contains(chapID)){
            System.out.println("Comic does not contain chapter");
            return null;
        }

        Optional<Chapter> optChapter = chapterRepository.findById(chapID);

        if(!optChapter.isPresent()){
            System.out.println("Chapter doesn't exist.");
            comic.chapters.remove(chapID);
            comicRepository.save(comic);
            return null;
        }

        Chapter chapter = optChapter.get();
        return chapter.pages;
    }

    public void updateTags(String comicID, String userID, ArrayList<String> tags){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        comic.tags = tags;
        comicRepository.save(comic);
    }

    public void updateGenress(String comicID, String userID, ArrayList<String> genres){
        Optional<Comic> optComic = comicRepository.findById(comicID);

        if(!optComic.isPresent()){
            System.out.println("Comic doesn't exist.");
            return;
        }

        Comic comic = optComic.get();

        if(!comic.author.equals(userID)){
            System.out.println("User is not author of comic.");
            return;
        }

        comic.genres = genres;
        comicRepository.save(comic);
    }
}
