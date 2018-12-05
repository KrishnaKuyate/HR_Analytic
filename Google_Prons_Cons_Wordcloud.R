##Feature extraction & analysis

library(tm)
library(wordcloud)

##Google Prons WordCloud plot
google_pros_corp_word
google_pros_corp_TDM<-TermDocumentMatrix(google_pros_corp_word)
google_pros_corp_mat<-as.matrix(google_pros_corp_TDM)
google_pros_corp_Fre<-sort(rowSums(google_pros_corp_mat),decreasing = TRUE)
google_pros_corp_df<-data.frame(Term=names(google_pros_corp_Fre),Frequencyofword=google_pros_corp_Fre)
wordcloud(google_pros_corp_df$Term,google_pros_corp_df$Frequencyofword,max.words=100,colors=brewer.pal(8, "Dark2"))
##Google top 5 pros fd barchart:
google_pros_corp_df[1:5,]->google_pros_corp_bar
ggplot(google_pros_corp_bar,aes(x=Term,y=Frequencyofword))+geom_point(shape=8,size=10,colour =google_pros_corp_bar$Frequencyofword)+
  ggtitle("Google Prons")

##Google Cons: WordCloud plot
google_cons_corp_word
google_cons_corp_TDM<-TermDocumentMatrix(google_cons_corp_word)
google_cons_corp_mat<-as.matrix(google_cons_corp_TDM)
google_cons_corp_fre<-sort(rowSums(google_cons_corp_mat),decreasing = TRUE)
google_cons_corp_df<-data.frame(Term=names(google_cons_corp_fre),frequencyOfWords=google_cons_corp_fre)
wordcloud(google_cons_corp_df$Term,google_cons_corp_df$frequencyOfWords,max.words=100,colors=brewer.pal(8, "Dark2"))
##Google Top 5 Cons Barchart:
google_cons_corp_df[1:5,]->google_cons_corp_bar
ggplot(google_cons_corp_bar,aes(x=Term,y=frequencyOfWords))+geom_point(shape=10,size=10,colour =google_pros_corp_bar$Frequencyofword)+
  ggtitle("Google Cons")

