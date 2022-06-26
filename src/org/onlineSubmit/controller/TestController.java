package org.onlineSubmit.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.onlineSubmit.entity.Manuscript;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
@RequestMapping("/test")
@Controller
public class TestController {
	@RequestMapping(value="/download",method=RequestMethod.GET)
	public void download(HttpServletRequest request,HttpServletResponse response,String filePath) {
		String filename = "1585046223371.docx";//
		System.out.print(filePath);
		//解决获得中文参数的乱码----下节课讲
		try {
			filename = new String(filename.getBytes("ISO8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//美女.jpg
		String savePath = request.getServletContext().getRealPath("/")+"\\upload\\";
		//获得请求头中的User-Agent
		String agent = request.getHeader("User-Agent");
		//根据不同浏览器进行不同的编码
		String filenameEncoder = "";
		if (agent.contains("MSIE")) {
			// IE浏览器
			try {
				filenameEncoder = URLEncoder.encode(filename, "utf-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			filenameEncoder = filenameEncoder.replace("+", " ");
		} else {
			// 其它浏览器
			try {
				filenameEncoder = URLEncoder.encode(filename, "utf-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}				
		}



		//要下载的这个文件的类型-----客户端通过文件的MIME类型去区分类型
		//response.setContentType(this.getServletContext().getMimeType(filename));
		//告诉客户端该文件不是直接解析 而是以附件形式打开(下载)----filename="+filename 客户端默认对名字进行解码
		response.setHeader("Content-Disposition", "attachment;filename="+filenameEncoder);
		//获取文件的绝对路径
		String path = savePath+filename;
		//获得该文件的输入流
		InputStream in = null;
		try {
			in = new FileInputStream(path);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//获得输出流---通过response获得的输出流 用于向客户端写内容
		ServletOutputStream out = null;
		try {
			out = response.getOutputStream();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//文件拷贝的模板代码
		int len = 0;
		byte[] buffer = new byte[1024];
		try {
			while((len=in.read(buffer))>0){
				try {
					out.write(buffer, 0, len);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try {
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//out.close();
	}
}
