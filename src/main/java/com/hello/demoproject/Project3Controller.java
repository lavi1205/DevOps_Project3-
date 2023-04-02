package com.hello.demoproject;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Project3Controller {
    @RequestMapping(value = "/")
    public String index(){
        return "test1";
    }
    
}
