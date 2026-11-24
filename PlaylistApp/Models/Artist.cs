namespace PlaylistApp.Models
{
    public class Artist
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;

        // Många-till-många-relation skrivs i C# direkt som en lista
        public List<Song> Songs { get; set; } = new List<Song>();
    }
}