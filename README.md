# U-Store

## Description : 
U-Store is a cutting-edge online shopping application designed to meet the evolving needs of modern consumers. Built using Swift and SwiftUI, U-Store provides a seamless, fast, and intuitive shopping experience, making it easier than ever to explore and purchase products from various categories. The decision to create an online shopping platform stems from the growing demand for convenience, allowing users to shop anytime and anywhere. By integrating Firebase for real-time authentication and data management, U-Store ensures a secure and efficient system that enhances user trust. The app connects with the Fake Store API, offering users a wide selection of products from clothing to electronics. Online shopping not only saves time but also opens up a world of possibilities, with detailed product information, reviews, and comparisons available at your fingertips. U-Store is designed with user experience in mind, offering a sleek interface that adapts to user behavior, making it both user-friendly and powerful. Whether users want to browse, favorite items, or add products to their cart, U-Store keeps everything simple and accessible. Additionally, the app supports multiple secure payment options, including PayPal and credit cards, catering to a global audience. With its robust MVVM architecture, U-Store is also highly scalable, ensuring smooth performance as it grows.

## Features:
### Sign in with Google and Facebook: 
- U-Store supports easy login and registration via Google and Facebook, allowing users to quickly sign in without creating a new account.

### Access to Bestsellers and Popular Products: 
- The home page features sections for best-selling and popular products, providing users with quick access to top items.

### Category Navigation: 
- From the home page, users can browse through various product categories such as Men's Clothing, Women's Clothing, Electronics, and Jewelry. Upon selecting a category, they are taken to a dedicated screen displaying all products within that category.

### Category Filters: 
- On the category screen, users can filter products by title, price range, or rating, making it easier to find exactly what they're looking for.

### Explore Products: 
- The Explore section allows users to access a comprehensive list of all available products, with advanced filtering options like title, price, and rating to refine their search.

### Add to Favorites: 
Users can mark products as favorites for future reference by clicking a heart icon, making it easier to access desired products later.

### Add to Cart:
- Users can add products to their cart from both product listing and detail pages, with options to increase or decrease quantities directly from the cart.

### Cart Management: 
- In the cart, users can update quantities, remove items, and view product details such as title, price, and quantity. The cart persists across sessions for convenience.

### Multiple Payment Methods: 
- U-Store supports a variety of secure payment methods, including PayPal, SEPA (Single Euro Payments Area), and credit cards, providing flexibility and convenience for users worldwide.

### Easy Navigation Between Screens: 
-The app offers smooth and intuitive navigation, allowing users to move seamlessly between screens such as Home, Explore, Favorites, and Cart.

#### With these features, U-Store offers a comprehensive, user-friendly online shopping experience designed for convenience, security, and flexibility.
  
## Technologies Used
### Programming Language: 
- Swift
### UI Framework: 
- SwiftUI
### Architectural Pattern: 
- MVVM (Model-View-ViewModel)
### Backend Services:
- Firebase Authentication
- Firebase Firestore
- Firebase Storage
### API Integration:
- [Fake Store API](https://fakestoreapi.com/)
  
  
## Getting Started
#### To get started with U-Store, follow these steps:

### 1.Prerequisites
- Xcode 14 or later
- A Firebase project with Firestore and Authentication set up
- Swift 5.7 or later
- Installation
  
### 2.Clone the Repository:

```bash
git clone https://github.com/yourusername/ustore.git
```
### 3.Navigate to the Project Directory:
```bash
cd ustore
```


### 4.Install Dependencies:

-U-Store uses Swift Package Manager for dependency management. Open the project in Xcode, and the necessary packages will be automatically resolved.

### 5.Configure Firebase:

- Download the GoogleService-Info.plist from your Firebase project settings.
- Add the GoogleService-Info.plist file to the root of your Xcode project.
  
### 6.Run the Application:

- Open U-Store.xcodeproj in Xcode, and click the run button to build and launch the app on the simulator or a physical device.

## Usage
### Sign In/Register:
- Use Firebase Authentication to create a new account or sign in with an existing account.
### Browse Products:
- Navigate through categories to view available products.
- Each product includes details such as price, description, and image.
### Add to Cart and Checkout:

- Add products to your cart and proceed to checkout.
- Choose from available payment methods: PayPal, Credit Card, or SEPA.
### Manage Favorites:

- Users can mark products as favorites by clicking the heart icon next to a product.
- Favorite products can be accessed from a dedicated "Favorites" section in the app.
  
## Contributing
- Contributions are welcome! Please follow these steps:

### 1.Fork the Repository:
- Click the "Fork" button on GitHub to create your own copy of the repository.
  
### 2.Create a Feature Branch:

```bash
git checkout -b feature/your-feature

```

### 3.Commit Your Cahnges:
```bash
git commit -am 'Add some feature'

```
```bash
git push origin feature/your-feature
```

### 4.Open a Pull Request:

- Go to the original repository and open a pull request with a description of your changes.

  
 ## Design
<p align="center">
  <img src="https://github.com/user-attachments/assets/eab6efd3-ee51-46a5-a905-c39371864c24" alt="Login" width="200"/>
  <img src="https://github.com/user-attachments/assets/5770d918-c8fd-44cb-9f6f-968eaf50440b" alt="Home" width="200"/>
  <img src="https://github.com/user-attachments/assets/ec22d9a4-30ca-47e9-8c72-d761a3d38bd8" alt="Explore" width="200"/>
  <img src="https://github.com/user-attachments/assets/fc4f5263-5306-4b81-94c0-3e82a29ca1bd" alt="Account" width="200"/>
</p>

## Contact
- For any questions or feedback, please reach out to amirrllotfi@gmail.com.



