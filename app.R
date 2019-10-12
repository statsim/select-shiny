library(shiny)
library(shinythemes)
library(Boruta)
options(shiny.maxRequestSize = 1024 ^ 2)

ui = fluidPage(
  theme = shinytheme("cosmo"),
  title = "All-relevant feature selection with Boruta",
  tags$h3("All-relevant feature selection with Boruta"),
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
      tags$small('3. Click run to launch Boruta:'),
      tags$br(),
      actionButton("run", "Run Boruta", style = "margin-top: 25px; background: #057ed7; border: none;")
    ),
    style = "background-color: #EEE; margin-top: 20px; margin-bottom: 20px; padding-top: 20px; padding-bottom: 20px;"
  ),
  tags$h4("First 3 rows:", style = "margin-top: 30px"),
  tableOutput("contents"),
  tags$h4("Feature importance plot:", style = "margin-top: 30px"),
  plotOutput("plots", width = "100%", height = "500"),
  tags$h4("Boruta output:", style = "margin-top: 30px"),
  textOutput("info", container = pre)
)

server = function(input, output) {
  # Run Boruta when a user clicks RUN
  getModel = eventReactive(
    input$run,
    {
      # Get data
      progress = shiny::Progress$new()
      progress$set(message = "Preparing data", value = 0.1)

      inFile <- input$file
      if (is.null(inFile)) return(NULL)
      df = read.csv(inFile$datapath)
      df = df[complete.cases(df),]

      # Get target
      target = toString(input$target)

      # Generate formula
      formula = as.formula(paste(target, '~.'))
      Sys.sleep(0.75)

      # Fit Boruta
      progress$set(message = "Running Boruta", value = 0.2)
      model = Boruta(formula, data = df)
      progress$set(message = "", value = 0.3)
      progress$close()
      return(model)
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
    return(
      paste(capture.output(print(model)), collapse = '\n')
    )
  })

  # Render Boruta's plot
  output$plots = renderPlot({
    model = getModel()
    par(mar=c(10,5,2,2))
    return(plot(model, las = 2, xlab = '', cex.lab = 1, cex.axis = 1, colCode = c("#4AEA0E", "#FFB807", "#FF0040", "#BCBCBC")))
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
