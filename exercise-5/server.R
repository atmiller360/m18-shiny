#INFO 201 M18 Exercise 5 Server

#Require the following: shiny, HSUAR, dyplr, and ggplot2
library(shiny)
library(HSAUR)
library(dplyr)
library(ggplot2)

#Load the dataset 'womensrole' from the HSUAR package (same way you would load a built in dataset)

dataset <- womensrole

#Here you will define the data that is shown based on your inputs defined in the UI
#and turn it into an output plot
#Hint: reference the input values using 'input$inputID'
shinyServer(function(input, output) {
   
  #plotNameHere will become what you named your plot in the UI
  output$roleP <- renderPlot({
    
    #Here use your different input values to define what data is used to render your plot
    #The x axis will be the level of education
    #The y axis will be the level of agreement or disagreement
    #The dataset used will be filtered by sex
    
    
    #Filter the dataset based on whether the input is Men, Women, or Both
    if(input$sex == "Men") {
      filtered.data <- dataset %>% filter(sex == "Male")
    } else if(input$sex == "Women") {
      filtered.data <- dataset %>% filter(sex == "Female")
    } else {
      filtered.data <- dataset
    }
  
    
    #Define a y axis value based on the input Agree or Disagree
    if(input$thoughts == "Agree") {
      thoughts = filtered.data$agree
    } else {
      thoughts = filtered.data$disagree
    }
    
    #Using the values you just defined, construct a scatterplot using ggplot2
    #x will be defined by education, y by agree/disagree
    #Bonus: Factor the color field by sex 
    #(this will allow you to visually see the difference between Men and Women when Both are selected)
    ggplot(filtered.data, aes(x=education, y=thoughts, color=factor(sex))) + geom_point()
    
  })
  
})
