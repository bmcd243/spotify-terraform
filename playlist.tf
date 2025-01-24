# name and tracks are required parameters
# description, id and public are optional

resource "spotify_playlist" "beethoven_playlist" {
    name = "Ludwig van Terraform"
    tracks = ["01TdXKiAvguDxABvNWW2pw"]
}

data "spotify_search_track"