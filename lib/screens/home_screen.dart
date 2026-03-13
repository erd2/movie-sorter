import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Movie> _allMovies = [
    Movie(
      title: "Inception",
      genre: "Action",
      year: 2010,
      posterUrl: "https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=500&auto=format&fit=crop",
      duration: "2h 28m",
      rating: 8.8,
    ),
    Movie(
      title: "The Hangover",
      genre: "Comedy",
      year: 2009,
      posterUrl: "https://images.unsplash.com/photo-1585647347384-2593bc35786b?q=80&w=500&auto=format&fit=crop",
      duration: "1h 40m",
      rating: 7.7,
    ),
    Movie(
      title: "Titanic",
      genre: "Drama",
      year: 1997,
      posterUrl: "https://images.unsplash.com/photo-1500077423678-25eead48513a?q=80&w=500&auto=format&fit=crop",
      duration: "3h 14m",
      rating: 7.9,
    ),
    Movie(
      title: "The Conjuring",
      genre: "Horror",
      year: 2013,
      posterUrl: "https://images.unsplash.com/photo-1509248961158-e54f6934749c?q=80&w=500&auto=format&fit=crop",
      duration: "1h 52m",
      rating: 7.5,
    ),
    Movie(
      title: "Interstellar",
      genre: "Action",
      year: 2014,
      posterUrl: "https://images.unsplash.com/photo-1614728263952-84ea256f9679?q=80&w=500&auto=format&fit=crop",
      duration: "2h 49m",
      rating: 8.7,
    ),
    Movie(
      title: "Superbad",
      genre: "Comedy",
      year: 2007,
      posterUrl: "https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=500&auto=format&fit=crop",
      duration: "1h 53m",
      rating: 7.6,
    ),
  ];

  String _selectedGenre = 'All';
  String _searchQuery = '';
  double _minRating = 0.0;
  final List<String> _genres = ['All', 'Action', 'Comedy', 'Drama', 'Horror'];

  @override
  Widget build(BuildContext context) {
    final filteredMovies = _allMovies.where((movie) {
      final matchesGenre = _selectedGenre == 'All' || movie.genre == _selectedGenre;
      final matchesSearch = movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesRating = movie.rating >= _minRating;
      return matchesGenre && matchesSearch && matchesRating;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Movie Sorter Pro', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by title...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Genre:', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedGenre,
                          isExpanded: true,
                          items: _genres.map((String genre) {
                            return DropdownMenuItem<String>(
                              value: genre,
                              child: Text(genre),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGenre = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text('Min Rating:', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(width: 8),
                    Text(_minRating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
                Slider(
                  value: _minRating,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  label: _minRating.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _minRating = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: filteredMovies.isEmpty
                ? const Center(child: Text('No movies found'))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: filteredMovies[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
