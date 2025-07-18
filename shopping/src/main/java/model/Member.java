package model;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Member {
    private String id;
    private String password;
    private String name;
    private String email;
    private String hp;
    private String address;

    // 기본 생성자
    public Member() {}

    // 전체 필드 생성자
    public Member(String id, String password, String name, String email, String hp, String address) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.email = email;
        this.hp = hp;
        this.address = address;
    }
}
