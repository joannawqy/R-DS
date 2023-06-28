rankall <- function(outcome, num ='best') {
  ##read outcome data
  df_raw <- read.csv("~/Desktop/R-DS/Final_Assignment/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv",colClasses="character") 
  
  outcome_selected <- tolower(outcome)
  
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
  
  col_indices <- grep(outcome_selected, colnames(df))
  df <- df[,c(1,2,col_indices)]
  df <- df[complete.cases(df),]
  grouped_df <- split(df, df$state)
  hospital_v <- c()
  state_v <- c()
  
  for (item in grouped_df) {
    item[do.call(order, c(item[outcome_selected], item["hospital name"])), ]
    
    if (num=='best') {
      hospital_v <- c(hospital_v, item[, "hospital name"][1])
      state_v <- c(state_v, item[, "state"][1])
    }
    else if (num=='worst') {
      hospital_v <- c(hospital_v, item[, "hospital name"][nrow(item)])
      state_v <- c(state_v, item[, "state"][nrow(item)])
    } 
    else if (typeof(num)=='double') {
      if (num <= nrow(item)) {
        hospital_v <- c(hospital_v, item[, "hospital name"][num])
        state_v <- c(state_v, item[, "state"][num])
      }
      else {
        hospital_v <- c(hospital_v, NA)
        state_v <- c(state_v, item[, "state"][1])
      }
    }
  }
  
  df_final <- data.frame(hospital = hospital_v, state = state_v)
  rownames(df_final) <- df_final$state
  return(df_final)
}