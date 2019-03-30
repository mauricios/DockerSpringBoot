package app;

import java.util.HashMap;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties("app")
public class ApplicationProperties {
 
 private String title;
 private HashMap datasource;

 public String getTitle() {
  return title;
 }

 public void setTitle(String title) {
    this.title = title;
 }
 public HashMap getDatasource() {
    return datasource;
 }

 public void setDatasource(HashMap datasource) {
    this.datasource = datasource;
 }
 
}