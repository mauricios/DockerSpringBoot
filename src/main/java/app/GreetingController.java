package app;

import java.util.HashMap;
import java.util.concurrent.atomic.AtomicLong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetingController {

    @Autowired
    ApplicationProperties myAppProperties;

    private static final String template = "Hello, %s!";
    private static final String templateBye = "Bye, %s!";    
    private final AtomicLong counter = new AtomicLong();

    @RequestMapping(value = {"", "/", "/greeting"})
    public Greeting greeting(@RequestParam(value="name", defaultValue="Mauricio") String name) {
        HashMap<String, String> datasource = myAppProperties.getDatasource();
        String dBUrl = datasource.get("url");
        return new Greeting(counter.incrementAndGet(),
                            String.format(template, name),
                            "DB URL: " + dBUrl);
    }

    @RequestMapping("/bye")
    public Greeting bye(@RequestParam(value="name", defaultValue="Mauricio") String name) {
        return new Greeting(counter.incrementAndGet(),
                            String.format(templateBye, name),
                            "This is just a Description");
    }    
}