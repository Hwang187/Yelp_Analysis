# Checking missing value and make visualization
missingMap <- function(businessLVc)
{
  # Check missing value
  Null_Counter = apply(businessLVc, 2, function(x) length(which(x == "" | is.na(x) | x == "NA"))/length(x))
  Null_Percent = Null_Counter[which(Null_Counter > 0)]
  barPlot = barplot(sort(Null_Percent), las=2, 
                    col=rainbow(49), cex.names=.5, ylim=c(0,1),
                    main = 'Missing Value Percentage',
                    ylab = 'Missing Percentage')
  return(barPlot)
}
