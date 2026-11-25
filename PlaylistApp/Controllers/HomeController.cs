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

        // 1. STARTSIDA / INDEX (Vy 1)
        public IActionResult Index()
        {
            var songs = GetSampleSongs();

            ViewBag.Message = "Välkommen till din musikapplikation!";
            ViewData["TotalSongsCount"] = songs.Count;

            return View(songs);
        }

        // 2. DETALJSIDA / DETAILS(Vy 2)
        public IActionResult Details(int id)
        {
            var songs = GetSampleSongs();
            var song = songs.FirstOrDefault(s => s.Id == id);

            if (song == null)
            {
                return NotFound();
            }

            return View(song);
        }

        // 3. FORMULÄRSIDA / CREATE - VISA (Vy 3)
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        // 3. FORMULÄRSIDA - TA EMOT INMATNING
        [HttpPost]
        public IActionResult Create(Song newSong)
        {
            if (ModelState.IsValid)
            {
                return RedirectToAction("Index");
            }

            return View(newSong);
        }
    }
}