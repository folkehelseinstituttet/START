p.sim <- function(levs = rep("LHHH", 6), dump = F){
##
## Simulate patterns of methylation
##
require(ggplot2)
require(stringr)
set.seed(24)

#
## Expit transform
.f.expit <- function(x) 1/(1+exp(-x))

#
## Sim parameters
.n <- 1000
.high <- 2.5
.med <- 0
.low <- -.high
.sd <- 1
#
## Prep
.levs <- c(L = .low, M = .med, H = .high)
.type <- factor(1:6, labels = c("Non-ART Mother", "Non-ART Father", "Non-ART Child", "ART Mother", "ART Father", "ART Child"))
.child <- c(F, F, T, F, F, T)
.levs.split <- str_split_fixed(levs, pattern = "", n = 4) # Split letter combinations
#
## Simulation function
.f.sim <- function(lev, type, child = F){
	# simulation, create data frame
	.sim <- rnorm(.n*4, rep(lev, each = .n), .sd)
	.sim <- .f.expit(.sim)
	#
	.ut <- data.frame(
				type = type,
				SNP = c(rep("CC", .n), rep("CT", .n), rep("TC", .n), rep("TT", .n)),
				value = .sim
			)
	# if(child){
	# 	.ut$SNP[.ut$SNP == "TC"] <- "T(Mat) C(Pat)"	
	# 	.ut$SNP[.ut$SNP == "CT"] <- "C(Mat) T(Pat)"	
	# }
	if(!child) .ut$SNP[.ut$SNP == "TC"] <- "CT" # No parent-of-origin known for parents
	return(.ut)
}
#
## create a dataset
.data <- vector(6, mode = "list")
names(.data) <- c("NA.M", "NA.F", "NA.C", "A.M", "A.F", "A.C")
for(i in 1:6){
	.data[[i]] <- .f.sim(lev = .levs[.levs.split[i,]], type = .type[i], child = .child[i])
}
.data <- do.call(rbind, .data)

nice.clrs <- sanzo::sanzo.quad("c339")
#
## Violin chart
p <- ggplot(.data, aes(x=SNP, y=value, fill=SNP)) + 
  geom_violin()+
  ylim(0,1)+
  xlab("SNP genotype")+
  ylab("Methylation")+
	theme_light() +
	scale_fill_manual(values = nice.clrs) +
  theme(axis.text.x=element_text(face = "bold")) + 
  theme(axis.text.y=element_text(face = "bold")) + 
  facet_wrap(~type)+  theme(strip.text = element_text(face = "bold", size = 10))
#
## Dump
# ggsave(p, file = "temp/viol.pdf", width = 11, height = 7)
if(dump){
	 pdf(file = "temp/viol.pdf", width = 11, height = 7)
	 plot(p)
	 dev.off()
}else{
	 plot(p)
}
return(invisible(.data))
}