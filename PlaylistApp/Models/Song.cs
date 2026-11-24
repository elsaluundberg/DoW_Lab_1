namespace PlaylistApp.Models
{
    public class Song
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public int Length { get; set; } // Låtens längd i sekunder

        // Koppling till vilket album låten tillhör (N:1-relation)
        public int AlbumId { get; set; }
        public Album? Album { get; set; }
    }
}