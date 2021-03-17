import imdb

moviesDB = imdb.IMDb()

# Help?
print(*dir(moviesDB), sep='\n')

# ---------------------------------------------------
# 1) Search for a title
searchstr = 'thin red'
movies = moviesDB.search_movie(searchstr)

# Help?
print(*movies[0].keys(), sep='\n')

print(f'Searching for "searchstr":')
for movie in movies:
    title = movie['title']
    year = movie['year']
    print(f'{title} - {year}')

# ---------------------------------------------------
# 1) List movie info
movies[0].getID()
movie = moviesDB.get_movie(id)

title = movie['title']
year = movie['year']
rating = movie['rating']
directors = movie['directors']
stitle = movie['smart canonical title']

print('Movie info:')
print(f'{title} - {year}')
print(f'rating: {rating}')
directStr = ' '.join(map(str, directors))
print(f'directors: {directors}')
actors = ' '.join(map(str, ))
print(f': {rating}')
print(f'rating: {rating}')
