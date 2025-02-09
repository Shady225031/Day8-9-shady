import 'package:flutter/material.dart';
import 'package:day8/web_services/api_service.dart';
import 'package:day8/model/tvshow.dart';
import 'package:day8/screens/tvshow_details.dart';
import 'package:shimmer/shimmer.dart';

class TvShowListPage extends StatefulWidget {
  const TvShowListPage({super.key});

  @override
  State<TvShowListPage> createState() => _TvShowListPageState();
}

class _TvShowListPageState extends State<TvShowListPage> {
  List<TvShow> tvShows = [];
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchTvShows();
  }

  Future<void> fetchTvShows() async {
    setState(() => isLoading = true);
    try {
      tvShows = await ApiService().getTvShows(currentPage);
    } catch (e) {
      showError(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('TV Shows', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? _buildShimmerEffect()
          : tvShows.isEmpty
              ? Center(child: Text("No TV Shows Available"))
              : ListView.builder(
                  itemCount: tvShows.length,
                  itemBuilder: (context, index) {
                    final tvShow = tvShows[index];
                    return _buildTvShowCard(tvShow);
                  },
                ),
    );
  }

  Widget _buildTvShowCard(TvShow tvShow) {
    return ListTile(
      leading: Image.network(
        'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
        width: 80,
        fit: BoxFit.cover,
      ),
      title: Text(tvShow.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(tvShow.overview, maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TvShowDetailsScreen(tvShowId: tvShow.id),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Center(child: CircularProgressIndicator());
  }
}
