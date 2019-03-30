package app;

public class Greeting {

    private final long id;
    private final String content;
    private final String description;

    public Greeting(long id, String content, String description) {
        this.id = id;
        this.content = content;
        this.description = description;        
    }

    public long getId() {
        return id;
    }

    public String getContent() {
        return content;
    }

    public String getDescription() {
        return description;
    }    
}
