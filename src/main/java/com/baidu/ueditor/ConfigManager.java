package com.baidu.ueditor;

import java.io.*;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cn.hutool.core.io.resource.ClassPathResource;
import org.json.JSONArray;
import org.json.JSONObject;


import com.baidu.ueditor.define.ActionMap;

/**
 * 配置管理器
 * @author hancong03@baidu.com
 *
 */
public final class ConfigManager {

	private final String rootPath;
	private final String originalPath;
	private final String contextPath;
	private static final String configFileName = "config.json";
	private String parentPath = null;
	private JSONObject jsonConfig = null;
	// 涂鸦上传filename定义
	private final static String SCRAWL_FILE_NAME = "scrawl";
	// 远程图片抓取filename定义
	private final static String REMOTE_FILE_NAME = "remote";
	
	private String host = "";
	private String absPath = "";
	private String relPath = "/";
	private HttpServletRequest request;
	private HttpSession session;

	/*
	 * 通过一个给定的路径构建一个配置管理器， 该管理器要求地址路径所在目录下必须存在config.properties文件
	 */
	private ConfigManager ( String rootPath, String contextPath, String uri, HttpServletRequest request ) throws FileNotFoundException, IOException {
		this.request = request;
		this.session = this.request.getSession();
//		this.userToken = ConfigUtil.getUserToken(session);
//		this.absPath = ConfigUtil.getUploadUEditorPath(this.site_id, "U");
//		this.relPath = ConfigUtil.getUploadUEditorPath(this.site_id, "A");
		this.host = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		//this.originalPath = this.absPath;
		
		rootPath = rootPath.replace( "\\", "/" );
		
		this.rootPath = rootPath;
		this.contextPath = contextPath;
		
		if ( contextPath.length() > 0 ) {
			this.originalPath = this.rootPath + uri.substring( contextPath.length() );
		} else {
			this.originalPath = this.rootPath + uri;
		}
		
		this.initEnv();
		
	}
	
	/**
	 * 配置管理器构造工厂
	 * @param rootPath 服务器根路径
	 * @param contextPath 服务器所在项目路径
	 * @param uri 当前访问的uri
	 * @return 配置管理器实例或者null
	 */
	public static ConfigManager getInstance ( String rootPath, String contextPath, String uri, HttpServletRequest request ) {
		
		try {
			return new ConfigManager(rootPath, contextPath, uri, request);
		} catch ( Exception e ) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	// 验证配置文件加载是否正确
	public boolean valid () {
		return this.jsonConfig != null;
	}
	
	public JSONObject getAllConfig () {
		
		return this.jsonConfig;
		
	}
	
	public Map<String, Object> getConfig ( int type ) {
		
		Map<String, Object> conf = new HashMap<String, Object>();
		String savePath = null;

		switch ( type ) {
		
			case ActionMap.UPLOAD_FILE:
				conf.put( "isBase64", "false" );
				conf.put( "maxSize", this.jsonConfig.getLong( "fileMaxSize" ) );
				conf.put( "allowFiles", this.getArray( "fileAllowFiles" ) );
				conf.put( "fieldName", this.jsonConfig.getString( "fileFieldName" ) );
				savePath = this.jsonConfig.getString( "filePathFormat" );
				break;
				
			case ActionMap.UPLOAD_IMAGE:
				conf.put( "isBase64", "false" );
				conf.put( "maxSize", this.jsonConfig.getLong( "imageMaxSize" ) );
				conf.put( "allowFiles", this.getArray( "imageAllowFiles" ) );
				conf.put( "fieldName", this.jsonConfig.getString( "imageFieldName" ) );
				savePath = this.jsonConfig.getString( "imagePathFormat" );
				break;
				
			case ActionMap.UPLOAD_VIDEO:
				conf.put( "maxSize", this.jsonConfig.getLong( "videoMaxSize" ) );
				conf.put( "allowFiles", this.getArray( "videoAllowFiles" ) );
				conf.put( "fieldName", this.jsonConfig.getString( "videoFieldName" ) );
				savePath = this.jsonConfig.getString( "videoPathFormat" );
				break;
				
			case ActionMap.UPLOAD_SCRAWL:
				conf.put( "filename", ConfigManager.SCRAWL_FILE_NAME );
				conf.put( "maxSize", this.jsonConfig.getLong( "scrawlMaxSize" ) );
				conf.put( "fieldName", this.jsonConfig.getString( "scrawlFieldName" ) );
				conf.put( "isBase64", "true" );
				savePath = this.jsonConfig.getString( "scrawlPathFormat" );
				break;
				
			case ActionMap.CATCH_IMAGE:
				conf.put( "filename", ConfigManager.REMOTE_FILE_NAME );
				conf.put( "filter", this.getArray( "catcherLocalDomain" ) );
				conf.put( "maxSize", this.jsonConfig.getLong( "catcherMaxSize" ) );
				conf.put( "allowFiles", this.getArray( "catcherAllowFiles" ) );
				conf.put( "fieldName", this.jsonConfig.getString( "catcherFieldName" ) + "[]" );
				savePath = this.jsonConfig.getString( "catcherPathFormat" );
				break;
				
			case ActionMap.LIST_IMAGE:
				conf.put( "allowFiles", this.getArray( "imageManagerAllowFiles" ) );
				conf.put( "dir", this.jsonConfig.getString( "imageManagerListPath" ) );
				conf.put( "count", this.jsonConfig.getInt( "imageManagerListSize" ) );
				break;
				
			case ActionMap.LIST_FILE:
				conf.put( "allowFiles", this.getArray( "fileManagerAllowFiles" ) );
				conf.put( "dir", this.jsonConfig.getString( "fileManagerListPath" ) );
				conf.put( "count", this.jsonConfig.getInt( "fileManagerListSize" ) );
				break;
				
		}
		
		conf.put( "savePath", savePath );
		//conf.put( "rootPath", this.rootPath );
		conf.put( "rootPath", this.absPath );
		return conf;
		
	}
	
	private void initEnv () throws FileNotFoundException, IOException {
		
		File file = new File( this.originalPath );
		
		if ( !file.isAbsolute() ) {
			file = new File( file.getAbsolutePath() );
		}
		
		this.parentPath = file.getParent();
		
		String configContent = this.readFile( this.getConfigPath() );
//		String configContent = this.convertJson();

		
		try{
			JSONObject jsonConfig = new JSONObject( configContent );
			/* 上传图片位置 */
			jsonConfig.put("imageUrlPrefix", "/uefile/");
			jsonConfig.put("imagePathFormat", this.relPath+"image/{yyyy}{mm}{dd}/{time}{rand:6}");
			/* 涂鸦图片位置 */
			jsonConfig.put("scrawlUrlPrefix", this.host + this.relPath);
			jsonConfig.put("scrawlPathFormat", "scrawl/{yyyy}{mm}{dd}/{time}{rand:6}");
			/* 截图工具位置  */
			jsonConfig.put("snapscreenUrlPrefix", this.host + this.relPath);
			jsonConfig.put("snapscreenPathFormat", "snapscreen/{yyyy}{mm}{dd}/{time}{rand:6}");
			/* 抓取远程图片位置 */
			jsonConfig.put("catcherUrlPrefix", "/uefile/");
			jsonConfig.put("catcherPathFormat", "catcher/{yyyy}{mm}{dd}/{time}{rand:6}");
			/* 上传视频位置 */
			jsonConfig.put("videoUrlPrefix", this.host + this.relPath);
			jsonConfig.put("videoPathFormat", "video/{yyyy}{mm}{dd}/{time}{rand:6}");
			/* 上传文件位置 */
			jsonConfig.put("fileUrlPrefix", this.host + this.relPath);
			jsonConfig.put("filePathFormat", "file/{yyyy}{mm}{dd}/{time}{rand:6}");
			/* 列出指定目录下的图片 */
			jsonConfig.put("imageManagerUrlPrefix", "/uefile/");
			jsonConfig.put("imageManagerListPath", "ueditor/image/");
			/* 列出指定目录下的文件 */
			jsonConfig.put("fileManagerUrlPrefix", this.host + this.relPath);
			jsonConfig.put("fileManagerListPath", "ueditor/file/");

//			JSONObject jsonConfig = new JSONObject( configContent );
//			/* 上传图片位置 */
//			jsonConfig.put("imageUrlPrefix", this.host + this.relPath);
//			jsonConfig.put("imagePathFormat", "image/{yyyy}{mm}{dd}/{time}{rand:6}");
//			/* 涂鸦图片位置 */
//			jsonConfig.put("scrawlUrlPrefix", this.host + this.relPath);
//			jsonConfig.put("scrawlPathFormat", "scrawl/{yyyy}{mm}{dd}/{time}{rand:6}");
//			/* 截图工具位置  */
//			jsonConfig.put("snapscreenUrlPrefix", this.host + this.relPath);
//			jsonConfig.put("snapscreenPathFormat", "snapscreen/{yyyy}{mm}{dd}/{time}{rand:6}");
//			/* 抓取远程图片位置 */
//			jsonConfig.put("catcherUrlPrefix", this.host + this.relPath);
//			jsonConfig.put("catcherPathFormat", "catcher/{yyyy}{mm}{dd}/{time}{rand:6}");
//			/* 上传视频位置 */
//			jsonConfig.put("videoUrlPrefix", this.host + this.relPath);
//			jsonConfig.put("videoPathFormat", "video/{yyyy}{mm}{dd}/{time}{rand:6}");
//			/* 上传文件位置 */
//			jsonConfig.put("fileUrlPrefix", this.host + this.relPath);
//			jsonConfig.put("filePathFormat", "file/{yyyy}{mm}{dd}/{time}{rand:6}");
//			/* 列出指定目录下的图片 */
//			jsonConfig.put("imageManagerUrlPrefix", this.host + this.relPath);
//			jsonConfig.put("imageManagerListPath", "ueditor/image/");
//			/* 列出指定目录下的文件 */
//			jsonConfig.put("fileManagerUrlPrefix", this.host + this.relPath);
//			jsonConfig.put("fileManagerListPath", "ueditor/file/");
			
			this.jsonConfig = jsonConfig;
		} catch ( Exception e ) {
			this.jsonConfig = null;
		}
		
	}



	private String getConfigPath () {
		//return this.parentPath + File.separator + ConfigManager.configFileName;
		try {
			ClassPathResource classPathResource = new ClassPathResource("config.json");
			InputStream stream = classPathResource.getStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(stream,"utf-8"));
			StringBuffer message = new StringBuffer();
			String line = null;
			while ((line = br.readLine()) != null) {
				message.append(line);
			}
			String result = message.toString().replaceAll("/\\*(.|[\\r\\n])*?\\*/", "");
			return result;
		} catch (Exception e) {
			return null;
		}
	}

	private String[] getArray ( String key ) {
		
		JSONArray jsonArray = this.jsonConfig.getJSONArray( key );
		String[] result = new String[ jsonArray.length() ];
		
		for ( int i = 0, len = jsonArray.length(); i < len; i++ ) {
			result[i] = jsonArray.getString( i );
		}
		
		return result;
		
	}

//	public static void main(String[] args) {
//		System.out.println(ConfigManager.class.getResource(""));
//		System.out.println(ConfigManager.class.getResource("/static/common/ueditor/jsp/config.json"));
//		System.out.println(ConfigManager.class.getClassLoader().getResource(""));
//		System.out.println(ConfigManager.class.getClassLoader().getResource("/"));
//	}
	
	private String readFile ( String path ) throws IOException {
		
		StringBuilder builder = new StringBuilder();
		
		try {
			
			InputStreamReader reader = new InputStreamReader( new FileInputStream( path ), "UTF-8" );
			BufferedReader bfReader = new BufferedReader( reader );
			
			String tmpContent = null;
			
			while ( ( tmpContent = bfReader.readLine() ) != null ) {
				builder.append( tmpContent );
			}
			
			bfReader.close();
			
		} catch ( UnsupportedEncodingException e ) {
			// 忽略
		}
		
		return this.filter( builder.toString() );
		
	}
	
	// 过滤输入字符串, 剔除多行注释以及替换掉反斜杠
	private String filter ( String input ) {
		
		return input.replaceAll( "/\\*[\\s\\S]*?\\*/", "" );
		
	}
	
}
