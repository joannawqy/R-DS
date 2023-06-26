rankhospital <- function(state, outcome, num='best') {
  ##read outcome data
  df_raw <- read.csv("~/Desktop/R-DS/Final_Assignment/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv",colClasses="character") 
  
  outcome_selected <- tolower(outcome)
  state_selected <- state
  
  ## check that state and outcome are valid
  state_present <- state_selected %in% df_raw[['State']]
  if (!state_present) {
    stop('invalid state')
  }
  
  outcome_present <- outcome_selected %in% c("heart attack", "heart failure", "pneumonia")
  if (!outcome_present) {
    stop("invalid outcome")
  } 
  
  selected_cols <- c("Hospital.Name", "State", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  new_names <- c("hospital name", "state", "heart attack", "heart failure", "pneumonia")
  df <- df_raw[, selected_cols]
  colnames(df) <- new_names
  
  columns_to_convert <- c("heart attack", "heart failure", "pneumonia")
  df[, columns_to_convert] <- lapply(df[, columns_to_convert], as.numeric)
  
  df <- df[df$state == state_selected,]
  col_indices <- grep(outcome_selected, colnames(df))
  df <- df[,c(1,2,col_indices)]
  df <- df[complete.cases(df),]
  df <- df[do.call(order, c(df[outcome_selected], df["hospital name"])), ]
  
  ## selection based on the num given
  if (num=='best') {
    df[, "hospital name"][1]
  }
  else if (num=='worst') {
    df[, "hospital name"][nrow(df)]
  } 
  else if (typeof(num)=='double') {
    if (num <= nrow(df)) {
      df[, "hospital name"][num]
    }
    else {
      print(NA)
    }
  }
}