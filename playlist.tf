# name and tracks are required parameters
# description, id and public are optional

data "spotify_search_track" "beethoven" {
    artist = "Ludwig van Beethoven"
    limit = 50
}

resource "spotify_playlist" "beethoven_playlist" {
    name   = "Ludwig van Terraform"
    tracks = slice(data.spotify_search_track.beethoven.tracks[*].id, 0, 50)
}
