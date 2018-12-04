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


