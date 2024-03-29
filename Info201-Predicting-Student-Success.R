library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)

data <- read_delim("data/dataset.csv")
data2 <- read.csv("data/dataset.csv")
getwd()
data1 <- data.frame(data)
names(data1) <- gsub("\\.", "_", names(data1))

ui <- fluidPage(
  
  titlePanel("Predicting Students' Dropout and Academic Success"),
  
  # Main panel with tabs
  mainPanel(
    tabsetPanel(
      # Opening page with explanatory text
      tabPanel("Project Overview",
               tags$p("Created by Akhil Damidi, Luke Jin, Bill Yuliang, and Jack Villagrand"),
               fluidRow(
                 column(width = 6, 
                        tags$img(src = "https://storage.googleapis.com/kaggle-datasets-images/2780494/4802354/2b7db8e162649e95f56d8a3e8bb05395/dataset-cover.png?t=2023-01-03-09-19-56", width = "220%")),
                 
               ),
               tags$h1("Project Overview", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("The report provides a thorough analysis of how social and economic factors affect students' academic success. Determining the main elements that support student accomplishment is the main goal of this report, along with a study of the Predict Students' Dropout and Academic Success dataset. For academics, teachers, administrators, and policymakers working in the higher education field, this study may be useful. This report may be particularly useful to people trying to understand the factors that promote student achievement and people trying to improve student performance across a variety of areas."),
               tags$p("Our goal has been to provide our users with easily understandable graphs that show the relationship between social and economic factors and student accomplishment. These graphical representations are integrated with the dataset's assembly by eminent authors Valentim Realinho, Jorge Machado, Luis Baptista, and Monica V. Martins. Also, our users have the option of focusing on particular elements that affect students' academic progress by using toggles and filters."),
               tags$h1("What is our data?", gistyle = "font-size: 2em; margin-top: 20px;"),
               tags$p("The data set we chose to work with was a data set predicting students’ dropping out, and their academic success. This data was collected by four authors, Valentim Realinho, Jorge Machado, Luis Baptista, and Monica V. Martins. We accessed this data through the website Kaggle. For undergraduate students in a variety of fields, this dataset contains information on their socioeconomic status, academic achievement, and demographics. It can be used to examine how various variables may affect academic success and dropout rates. Information such as the application method, course preference, grades, and economic indicators like the unemployment and inflation rates are all included. This dataset, which may be used across disciplines, offers insightful information about the factors that influence students' decision to continue their education or leave it early."),
               tags$h1("Who is our audience?", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("Several different stakeholders, such as academics, educators, managers, and policymakers in the area of higher education, are anticipated to be quite interested in the dataset under review. Particularly those who are eager to learn more about the elements that influence student success as well as those who are actively looking for methods to improve students' performance across a variety of academic fields."),
               tags$p("Given the rich and wide nature of the dataset, data scientists and analysts looking to examine and evaluate subjects linked to education or social science are also likely to find it interesting. Researchers have a great chance to investigate and comprehend the complexity of student performance and retention with the help of the dataset, which may also make it easier to establish interventions and policies that would enhance outcomes for students in higher education."),
               tags$p("In summary, the dataset offers a wealth of information that has the potential to inform the development of evidence-based strategies for supporting and improving student success. Its broad applicability and relevance to a diverse range of stakeholders underscore its significance and value as a critical resource for research and analysis in the field of higher education."),
               tags$h1("What we want to learn?", style = "font-size: 2em; margin-top: 20px;"),
               tags$ul(
                 tags$li("What are the demographic and academic factors that predict student dropout and academic success in various undergraduate courses, and how do these factors differ by field?"),
                 tags$li("What impact does being an international student or non-international student have on the students' success?"),
                 tags$li("Do economic factors, such as unemployment, inflation, and GDP, of where students live in affect their dropout, enrollment or graduation?")
               )
      ),
      
      # Plot page
      tabPanel("Parental Influence on Academic Success",
               sidebarLayout(
                 sidebarPanel(
                   renderText(output$plot_text),
                   sliderInput("Student Age", "Age of student at time of enrollment",
                               min = 17,
                               max = 70,
                               value = 20),
                   radioButtons("color", "Choose color",
                                choices = c("blue", "green", "orange", "purple", "yellow"))
                 ),
                 mainPanel(
                   plotOutput("plot"),
                   tags$h1("Summary of Findings From Graph"),
                   tags$p("This graph illustrates that there is little effect on a student's grade based on their father's occupation, and that the age of a student does not impact the influence of a  father's occupation on a student."),
                   tags$p("In this graph, you are able to adjust the age of the student using the widget on the left side of the app. The graph then displays the students' father's occupation, and the grades they recieved in their second semester."),
                   tags$p("The graph depicts that a high occupation for one's father does not depict academic success. As seen through the data, there is a large cluster of data points near the top left of the graph, indicating that there is a large sum of students getting strong grades, while their father has a lower occupation."),
                   tags$p("The graph demonstrates that regardless of the father's occupation, a student is able to succeed academically, and that overall a student whose father has a lower occupation will do fractionally better than a student whose father has a higher occupation")
                 )
               )
      ),
      
      tabPanel("Grade Changes by Nationality", 
               h1("Does Nationality influence the academic success?"),
               p("0 = Domestic Students | 1 = International Students"),
               sidebarLayout(
                 sidebarPanel(
                   selectInput(
                     inputId = "International", label = "International or Not:",
                     choices = c("0", "1"),
                     selected = c("0", "1"),
                   )
                 ),
                 mainPanel(
                   dataTableOutput("chart"),
                 )
               ),
               h2("From this data, we can notice that domestic students have higher grade on both semester 1 and 2.")
      ),
      
      tabPanel("Economic Factors and Education", 
               h1("Do economic factors, such as unemployment, inflation, and GDP, of where students live in, affect their dropout, enrollment or graduation?"),
               sidebarLayout(
                 sidebarPanel(
                   width = 4,
                   selectInput("xvar", "X-axis variable", choices = c("Unemployment_rate", "Inflation_rate", "GDP")),
                   selectInput("yvar", "Y-axis variable", choices = c("Unemployment_rate", "Inflation_rate", "GDP"))
                 ),
                 mainPanel(
                   fluidRow(
                     offset = 2,
                     width = 5,
                     plotOutput("scatter_plot", height = "600px", width = "1000px"),
                     verbatimTextOutput("corr_info"))
                   
                 )
               ),
               h2("Therefore, unemployment rate, inflation rate and GDP have no clear relationship to the academic success of students,
                as the correlations are all close to 0.")
      ),
      
      tabPanel("Conclusion",
               tags$h1("Takeaways", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("The study of the graph under the \"Parental Impact on Academic Achievement\" tab shows that neither the age of the student nor the father's job have any bearing on the association between a student's grade and their father's profession. According to a cluster of data points towards the upper left of the graph, many students are succeeding academically despite having fathers with lower occupations, proving that having a high-ranking father is not a prerequisite for success. This implies that a student can achieve academic success regardless of the father's line of work."),
               tags$p("In the tab \"Grade Changes by Nationality\", the research demonstrates that domestic students outperform foreign students, which can be evaluated based on the higher grades achieved by domestic students in the first and seconds semester than international students."),
               tags$p("After examining the scatterplot on the \"Economic Factors and Education\" tab,  relationships between the GDP, unemployment rate, inflation rate, and student academic accomplishment are all quite low, therefore, unemployment rate, inflation rate and GDP have no clear relationship to the academic success of students."),
               tags$p("In conclusion, the examination of the graph shows that domestic students typically perform better academically and that a student's academic success is not influenced by the profession of their father. However, there is no obvious connection between macroeconomic variables and academic accomplishment."),
               tags$h1("Implications", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("The insights gathered from the research have several broader implications for educational policy and practice. Firstly, the finding that a student's academic success is not determined by their father's occupation highlights the importance of providing equal educational opportunities to all students, regardless of their socio-economic background. This suggests that policies aimed at addressing educational inequality should focus on providing targeted support to students from disadvantaged backgrounds, rather than assuming that students from higher socio-economic backgrounds will automatically achieve better academic outcomes."),
               tags$p("Secondly, the finding that domestic students outperform international students suggests that there may be cultural or other factors that impact the academic performance of international students. This highlights the importance of providing targeted support to international students, such as language support, cultural orientation programs, and other forms of support that can help them succeed academically."),
               tags$p("Lastly, the lack of significant relationships between macroeconomic variables and academic success suggests that economic policies alone may not be sufficient to improve educational outcomes. Instead, educational policies should focus on addressing the underlying factors that contribute to academic success, such as teacher quality, class size, and the availability of educational resources. By adopting a holistic approach to educational policy, policymakers can ensure that all students have the opportunity to succeed academically, regardless of their socio-economic background or nationality."),
               tags$h1("Our Data Quality", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("The dataset \"Predict students' dropout and academic success\" that we got from Kaggle has been reviewed, and it looks to be of strong quality. The dataset comprises 61 attributes and 1710 instances, which provides a large quantity of data to work with. The dataset also appears to be well-organized, with all the data required for analysis present. In addition, the data was collected by four separate authors, reducing the bias of the dataset and improving its credibility."),
               tags$p("The collection contains a variety of data that might be used to design methods for promoting and enhancing student performance based on solid research. Its importance and value as a crucial resource for research and analysis in the field of higher education are underscored by its wide applicability and relevance to a diverse spectrum of stakeholders."),
               tags$p("It is important to keep in mind that the dataset is restricted to higher education in the United States, which may limit the applicability of the findings to other nations. Moreover, factors/variables affecting student success that are included in the dataset are all categorical, described with the use of numbers, which is difficult to interpret and breakdown the meaning of."),
               tags$h1("Future Ideas", style = "font-size: 2em; margin-top: 20px;"),
               tags$p("Based on the insights gathered from the research, there are several ideas for future studies that can be explored. For example, further research could examine the factors that contribute to academic success beyond parental occupation and nationality. The study could investigate variables such as family income, parental education level, and other socio-economic factors that may impact a student's academic achievement. This would provide a more comprehensive understanding of the factors that contribute to academic success and could inform policies that aim to improve educational outcomes."),
               tags$p("Another area for future research could focus on the reasons why domestic students outperform international students. Possible explanations could include differences in cultural background, language barriers, or a lack of familiarity with the educational system. By understanding the factors that contribute to this discrepancy, educational institutions can develop targeted strategies to support international students and improve their academic performance."),
               tags$p("Lastly, the lack of significant relationships between macroeconomic variables and academic success suggests that economic policies may not be the most effective means of improving educational outcomes. Future research could explore alternative strategies for improving educational outcomes, such as investing in teacher training, reducing class sizes, or implementing technology-based learning programs."),
               tags$p("Overall, the insights gathered from the research suggest that there is much to be explored regarding the factors that impact student academic success, and that further studies in this area could have significant implications for educational policy and practice."),
      ),
    )
  )
)


server <- function(input, output) {
  output$target_counts <- renderTable(
    {
      table(data1$Target)
    }
  )
  
  output$corr_info <- renderPrint({
    # Select the data based on x and y variable selections
    cor <- data.frame(x = data1[[input$xvar]], y = data1[[input$yvar]], target = data1$Target)
    
    # Compute the correlation value
    corr <- cor(cor$x, cor$y)
    
    # Return the correlation information
    paste("The correlation between", input$xvar, "and", input$yvar, "is", round(corr, 2))
  })
  
  #Plot for parental influence on academic success
  output$plot <- renderPlot({
    age_data <- data %>% 
      filter(`Age at enrollment` <= input$`Student Age`) %>% 
      ggplot(aes(`Father's occupation`, `Curricular units 2nd sem (grade)`)) +
      geom_point(col=input$color) +
      ggtitle("Relationship between Father's Occupation and Student's Grades")
    age_data
  })
  
  #Plot text for parental influence on academic success
  output$plot_text <- renderText({
    age_data <- data %>% 
      filter(`Age at enrollment` <= input$`Student Age`) %>% 
      ggplot(aes(`Age at enrollment`, `Curricular units 1st sem (grade)`)) +
      geom_point(col=input$color) +
      ggtitle(paste("The Age of Each Student, and the amount of student's which fit this age"))
    
    age_df <- ggplot_build(age_data)$data[[1]]
    
    n_total <- nrow(age_df)
    n_missing <- sum(is.na(age_df$`Curricular units 1st sem (grade)`) | is.na(age_df$`Age at enrollment`))
    n_non_missing <- n_total - n_missing
    
    paste("The amount of students who fit this age range: ", n_non_missing)
  })
  
  # Function to create scatter plot
  createScatterPlot <- function(xvar, yvar, data1) {
    ggplot(data1, aes_string(x = xvar, y = yvar, color = "Target")) + 
      geom_point(size = 10) + 
      labs(x = xvar, y = yvar, title = paste0("Scatter plot of ", xvar, " vs. ", yvar), color = "Target") +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, vjust = 1))
  }
  
  
  # Scatter plot output
  scatter_data <- reactive({
    createScatterPlot(input$xvar, input$yvar, data1)
  })
  
  output$scatter_plot <- renderPlot({
    scatter_data()
  })
  
  table_data <- reactive({
    data2 %>%
      filter(International == input$International) %>%
      mutate(across(c(Curricular.units.1st.sem..grade., Curricular.units.2nd.sem..grade.), ~round(., digits = 2))) %>%
      arrange(desc(Curricular.units.1st.sem..grade.), desc(Curricular.units.2nd.sem..grade.)) %>%
      select(Curricular.units.1st.sem..grade., Curricular.units.2nd.sem..grade.)
  })
  
  output$chart <- renderDataTable({
    table_data() %>%
      setNames(c("First Semester Grade", "Second Semester Grade"))
  })
  
}
shinyApp(ui = ui, server = server)