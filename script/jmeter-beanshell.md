http://www.cnblogs.com/puresoul/p/4949889.html
http://www.cnblogs.com/puresoul/p/4949889.html
http://blog.csdn.net/silencemylove/article/details/51373873
import org.json.*;

String response_data = prev.getResponseDataAsString();
JSONObject data_obj = new JSONObject(response_data);
String apps_str = data_obj.get("body").get("apps").toString();
JSONArray apps_array = new JSONArray(apps_str);
String[] result = new String[apps_array.length()];
for(int i=0;i<apps_array.length();i++){
    JSONObject app_obj = new JSONObject(apps_array.get(i).toString());
    String name = app_obj.get("name").toString();
    result[i] = name;
}
vars.put("result", Arrays.toString(result));


import org.json.JSONArray;  
import org.json.JSONException;  
import org.json.JSONObject;  

String jsonContent = prev.getResponseDataAsString();  

JSONObject response = new JSONObject(jsonContent);  
JSONArray groups = response.getJSONObject("priorityGroups").getJSONArray("groups");  
String strGroups = groups.toString();  
vars.put("groups",strGroups);  
