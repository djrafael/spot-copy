import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Seção 1 - Ícone de usuário com botões
                TitleSection(),
                // Adicionando padding entre header e artistas
                SizedBox(height: 16), // Padding entre o header e os artistas
                // Seção 2 - Artistas
                ArtistGrid(),
                // Seção 3 - Novo lançamento
                NewReleaseSection(),
                // Seção 4 - Playlists recomendadas
                RecommendedPlaylists(),
                SizedBox(height: 32), // Maior espaçamento abaixo das playlists
              ],
            ),
          ),
          // Seção 5 - Miniplayer com a música "Misery Business"
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Miniplayer(),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}

// Seção 1: Título e ícones de usuário
class TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.white.withOpacity(0.1)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ícone de usuário e botões redondos com fundo cinza e efeito de hover verde
          Row(
            children: [
              Icon(Icons.account_circle, color: Colors.white, size: 32),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () {}, // Funcionalidade ao clicar pode ser adicionada
                child: MouseRegion(
                  onEnter: (_) {
                    // Ao passar o mouse, o fundo fica verde
                  },
                  onExit: (_) {
                    // Retorna à cor cinza ao sair
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF404040), // Cor cinza do fundo
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text("Tudo",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        SizedBox(width: 8),
                        Text("Música",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        SizedBox(width: 8),
                        Text("Podcast",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Seção 2: Grid com artistas
class ArtistGrid extends StatelessWidget {
  final List<Artist> artists = [
    Artist('Linkin Park',
        'https://upload.wikimedia.org/wikipedia/pt/2/23/Linkin_Park_Hybrid_Theory.jpg'),
    Artist('Pink Floyd',
        'https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png'),
    Artist('Jorge Ben Jor',
        'https://upload.wikimedia.org/wikipedia/pt/a/a2/A_T%C3%A1bua_de_Esmeralda.jpg'),
    Artist('Fleetwood Mac',
        'https://upload.wikimedia.org/wikipedia/en/b/b1/Fleetwood_Mac_-_Fleetwood_Mac_%281975%29.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width *
              0.05), // Padding de 5% da largura
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.0,
        ),
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return ArtistCard(artist: artists[index]);
        },
      ),
    );
  }
}

// Model de artista para representar os dados de cada card
class Artist {
  final String name;
  final String imageUrl;

  Artist(this.name, this.imageUrl);
}

// Card de artista individual
class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Padding esquerdo da imagem dos artistas
          Padding(
            padding:
                const EdgeInsets.only(left: 12), // Padding esquerdo de 12px
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                artist.imageUrl,
                fit: BoxFit.cover,
                height: 50, // Ajustado
                width: 50, // Ajustado
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(artist.name, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// Seção 3: Novo lançamento
class NewReleaseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/pt/9/97/Linkin_Park_-_From_Zero.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Linkin Park',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Novo Lançamento', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          AlbumCard(),
        ],
      ),
    );
  }
}

// Card do álbum com a imagem, nome da música, artista, e botões
class AlbumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.network(
            'https://upload.wikimedia.org/wikipedia/pt/9/97/Linkin_Park_-_From_Zero.jpg',
            fit: BoxFit.cover,
            height: 180,
            width: double.infinity,
          ),
          Positioned(
            bottom: 10,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Two Face',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                Text('Single • Linkin Park',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 16,
            child: Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.white),
                SizedBox(width: 16),
                Icon(Icons.play_arrow, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Seção 4: Playlists recomendadas
class RecommendedPlaylists extends StatelessWidget {
  final List<Playlist> playlists = [
    Playlist('Playlist 1',
        'https://upload.wikimedia.org/wikipedia/commons/7/7f/8_Bits_-_Wallpaper.jpg'),
    Playlist('Playlist 2',
        'https://upload.wikimedia.org/wikipedia/commons/5/55/Neon_Lights_Wallpaper.jpg'),
    Playlist('Playlist 3',
        'https://upload.wikimedia.org/wikipedia/commons/a/a9/Sunset_background_wallpaper.jpg'),
    Playlist('Playlist 4',
        'https://upload.wikimedia.org/wikipedia/commons/9/95/Forest_Silhouettes_Background.jpg'),
    Playlist('Playlist 5',
        'https://upload.wikimedia.org/wikipedia/pt/9/97/Linkin_Park_-_From_Zero.jpg'),
    Playlist('Playlist 6',
        'https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.0,
        ),
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return PlaylistCard(playlist: playlists[index]);
        },
      ),
    );
  }
}

// Model de Playlist
class Playlist {
  final String title;
  final String imageUrl;

  Playlist(this.title, this.imageUrl);
}

// Card de Playlist
class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              playlist.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 120,
            ),
          ),
          SizedBox(height: 8),
          Text(playlist.title, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// Seção 5: Miniplayer
class Miniplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/pt/9/97/Linkin_Park_-_From_Zero.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Two Face',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              Text('Linkin Park',
                  style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.play_arrow, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// Menu inferior
class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: 'Library',
        ),
      ],
    );
  }
}
