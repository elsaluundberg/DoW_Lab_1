using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using PlaylistApp.Models;

namespace PlaylistApp.Controllers
{
    public class HomeController : Controller
    {
        private const string SessionKey = "UserSongList";

        // Hjälpmetod för att hämta låtarna från Session (eller skapa startdata om det är första besöket)
        private List<Song> GetSongsFromSession()
        {
            var json = HttpContext.Session.GetString(SessionKey);

            if (string.IsNullOrEmpty(json))
            {
                // Startlåtar 
                var initialSongs = new List<Song>
                {
                    new Song { Id = 1, Name = "Levitating", Length = 203, ArtistName = "Dua Lipa", AlbumName = "Future Nostalgia" },
                    new Song { Id = 2, Name = "Don't Start Now", Length = 183, ArtistName = "Dua Lipa", AlbumName = "Future Nostalgia" },
                    new Song { Id = 3, Name = "Save Your Tears", Length = 215, ArtistName = "The Weeknd", AlbumName = "After Hours" }
                };

                SaveSongsToSession(initialSongs);
                return initialSongs;
            }

            return JsonSerializer.Deserialize<List<Song>>(json) ?? new List<Song>();
        }

        // Hjälpmetod för att spara låtlistan till Session
        private void SaveSongsToSession(List<Song> songs)
        {
            var json = JsonSerializer.Serialize(songs);
            HttpContext.Session.SetString(SessionKey, json);
        }

        // 1. STARTSIDA / INDEX (Vy 1)
        public IActionResult Index()
        {
            var songs = GetSongsFromSession();

            ViewBag.Message = "Välkommen till din musikapplikation!";
            ViewData["TotalSongsCount"] = songs.Count;

            return View(songs);
        }

        // 2. DETALJSIDA / DETAILS (Vy 2)
        public IActionResult Details(int id)
        {
            var songs = GetSongsFromSession();
            var song = songs.FirstOrDefault(s => s.Id == id);

            if (song == null)
            {
                return NotFound();
            }

            return View(song);
        }

        // 3. FORMULÄRSIDA / CREATE (Vy 3)
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        // 3. FORMULÄRSIDA - TA EMOT INMATNING OCH SPARA I SESSION
        [HttpPost]
        public IActionResult Create(Song newSong)
        {
            if (ModelState.IsValid)
            {
                var songs = GetSongsFromSession();

                // Generera automatiskt ett nytt unikt ID
                newSong.Id = songs.Any() ? songs.Max(s => s.Id) + 1 : 1;

                // Lägg till den nya låten i listan
                songs.Add(newSong);

                // Spara den uppdaterade listan tillbaka i Sessionen
                SaveSongsToSession(songs);

                return RedirectToAction("Index");
            }

            return View(newSong);
        }
    }
}