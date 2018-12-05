##Feature extraction & analysis

library(tm)
library(wordcloud)

###Amazon Pros:wordcloud
amazon_pros_corp_word
amazon_pros_TDM<-TermDocumentMatrix(amazon_pros_corp_word)
amazon_pros_mat<-as.matrix(amazon_pros_TDM)

#Take Frequency of every words:
amazon_pros_word_fre<-sort(rowSums(amazon_pros_mat),decreasing = TRUE)
amazon_pros_word_df<-data.frame(term=names(amazon_pros_word_fre),num=amazon_pros_word_fre)

#Wordcloud for amazon Pros:
wordcloud(amazon_pros_word_df$term,amazon_pros_word_df$num,max.words=100,colors=brewer.pal(8, "Dark2"))
 
#barplot
amazon_pros_word_df[1:5,]->amazon_pros_word_bar
ggplot(amazon_pros_word_bar,aes(x=term,y=num,fill=num))+geom_bar(stat = "identity",position="dodge")+xlab("Terms")+ylab("Frequency")+
  ggtitle("Amazons Prons")

###Amazon Cons:WordClod
amazon_cons_corp_word
amazon_cons_TDM<-TermDocumentMatrix(amazon_cons_corp_word)
amazon_cons_mat<-as.matrix(amazon_cons_TDM)

#Take word Frequency :
amazon_cons_word_Fre<-sort(rowSums(amazon_cons_mat),decreasing = TRUE)
amazon_cons_word_df<-data.frame(term=names(amazon_cons_word_Fre),num=amazon_cons_word_Fre)
amazon_cons_word_df[1:5,]->amazon_cons_word_bar


#Wordcloud for amazons  cons
wordcloud(amazon_cons_word_df$term,amazon_cons_word_df$num,max.words=100,colors=brewer.pal(8, "Dark2"))
#Barplot:
ggplot(amazon_cons_word_bar,aes(x=term,y=num,fill=num))+geom_bar(stat = "identity",position="dodge")+xlab("Terms")+ylab("Frequency")+
  ggtitle("Amazons Cons")
