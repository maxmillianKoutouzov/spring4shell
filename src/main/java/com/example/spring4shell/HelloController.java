package com.example.spring4shell;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class HelloController {

    @RequestMapping(value = "/greeting",
                    method = RequestMethod.GET)
    public String greetingForm(Model greeting) {
        greeting.addAttribute("greeting", new Greeting());
        return "greeting.html";
    }

    @PostMapping("/greeting")
    public String greetingSubmit(@ModelAttribute Greeting greeting) {

        return "greeting.html";
    }

}