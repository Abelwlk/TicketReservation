package test;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.module.paramnames.ParameterNamesModule;
import domain.Ticket;
import org.junit.Test;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class JacksonTestJson {
    @Test
    public void test01() throws JsonProcessingException {
        TestJson t = new TestJson();
        t.setDate(new Date());
        t.setLocalDate(LocalDate.now());
        t.setLocalTime(LocalTime.now());
        t.setLocalDateTime(LocalDateTime.now());

        Ticket tt = new Ticket("AA", "AA", "AA", LocalDate.now(), LocalTime.now(), 11, 11);

        ObjectMapper mapper = new ObjectMapper();
        mapper.findAndRegisterModules();

        String json = mapper.writeValueAsString(tt);
        System.out.println(json);

    }

}
