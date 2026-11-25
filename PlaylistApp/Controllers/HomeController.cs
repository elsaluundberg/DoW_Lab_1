using Microsoft.AspNetCore.Mvc;
using PlaylistApp.Models;

namespace PlaylistApp.Controllers
{
    public class HomeController : Controller
    {
        // Testdata
        private List<Song> GetSampleSongs()
        {
            return new List<Song>
            {
                new Song { Id = 1, Name = "Levitating", Length = 203, ArtistName = "Dua Lipa", AlbumName = "Future Nostalgia" },
                new Song { Id = 2, Name = "Don't Start Now", Length = 183, ArtistName = "Dua Lipa", AlbumName = "Future Nostalgia" },
                new Song { Id = 3, Name = "Save Your Tears", Length = 215, ArtistName = "The Weeknd", AlbumName = "After Hours" }
            };
        }

        // 1. STARTSIDA / ÖVERSIKT (Vy 1)
        public IActionResult Index()
        {
            var songs = GetSampleSongs();

            ViewBag.Message = "Välkommen till din musikapplikation!";
            ViewData["TotalSongsCount"] = songs.Count;

            return View(songs);
        }

    }
}