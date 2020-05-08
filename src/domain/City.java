package domain;

public class City {
    private String cid;
    private String cityName;

    public City(){
        
    }

    public City(String cid, String cityName) {
        this.cid = cid;
        this.cityName = cityName;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    @Override
    public String toString() {
        return "City{" +
                "cid='" + cid + '\'' +
                ", cityName='" + cityName + '\'' +
                '}';
    }
}
