import xml.etree.ElementTree as ET

# Načtení XML souboru
def load_playlist("C:\Users\misas\Desktop\XML semestrálka\playlist.xml"):
    try:
        tree = ET.parse("C:\Users\misas\Desktop\XML semestrálka\playlist.xml")
        return tree
    except Exception as e:
        print(f"Error loading file: {e}")
        return None

# Zobrazení všech skladeb
def display_songs(tree):
    root = tree.getroot()
    for song in root.findall("song"):
        title = song.find("title").text
        artist = song.find("artist").text
        genre = song.find("genre").text
        length = song.find("length").text
        print(f"Title: {title}, Artist: {artist}, Genre: {genre}, Length: {length}")

# Vyhledávání skladeb podle kritéria
def search_songs(tree, key, value):
    root = tree.getroot()
    results = [song for song in root.findall("song") if song.find(key) is not None and song.find(key).text == value]
    for song in results:
        title = song.find("title").text
        artist = song.find("artist").text
        genre = song.find("genre").text
        length = song.find("length").text
        print(f"Title: {title}, Artist: {artist}, Genre: {genre}, Length: {length}")
    if not results:
        print("No songs found.")

# Přidání nové skladby
def add_song(tree):
    root = tree.getroot()

    title = input("Enter song title: ")
    artist = input("Enter artist name: ")
    genre = input("Enter genre: ")
    length = input("Enter length (e.g., 3:45): ")

    new_song = ET.Element("song")
    ET.SubElement(new_song, "title").text = title
    ET.SubElement(new_song, "artist").text = artist
    ET.SubElement(new_song, "genre").text = genre
    ET.SubElement(new_song, "length").text = length

    root.append(new_song)
    print("Song added successfully!")

# Uložení změn zpět do XML souboru
def save_playlist(tree, file_path):
    try:
        tree.write(file_path, encoding="utf-8", xml_declaration=True)
        print("Playlist saved successfully!")
    except Exception as e:
        print(f"Error saving file: {e}")

# Hlavní funkce
def main():
    file_path = "playlist.xml"
    tree = load_playlist(file_path)

    if tree is None:
        return

    while True:
        print("\nMenu:")
        print("1. Display all songs")
        print("2. Search songs by criteria")
        print("3. Add a new song")
        print("4. Save and exit")

        choice = input("Choose an option: ")

        if choice == "1":
            display_songs(tree)
        elif choice == "2":
            key = input("Search by (title/artist/genre): ").strip().lower()
            value = input(f"Enter {key}: ").strip()
            search_songs(tree, key, value)
        elif choice == "3":
            add_song(tree)
        elif choice == "4":
            save_playlist(tree, file_path)
            break
        else:
            print("Invalid option. Please try again.")

if __name__ == "__main__":
    main()
