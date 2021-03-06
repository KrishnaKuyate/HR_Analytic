##Combined

##Data Load and dataset structures:


###Data Load:
library(readr)
google <- read_csv("google.csv")
View(google)
amazon <- read_csv("amazon.csv")
View(amazon)


###Unserstand the dataset structure:
##Google:
#Structure
str(google)
#No. of variables:
ncol(google)
#No.of observations:
nrow(google)
#Variables name of dataset:
colnames(google)
#Summary:
summary(google)

##amazon:
#structure:
str(amazon)
#No.of variables:
ncol(amazon)
#Variables Name:
colnames(amazon)
#No. of obesarvations:
nrow(amazon)
#Summary
summary(amazon)


##Variable Defined:
#Amazons
amazon_pros<-amazon$pros
amazon_cons<-amazon$cons
#Google:
google_pros<-google$pros
google_cons<-google$cons



##Data Cleanup
install.packages("qdap")
library(qdapDictionaries)
library(qdapRegex)
library(qdapTools)


install.packages("tm")
library(tm)
library(NLP)

rm_clean<- function(x)
{
  x<-na.omit(x)
  x<-rm_abbreviation(x)
  x<-rm_bracket(x, pattern = "all")
  x<-rm_date(x)
  x<-rm_date(x, pattern="@rm_date2")
  x<-rm_date(x, pattern="@rm_date3")
  x<-rm_date(x, pattern="@rm_date4")
  x<-rm_time(x)
  x<-rm_phone(x)
  x<-rm_number(x)
  x<-rm_email(x)
  x<-rm_dollar(x)
  x<-rm_percent(x)
  x<-rm_city_state_zip(x)
  x<-rm_zip(x)
  x<-rm_postal_code(x)
  x<-rm_hash(x)
  x<-rm_white_bracket(x)
  x<-rm_white_colon(x)
  x<-rm_white_comma(x)
  x<-rm_white_endmark(x)
  x<-rm_white_punctuation (x)
  x<-rm_white_endmark(x)
  x<-rm_white_lead(x)
  x<-rm_white_lead_trail(x)
  x<-rm_white_multiple(x)
  x<-rm_white_punctuation(x)
  x<-rm_white_trail(x)
  x<-rm_url(x)
  x<-rm_emoticon(x)
  x<-rm_tag(x)
  x<-tolower(x)
  
}

###Removed  unwanted things -File Cleanup
#Amazons
amazon_pros_rm<-rm_clean(amazon_pros)
amazon_cons_rm<-rm_clean(amazon_cons)
#Google:
google_pros_rm<-rm_clean(google_pros)
google_cons_rm<-rm_clean(google_cons)

VCorpus(VectorSource(amazon_pros_rm))->amazon_pros_corp
VCorpus(VectorSource(amazon_cons_rm))->amazon_cons_corp
VCorpus(VectorSource(google_pros_rm))->google_pros_corp
VCorpus(VectorSource(google_cons_rm))->google_cons_corp

##Words cleanup

word_clean<-function(y)
{
  y<-tm_map(y,removeWords,stopwords("en"))
  y<-tm_map(y,removeWords,c("and","the","our","that","for","are","also","more","has","must","have","should","this","with","it","is","some","of","there","to","it's"))
  y<-tm_map(y,removeWords,c("amazon","google","company"))
  
}

amazon_pros_corp_word<-word_clean(amazon_pros_corp)
amazon_cons_corp_word<-word_clean(amazon_cons_corp)
google_pros_corp_word<-word_clean(google_pros_corp)
google_cons_corp_word<-word_clean(google_cons_corp)

##Feature extraction & analysis

library(tm)
library(wordcloud)

##Google Pros WordCloud plot
google_pros_corp_word
google_pros_corp_TDM<-TermDocumentMatrix(google_pros_corp_word)
google_pros_corp_mat<-as.matrix(google_pros_corp_TDM)
google_pros_corp_Fre<-sort(rowSums(google_pros_corp_mat),decreasing = TRUE)
google_pros_corp_df<-data.frame(Term=names(google_pros_corp_Fre),Frequencyofword=google_pros_corp_Fre)
wordcloud(google_pros_corp_df$Term,google_pros_corp_df$Frequencyofword,max.words=100,colors=brewer.pal(8, "Dark2"))
##Google top 5 pros fd barchart:
google_pros_corp_df[1:5,]->google_pros_corp_bar
ggplot(google_pros_corp_bar,aes(x=Term,y=Frequencyofword))+geom_point(shape=8,size=10,colour =google_pros_corp_bar$Frequencyofword)+
  ggtitle("Google Pros")

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
  ggtitle("Amazons Pros")

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


#Cluster dendrogram*

##Amazon Pros:
amazon_pros_TDM
amazon_pros_TDM_1<- removeSparseTerms(amazon_pros_TDM,0.993)
amazon_prons_hclust <- hclust(dist(amazon_pros_TDM_1,method="euclidean"),method="complete")
plot(amazon_prons_hclust,main = "Amozon Pros Cluster dendrogram")

##Amazon Cons:
amazon_cons_TDM
amazon_cons_TDM_1<-removeSparseTerms(amazon_cons_TDM,0.993)
amazon_cons_hclust <- hclust(dist(amazon_cons_TDM_1,method="euclidean"),method="complete")
plot(amazon_cons_hclust,main = "Amozon Cons Cluster dendrogram")

##Google Pros:
google_pros_corp_TDM
google_cons_corp_TDM_1<-removeSparseTerms(google_pros_corp_TDM,0.993)
google_prons_hclust <- hclust(dist(google_cons_corp_TDM_1,method="euclidean"),method="complete")
plot(google_prons_hclust,main = "Google Pros Cluster dendrogram")


##Google Cons:
google_cons_corp_TDM
google_cons_corp_TDM_1<-removeSparseTerms(google_cons_corp_TDM,0.993)
google_cons_hclust<- hclust(dist(google_cons_corp_TDM_1,method="euclidean"),method="complete")
plot(google_cons_hclust,main = "Google Cons Cluster dendrogram")


###Google Pros - Cons Comparisons word cloud
all_google_pros <- paste(google$pros,collapse="")
all_google_cons <- paste(google$cons,collapse = "")
all_google <- c(all_google_pros,all_google_cons)
all_google_qdap <- rm_clean(all_google)
all_google_vs <- VectorSource(all_google_qdap) 
all_google_vc <- VCorpus(all_google_vs)
all_google_clean<- word_clean(all_google_vc)
all_google_tdm <- TermDocumentMatrix(all_google_clean)
colnames(all_google_tdm) <- c("Google Pros","Google Cons")
all_google_tdm_m <- as.matrix(all_google_tdm)
comparison.cloud(all_google_tdm_m,colors = c("orange","blue"),max.words = 50)


###Amazons Pros -cons 
all_am_p<-paste(amazon$pros,collapse = "")
all_am_c<-paste(amazon$cons,collapse = "")
all_amazona<-c(all_am_p,all_am_c)
all_amazon_clean<-rm_clean(all_amazona)
all_amazon_vs <- VectorSource(all_amazon_clean) 
all_amazon_vc <- VCorpus(all_amazon_vs)
all_amazon_vcclean<- word_clean(all_amazon_vc)
all_amazon_tdm <- TermDocumentMatrix(all_amazon_vcclean)
colnames(all_amazon_tdm) <- c("Amazon Pros","Amazons Cons")
all_amazon_tdm_m <- as.matrix(all_amazon_tdm)
comparison.cloud(all_amazon_tdm_m,colors = c("orange","blue"),max.words = 50)





