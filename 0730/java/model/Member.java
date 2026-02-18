package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private int id;
    private String userId;
    private String password;
    private String name;
    private String phone;
    private String address;
    private Date createdAt;
}
