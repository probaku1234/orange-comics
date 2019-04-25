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
    public static String STATUS_PRIVATE = "PRIVATE";
    public static String STATUS_UNLISTED = "UNLISTED";
    public static String STATUS_PUBLIC = "PUBLIC";

    @Autowired
    ComicRepository comicRepository;

    @Autowired
    ChapterRepository chapterRepository;

    public void createComic(String title, String authorID, URL url, String publishedStatus){
        if(comicRepository.findByURL(url) != null){
            System.out.println("Given URL is already in use.");
            return;
        }

        if(!publishedStatus.equals(STATUS_PRIVATE) && !publishedStatus.equals(STATUS_UNLISTED) &&
                !publishedStatus.equals(STATUS_PUBLIC)){
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

    public ArrayList<String> getUsersComics(String userID){
        ArrayList<Comic> comics = new ArrayList<>(comicRepository.findByAuthor(userID));
        ArrayList<String> comicIDs = new ArrayList<>();
        for (Comic comic : comics) {
            comicIDs.add(comic.id);
        }
        return comicIDs;
    }

    public ArrayList<Comic> getRecentComics(int amount){
        Comic publicComic = new Comic();
        publicComic.publishedStatus = STATUS_PUBLIC;
        Example<Comic> example = Example.of(publicComic, ExampleMatcher.matchingAll().withIgnorePaths("id", "title", "author",
                "description", "url", "publishedDate", "lastUpdate", "genres", "tags", "chapters"));
        Page<Comic> comics = comicRepository.findAll(example, PageRequest.of(0, amount, Sort.by(Sort.Direction.DESC, "lastUpdate")));
        return new ArrayList<>(comics.getContent());
    }

    public void createChapter(String comicID, String userID, URL url){
        if(chapterRepository.findByURL(url) != null){
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
        if(!status.equals(STATUS_PRIVATE) && !status.equals(STATUS_UNLISTED) &&
                !status.equals(STATUS_PUBLIC)){
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
}
