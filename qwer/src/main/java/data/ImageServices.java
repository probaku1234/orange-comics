package data;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.gridfs.model.GridFSFile;
import com.mongodb.gridfs.GridFSDBFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.data.mongodb.gridfs.GridFsResource;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

public class ImageServices {

    @Autowired
    private GridFsTemplate gridFsTemplate;

    public String saveImage(BufferedImage image) throws IOException {
        //define metadata
        DBObject metaData = new BasicDBObject();
        metaData.put("organization", "Orange Comics");
        metaData.put("type", "image");

        ByteArrayOutputStream os = new ByteArrayOutputStream();
        ImageIO.write(image,"png", os);
        InputStream inputStream = new ByteArrayInputStream(os.toByteArray());

        String imageID = gridFsTemplate.store(inputStream, (new Date()).toString(), metaData).toString();

        return imageID;
    }

    public BufferedImage retrieveImage(String imageID) throws IOException {
        GridFSFile fsFile = gridFsTemplate.findOne(new Query(Criteria.where("_id").is(imageID)));
        GridFsResource fsResource = gridFsTemplate.getResource(fsFile);
        InputStream inputStream = fsResource.getInputStream();

        return ImageIO.read(inputStream);
    }

    public void deleteImage(String imageID) {
        gridFsTemplate.delete(new Query(Criteria.where("_id").is(imageID)));
    }
}
