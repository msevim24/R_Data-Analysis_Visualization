###############################################
# Introduction to R for social sciences       #
# Solutions day 1                             #
###############################################

#####################
# Calculating with R

# 2. Calculations
(23 + 5) / sqrt(6 + 2)
log2(4 * 12)
cos(sin(5)) ^ (2 + 3)
27 / -7 + sqrt(log(3))

# 3. Comparisons
15 == (17 - 12) * 3
5 < 10 & 10 > 11
sqrt(49) != 7 ^ 2

# 4. Round
round(4272943 / 1360120, digits = 4)

##########
# Objects

# 1. Object y
y <- 12 + 3
class(y)

# 2. Object z
z <- "R is amazing!"
class(z)
length(z)

############
# Vectors I

# 1. Combining vectors
m <- 5:10
n <- 15:20
o <- c(m, n)
length(o)

# 2. Vector with rep()
x <- rep(1:5, 3)

# 3. Adding elements
x <- c(x, c("a", "b", "c", "d"))
class(x)

# 4. Replacing values
num <- c(11, 1, 4, 12, 8, 1, 6, 10, 13, 4)
num[num > 10] <- NA

#############
# Vectors II

# 1. The last four elements of x

# Create l
l <- letters[1:15]
# Solution that only works with a length of 15
length(l)
y <- l[11:15]
# Solution that works for any length of l
y <- l[(length(l)-3):length(l)]

# 2. Recode postal codes
plz <- c(3003, 4012, 4004, 3007, 4027, 3019, 4053, 3027)
plz_chr <- as.character(plz)
plz_chr[plz < 4000] <- "bern"
plz_chr[plz >= 4000] <- "basel"

# 3. Factor
kafiklatsch <- factor(c(1, rep(2, 3), rep(3, 3), rep(4, 2)), labels = c("Espresso", "Kafi", "Schale", "Cappuccino"))

# 4. Calculating with vectors
c(1, 2, 3) + c(7, 8, 9)  # works fine
c(1, 2) + c(7, 8, 9) # doesn't work

########
# Lists

# 1. Create list
a <- list(c("l", "m", "n", "o", "p"), seq(7, 70, by = 7), c(FALSE, TRUE, TRUE), 20:30)

# 2. Split list
b <- a[1:2]
c <- a[3:4]

# 3. Extract element
d <- b[[2]]
class(d)

######################
# Matrices and arrays

# 1. Dimension of vector
vec <- 1:5
dim(vec)

# 2. MAtrices and arrays
x <- matrix(1:6, ncol = 2, nrow = 3)
is.matrix(x)
is.array(x)

# 3. Sequence of even numbers

# Define start point (2) and end point (70) as well as the steps of the sequence (2)
ev <- seq(2,70,2)

# Show start and end of the result
head(ev)
tail(ev)

# Check the result: Length of the vector must be 35
length(ev)

# 4. Vector to matrix
ev_mat <- matrix(data = ev, nrow = 6, ncol = 6)

# The matrix has one cell more (36) than the vector has entries (35). R "recycles" the vector, i.e. the matrix is filled up with the existing vector entries, where R starts again from the beginning. The last entry of the matrix is therefore 2.

# 5. Subset
v_mat <- ev_mat[ev_mat >= 24] # Subset of the original matrix

class(v_mat)
dim(v_mat)
length(v_mat)

# The selection procedure caused the matrix to be converted into a vector. Therefore the object class is now "numeric", the dimension "NULL" and the length 24.

# 6. Create and transform matrix

# Create a new matrix from v_mat with the dimensions 8 x 3
n_mat <- matrix(v_mat, 8, 3) 
# Transpose the matrix
t_mat <- t(n_mat) 

# 7. Add new data

# First, we create a matrix with the same number of columns (8) and rows (5) as t_mat. We fill it with the numbers 1 to 40.
a_mat <- matrix(1:40, 5, 8)
# Second, we connect both matrices with the function rbind() - i.e. bind the columns together
an_mat <- rbind(a_mat, t_mat) 

# 8. Remove entries
an_mat <- an_mat[-6,-5]

# 9. Replace entries

# We count the number of values to transform and the already existing values = 22
sum(an_mat >= 50) # Length of the vector of values to be replaced
sum(an_mat == 22) # Does the value even occur in matrix 22 - and if so, how often?
# Then we replace the values
an_mat[an_mat >= 50] <- 22
# Check if everything has worked
sum(an_mat >= 50) # The result must be 0
sum(an_mat == 22) # The result must equal the sum of the previously counted values

# 10. Replace different entries

# Here we need a different procedure, the %in% function, to count several existing entries at once 
sum(an_mat %in% c(40, 42, 44)) # there are not three, but four replacements that we have to make
# Then we replace the values, again using the %in% function
an_mat[an_mat %in% c(40, 42, 44)] <- 17
# Check if everything has worked
sum(an_mat %in% c(40, 42, 44)) # The result must now be 0
sum(an_mat == 17) # The result must equal the sum of the previously counted values

# 11. From a single matrix to lists of matrices

# Create an empty list
l_mat <- list()
# Insert the matrix at position three
l_mat[[3]] <- an_mat
str(l_mat) # Check
# The matrix for t2 is defined by mat(t3) - 1
an_mat_2 <- an_mat - 1
length(an_mat - an_mat_2) == nrow(an_mat) * ncol(an_mat) # result must be TRUE
head(an_mat_2) # Check
# Add the matrix to the list
l_mat[[2]] <- an_mat_2
str(l_mat) # Check
# Create matrix with all 0 
an_mat_0 <- matrix(0, nrow(an_mat), ncol(an_mat))
sum(an_mat_0) == 0 # result must be TRUE
# Add matrix to list
l_mat[[1]] <- an_mat_0 # Add matrix
str(l_mat) # Check

##############
# Data frames

df_kafi <- data.frame(person = c("Maria", "Daniel", "Anna", "Peter", "Ursula",
                                 "Thomas", "Sandra", "Christian", "Ruth", "Martin"),
                      kuchen = sample(c(0, 1), 10, replace = TRUE, prob = c(0.8, 0.2)),
                      getränk = sample(c("Espresso", "Kafi", "Schale", 
                                         "Cappuccino"), 10, replace = TRUE),
                      zucker = sample(c(TRUE, FALSE), 10, replace = TRUE))

df_t2 <- data.frame(name = c("Elisabeth", "Andreas", "Anna", "Peter", "Marco", "Verena"),
                    kuchen = sample(c(0, 1), 6, replace = TRUE, prob = c(0.8, 0.2)),
                    heissgetränk = sample(c("Espresso", "Kafi", "Schale", 
                                            "Tee"), 6, replace = TRUE),
                    zucker = sample(c(TRUE, FALSE), 6, replace = TRUE),
                    stringsAsFactors = FALSE)

# 1. Combine data frames

# Change column names of df_t2
names(df_t2) <- c("person", "kuchen", "getränk", "zucker")
# Create new variable for team membership
df_kafi$team <- 1
df_t2$team <- 2
# Merge data sets
df_comp <- rbind(df_kafi, df_t2)

# 2. Statistics
summary(df_comp)

# 3. Cake
df_thank <- df_comp[df_comp$kuchen == 1, ]
df_thank
class(NA)
age <- c(22, 27, NA, NA, 57, 71, 83)
class(age)
length(age)
age[3]
class(age[3])
is.na(age)
sum(is.na(age))
!is.na(age)
sum(!is.na(age))
ppl <- c("Emma", "Luca", "Mirko", "Nina", "Bernhard", "Erna", "Albrecht")  
plz <- c(3012, 3014, 99, 99, 4051, 4536, 3604)  
veg <- c("Ja", "Ja", NA, "Nein", "Nein", "Nein", "Nein")  
clr <- c("rot", "blau", "gruen", "gruen", "rot", "blau", "blau")  
fan <- c("YB", "FC Breitenrain", "FC Luzern", "Xamax", "YB", "YB", "FC Thun")  
hgt <- c(181, 192, 173, 174, 162, 181, 163)
srv <- data.frame(ppl, plz, veg, clr, fan, hgt) 
str(srv)
srv$ppl <- as.character(srv$ppl)
srv$fan <- as.character(srv$fan)
sum(is.na(srv))
colSums(is.na(srv))
which(is.na(srv))
complete.cases(srv)
