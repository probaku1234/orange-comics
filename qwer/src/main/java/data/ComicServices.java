package data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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

        if(publishedStatus != STATUS_PRIVATE && publishedStatus != STATUS_UNLISTED &&
                publishedStatus != STATUS_PUBLIC){
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

        if(comic.author != userID){
            System.out.println("User is not author of comic.");
            return;
        }

        for (String chapID: comic.chapters) {
            deleteChapter(chapID, comicID, userID);
        }

        comicRepository.delete(comic);
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

        if(comic.author != userID){
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

        if(comic.author != userID){
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

        if(comic.author != userID){
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


}
