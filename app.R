library(shiny)
library(shinythemes)
library(Boruta)
options(shiny.maxRequestSize = 1024 ^ 2)

ui = fluidPage(
  theme = shinytheme("cosmo"),
  title = "All-relevant feature selection with Boruta and R",
  tags$h3("All-relevant feature selection with Boruta and R"),
  fluidRow(
    column(4,
      tags$small('1. Open a CSV file first:'),
      fileInput(
        "file",
        "Choose CSV file",
        multiple = FALSE,
        accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv" )
      )
    ),
    column(4,
      tags$small('2. Select target variable:'),
      uiOutput("targetSelector")
    ),
    column(4,
      tags$small('3. Click run to launch Boruta'),
      tags$br(),
      actionButton("run", "▸ Run Boruta", style = "margin-top: 25px; background-color: #057ed7; border: none;")
    ),
    style = "background-color: #EEE; margin-top: 20px; margin-bottom: 20px; padding-top: 20px; padding-bottom: 20px;"
  ),
  tags$h4("Top 3 rows"),
  tableOutput("contents"),
  plotOutput("plots", width = "100%", height = "500"),
  textOutput("info", container = pre)
)

server = function(input, output) {
  # Run Boruta when a user clicks RUN
  getModel = eventReactive(
    input$run,
    {
      # Get data
      inFile <- input$file
      if (is.null(inFile)) return(NULL)
      df = read.csv(inFile$datapath)
      df = df[complete.cases(df),]

      # Get target
      target = toString(input$target)

      # Generate formula
      formula = as.formula(paste(target, '~.'))

      # Fit Boruta
      return(Boruta(formula, data = df, doTrace = 2))
    }
  )

  # Render table head
  output$contents = renderTable({
    inFile <- input$file
    if (is.null(inFile)) return(NULL)
    df = read.csv(inFile$datapath)
    return(head(df, 3))
  })

  # Render Boruta text results
  output$info = renderText({
    model = getModel()
    print(model)
    return(
      paste(capture.output(print(model)), collapse = '\n')
    )
  })

  # Render Boruta's plot
  output$plots = renderPlot({
    model = getModel()
    par(mar=c(5,1,1,1))
    return(plot(model, las = 2, xlab = ''))
  })

  # Render target selector
  output$targetSelector = renderUI({
    inFile <- input$file
    if (is.null(inFile)) return(NULL)
    df = read.csv(inFile$datapath)
    selectInput("target", "Target variable", multiple = FALSE, choices = as.character(colnames(df)))
  })
}

shinyApp(ui, server)
