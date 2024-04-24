package com.project.gadget.onlinegadgetstore;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
@SpringBootTest
class OnlineGadgetStoreApplicationTests {

	
	
	private MockMvc mockmvc;
	
	@Autowired
	private WebApplicationContext context;
	
	
	@BeforeEach
	public void setUp() {
		mockmvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	void CheckWelcomePage() throws Exception {

		MvcResult result = mockmvc.perform(get("/").contentType(MediaType.APPLICATION_JSON_VALUE))
                .andExpect(status().isOk())
                .andReturn();
		assertTrue(result.getResponse().getStatus() == 200);	
	}
	
	@Test
	void CheckLoginPage() throws Exception {

		MvcResult result = mockmvc.perform(get("/login").contentType(MediaType.APPLICATION_JSON_VALUE))
                .andExpect(status().isOk())
                .andReturn();
		assertTrue(result.getResponse().getStatus() == 200);	
	}
	
		
	@Test
	void CheckinvalidProduct() throws Exception {
		
		MvcResult result = mockmvc.perform(get("/product12").contentType(MediaType.APPLICATION_JSON_VALUE))
                .andExpect(status().isNotFound())
                .andReturn();
		assertTrue(result.getResponse().getStatus() == 404);
	}
	
	

}









