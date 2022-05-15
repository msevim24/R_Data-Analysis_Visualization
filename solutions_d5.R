###############################################
# Introduction to R for social sciences       #
# Solutions day 5                             #
###############################################

###################
# Visualizations I

# 1. Scatterplot
ggplot(data = moviedb) +
  geom_point(mapping = aes(x = facenumber_in_poster, y = imdb_score)) +
  geom_smooth(mapping = aes(x = facenumber_in_poster, y = imdb_score),
              method = "auto", se = TRUE, level = 0.95)

# gam = generalized additive model
# se = Confidence Interval

# 2. Barplot
moviedb_bar <- moviedb %>%
  select(actor_1_name, actor_2_name, actor_3_name, genres) %>%
  gather(key = "act_nr", value = "actor_name", -genres) %>%
  filter(!is.na(actor_name)) %>%
  filter(str_detect("Romance", genres)) %>%
  group_by(actor_name) %>%
  summarise(app = n()) %>%
  arrange(desc(app)) %>%
  slice(1:10) %>%
  mutate(order = as.numeric(rownames(.)))

ggplot(data = moviedb_bar) +
  geom_bar(mapping = aes(x = reorder(actor_name, order),
                         y = app),
           stat = "identity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.title.x = element_blank())

# 3. Boxplot
moviedb_cr <- moviedb %>%
  filter(content_rating %in% c("G", "PG", "PG-13", "R", "NC-17")) %>%
  mutate(order = case_when(content_rating == "G" ~ 1,
                           content_rating == "PG" ~ 2,
                           content_rating == "PG-13" ~ 3,
                           content_rating == "R" ~ 4,
                           content_rating == "NC-17" ~ 5))

ggplot(data = moviedb_cr) +
  geom_boxplot(mapping = aes(x = reorder(content_rating, order), 
                             y = imdb_score))

####################
# Visualizations II

# 2. Barplot
ranks <- moviedb %>%
  select(actor_1_name, actor_2_name, actor_3_name) %>%
  gather(key = "act_nr", value = "actor_name") %>%
  filter(!is.na(actor_name)) %>%
  group_by(actor_name) %>%
  summarise(app = n()) %>%
  arrange(desc(app)) %>%
  slice(1:20) %>% 
  mutate(rank = as.numeric(rownames(.))) %>%
  select(-app)
moviedb_bar <- moviedb %>%
  select(actor_1_name, actor_2_name, actor_3_name, genres) %>%
  gather(key = "act_nr", value = "actor_name", -genres) %>%
  filter(!is.na(actor_name)) %>%
  separate(genres, into = "genre", sep = "\\|", extra = "drop") %>%
  group_by(actor_name, genre) %>%
  summarise(app = n()) %>%
  ungroup() %>%
  spread(genre, app) %>%
  mutate(total_app = rowSums(select_if(., is.numeric), na.rm = TRUE)) %>%
  arrange(desc(total_app)) %>%
  slice(1:20) %>%
  select(-total_app) %>%
  gather(key = "genre", value = "app", -actor_name) %>%
  filter(!is.na(app)) %>%
  left_join(ranks, by = "actor_name")

ggplot(data = moviedb_bar) +
  geom_bar(mapping = aes(x = reorder(actor_name, rank),
                         y = app,
                         fill = genre),
           stat = "identity") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.title.x = element_blank()) +
  labs(y = "Anzahl Filme", fill = "Genre")