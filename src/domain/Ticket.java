package domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;
import java.time.LocalTime;

public class Ticket {
    private String tid;
    private String startCid;
    private String arriveCid;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;
    @JsonFormat(pattern = "HH:mm:ss")
    private LocalTime time;
    private int price;
    private int num;

    public Ticket(){}

    public Ticket(String tid, String startCid, String arriveCid, LocalDate date, LocalTime time, int price, int num) {
        this.tid = tid;
        this.startCid = startCid;
        this.arriveCid = arriveCid;
        this.date = date;
        this.time = time;
        this.price = price;
        this.num = num;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public String getStartCid() {
        return startCid;
    }

    public void setStartCid(String startCid) {
        this.startCid = startCid;
    }

    public String getArriveCid() {
        return arriveCid;
    }

    public void setArriveCid(String arriveCid) {
        this.arriveCid = arriveCid;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getTime() {
        return time;
    }

    public void setTime(LocalTime time) {
        this.time = time;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    @Override
    public String toString() {
        return "Ticket{" +
                "tid='" + tid + '\'' +
                ", startCid='" + startCid + '\'' +
                ", arriveCid='" + arriveCid + '\'' +
                ", date=" + date +
                ", time=" + time +
                ", price=" + price +
                ", num=" + num +
                '}';
    }
}
