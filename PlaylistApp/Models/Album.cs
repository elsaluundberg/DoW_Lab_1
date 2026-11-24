namespace PlaylistApp.Models
{
    public class Album
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;

        // I C# kan vi hålla en lista över låtarna som tillhör albumet
        public List<Song> Songs { get; set; } = new List<Song>();
    }
}