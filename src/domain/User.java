package domain;

public class User {
    private String uid;
    private String username;
    private String password;
    private String truthName;
    private String telephone;
    private String identity;
    private String status;

    public User(String uid, String username, String password, String truthName, String telephone, String identity, String status) {
        this.uid = uid;
        this.username = username;
        this.password = password;
        this.truthName = truthName;
        this.telephone = telephone;
        this.identity = identity;
        this.status = status;
    }

    public User() {}

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTruthName() {
        return truthName;
    }

    public void setTruthName(String truthName) {
        this.truthName = truthName;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid='" + uid + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", truthName='" + truthName + '\'' +
                ", telephone='" + telephone + '\'' +
                ", identity='" + identity + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
