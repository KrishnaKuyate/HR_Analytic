#Cluster dendrogram*

##Amazon Prons:
amazon_pros_TDM
amazon_pros_TDM_1<- removeSparseTerms(amazon_pros_TDM,0.993)
amazon_prons_hclust <- hclust(dist(amazon_pros_TDM_1,method="euclidean"),method="complete")
plot(amazon_prons_hclust,main = "Amozon Prons Cluster dendrogram")

##Amazon Cons:
amazon_cons_TDM
amazon_cons_TDM_1<-removeSparseTerms(amazon_cons_TDM,0.993)
amazon_cons_hclust <- hclust(dist(amazon_cons_TDM_1,method="euclidean"),method="complete")
plot(amazon_cons_hclust,main = "Amozon Cons Cluster dendrogram")

##Google Prons:
google_pros_corp_TDM
google_cons_corp_TDM_1<-removeSparseTerms(google_pros_corp_TDM,0.993)
google_prons_hclust <- hclust(dist(google_cons_corp_TDM_1,method="euclidean"),method="complete")
plot(google_prons_hclust,main = "Google Prons Cluster dendrogram")


##Google Cons:
google_cons_corp_TDM
google_cons_corp_TDM_1<-removeSparseTerms(google_cons_corp_TDM,0.993)
google_cons_hclust<- hclust(dist(google_cons_corp_TDM_1,method="euclidean"),method="complete")
plot(google_cons_hclust,main = "Google Cons Cluster dendrogram")
