library(shiny)
ui <- fluidPage(
  titlePanel("Shiny Layouts with Fluid Pages"),
  # Everything exists in a row b/c fluidpages are row-oriented
  fluidRow( # 12 horizontal boxes
    column(
      width = 3,
      # A long column
      actionButton("shuffle", "Sample Pictures"),
      uiOutput("cute1")
    ),
    column(
      width = 9,
      # A wide column

      # Add several rows inside
      fluidRow( # 12 horizontal boxes inside this
        column(
          width = 3,
          uiOutput("cute2")
        ),
        column(
          width = 3,
          offset = 2, # I can add some space
          uiOutput("cute3")
        ),
        column(
          width = 3,
          uiOutput("cute4")
        )
      ),

      br(), # Line break

      fluidRow( # 12 horizontal boxes inside this
        column(
          width = 3,
          uiOutput("cute5")
        ),
        column(
          width = 3,
          uiOutput("cute6")
        ),
        column(
          width = 3,
          uiOutput("cute7")
        ),
        column(
          width = 3,
          uiOutput("cute8")
        )
      ),

      hr(), # head rule - horiz line

      fluidRow( # 12 horizontal boxes inside this
        column(
          width = 12,
          uiOutput("cute9")
        )
      )
    )
  )

)

# A generic function
show_pic <- function(pic_str, input) {
    x <- list.files("www/", pattern = pic_str)

    y <- input

    if (length(x) == 0) {
      return(renderUI(helpText("No matching pictures found")))
    }

    # If x has any length, sample from x to get a single display option
    renderUI(img(src = sample(x, 1)))
}

server <- function(input, output) {
  imageList <- reactive({
    input$shuffle # change up every time we hit the shuffle button
    c(
      sample(list.files("www", "giraffe"), 1),
      sample(list.files("www", "puppy"), 3),
      sample(list.files("www", "kitty"), 4),
      sample(list.files("www", "snake"), 1)
    )
  })

  output$cute1 <- renderUI(img(src=imageList()[1], alt = "giraffe", width = "100%", height = "auto"))
  output$cute2 <- renderUI(img(src=imageList()[2], alt = "puppy", width = "100%", height = "auto"))
  output$cute3 <- renderUI(img(src=imageList()[3], alt = "puppy", width = "100%", height = "auto"))
  output$cute4 <- renderUI(img(src=imageList()[4], alt = "puppy", width = "100%", height = "auto"))
  output$cute5 <- renderUI(img(src=imageList()[5], alt = "kitty", width = "100%", height = "auto"))
  output$cute6 <- renderUI(img(src=imageList()[6], alt = "kitty", width = "100%", height = "auto"))
  output$cute7 <- renderUI(img(src=imageList()[7], alt = "kitty", width = "100%", height = "auto"))
  output$cute8 <- renderUI(img(src=imageList()[8], alt = "kitty", width = "100%", height = "auto"))
  output$cute9 <- renderUI(img(src=imageList()[9], alt = "snake", width = "100%", height = "auto"))

}
shinyApp(ui, server)
