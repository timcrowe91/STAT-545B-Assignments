words <- readLines("words.txt")
total_words <- length(words)

letters_df <- data.frame(letters)
letters_df <- cbind(proportion = 0, letters_df)

for (i in 1:26){
  
  letters_df$proportion[i] = sum(grepl(letters_df$letters[i], words)) / total_words
  
}

library(ggplot2)

letters_plot <- ggplot(data = letters_df, aes(x = letters, y = proportion)) +
  geom_bar(stat = "identity") +
  labs(x = "Letter", y = "% of Words") +
  theme_bw()

ggsave("letters.png", letters_plot)
