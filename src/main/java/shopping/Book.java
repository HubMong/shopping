package shopping;

public class Book {
    private int id;
    private String title;
    private int price;
    private String imagePath;

    public Book(int id, String title, int price, String imagePath) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.imagePath = imagePath;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public int getPrice() {
        return price;
    }

    public String getImagePath() {
        return imagePath;
    }
}
