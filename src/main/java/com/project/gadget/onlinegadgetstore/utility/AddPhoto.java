package com.project.gadget.onlinegadgetstore.utility;

import java.io.FileOutputStream;
import java.io.InputStream;

import org.springframework.stereotype.Component;

import jakarta.servlet.http.Part;

@Component
public class AddPhoto {

	private String photoImageFolderPath ="C:/Users/2318846/Downloads/online-gadget-store/online-gadget-store/src\\main/webapp/resources/productpic/";

	public String addPhotoToFolder(Part part) {
		String fileName=part.getSubmittedFileName();
		String uploadPath = photoImageFolderPath + fileName;
		try {
			FileOutputStream pos = new FileOutputStream(uploadPath);
			InputStream is = part.getInputStream();

			byte[] data = new byte[is.available()];
			is.read(data);
			pos.write(data);
			pos.close();
		}

		catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}

}
