package com.jtspringproject.JtSpringProject;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.services.categoryService;
import org.junit.jupiter.api.Test;

import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.junit4.SpringRunner;


@ExtendWith(SpringExtension.class)
@SpringBootTest
public class CategoryServiceIntegrationTest {

    @Autowired
    private categoryService categoryService;

    @Test
    public void testGetCategoryById(){
        Category category = categoryService.getCategory(1);
        assertThat(category).isNotNull();
    }

    @Test
    public void testGetCategories(){
        List<Category>  categoryList = categoryService.getCategories();
        assertThat(categoryList).isNotNull();
    }

}
