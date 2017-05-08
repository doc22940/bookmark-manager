using Granite.Widgets;

namespace BookmarkManager {
public class Bookmarks : Gtk.ListBox{

    construct{
        expand = true;    
    }

   public string[,] getBookmarks (){
        var bookmarksCount = countBookmarks();
        string[,] bookmarks = new string[bookmarksCount,2];

        var file = File.new_for_path (Environment.get_home_dir () + "/.ssh/config");

        if (!file.query_exists ()) {
            stderr.printf ("File '%s' doesn't exist.\n", file.get_path ());
            return bookmarks;
        }
        
        try {
            // Open file for reading and wrap returned FileInputStream into a
            // DataInputStream, so we can read line by line
            var dis = new DataInputStream (file.read ());
            string line;
            int i = 0;
            // Read lines until end of file (null) is reached        
            while ((line = dis.read_line (null)) != null) {
                if("host" in line ){
                    string line_new = line.replace ("host", "");
                    string line_newest = line_new.replace (" ", "");
                    bookmarks[i,1] = line_newest;
                }

                if("HostName" in line ){
                    string line_new = line.replace ("HostName", "");
                    string line_newest = line_new.replace (" ", "");                
                    bookmarks[i,2] = line_newest;
                    i++;
                }
            }
            
           return bookmarks;

        } catch (Error e) {
            error ("%s", e.message);
        }
    }

    public int countBookmarks (){
        int count = 0;
        
         // A reference to our file
        string path = Environment.get_home_dir ();
        var file = File.new_for_path (path + "/.ssh/config");

        try {
            // Open file for reading and wrap returned FileInputStream into a
            // DataInputStream, so we can read line by line
            var dis = new DataInputStream (file.read ());
            string line;
            // Read lines until end of file (null) is reached        
            while ((line = dis.read_line (null)) != null) {
                if("host" in line ){
                    count++;
                }
            }
           return count;

        } catch (Error e) {
            error ("%s", e.message);
        }
    }
} 
}
