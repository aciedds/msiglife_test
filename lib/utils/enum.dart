enum ItemStatus {
  watchList,
  favoriteList;

  @override
  String toString() {
    switch (this) {
      case ItemStatus.watchList:
        return 'Watch List';
      case ItemStatus.favoriteList:
        return 'Favorite List';
    }
  }

  bool isWatchList() => this == ItemStatus.watchList;

  bool isFavoriteList() => this == ItemStatus.favoriteList;
}
