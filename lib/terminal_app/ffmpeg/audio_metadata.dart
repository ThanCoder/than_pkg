class AudioMetadata {
  final String? artist;
  final String? title;
  final String? album;
  final String? genre;
  final String? comment;
  final String? date;
  AudioMetadata({
    this.artist,
    this.title,
    this.album,
    this.genre,
    this.comment,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'artist': artist,
      'title': title,
      'album': album,
      'genre': genre,
      'comment': comment,
      'date': date,
    };
  }

  factory AudioMetadata.fromMap(Map<String, dynamic> map) {
    return AudioMetadata(
      artist: map['artist'] != null ? map['artist'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      album: map['album'] != null ? map['album'] as String : null,
      genre: map['genre'] != null ? map['genre'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  AudioMetadata copyWith({
    String? artist,
    String? title,
    String? album,
    String? genre,
    String? comment,
    String? date,
  }) {
    return AudioMetadata(
      artist: artist ?? this.artist,
      title: title ?? this.title,
      album: album ?? this.album,
      genre: genre ?? this.genre,
      comment: comment ?? this.comment,
      date: date ?? this.date,
    );
  }
}

/**
 * Output example:
// {
//   "title": "Love Song",
//   "artist": "Than Coder",
//   "album": "Code Beats",
//   "genre": "Lo-Fi",
//   "date": "2025"
// } 
// */
