package model;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@Data
@ToString
public class Member {
    private String id;
    private String password;
    private String name;
    private String email;
    private String hp;
    private String address;
}
