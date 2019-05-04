from sklearn.cluster import KMeans

# Apply K-Means model
def kmeans(tfidf_matrix, num)
    num_clusters = num
    km = KMeans(n_clusters=num_clusters)
    km.fit(tfidf_matrix)
    clusters = km.labels_.tolist()
    return clusters
