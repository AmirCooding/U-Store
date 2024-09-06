# UStore

### Description : 
U-Store is an online shopping application developed using Swift and SwiftUI. It leverages Firebase for authentication and data management, and integrates with the Fake Store API for product information. U-Store offers a sleek and modern interface built on the MVVM architectural pattern, making it both powerful and user-friendly.

# Features

### Authentication:
- Firebase Authentication for user sign-in and registration.
  
### Data Management:
- Firebase Firestore for real-time database storage.
- Firebase Storage for handling media files.

  
### Product Data:
- Integrated with [Fake Store API](https://fakestoreapi.com/) for fetching product information.

### Categories:
- Men's Clothing
- Women's Clothing
- Electronics
- Jewelry
  
### Favorites:
- Users can mark products as favorites to easily access them later.
- 
 ### Add to Cart:
- Users can easily add products to their cart from any product listing or detail page.
- The cart stores multiple items and allows users to view, update, or remove products.
- Products added to the cart will display the item name, price, and quantity.
- The cart is saved between sessions to ensure items remain available for users upon returning.

### Payments:
- PayPal
- Credit Card
- SEPA (Single Euro Payments Area)
  
# Technologies Used
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
  
### Payment Methods: 
- PayPal
- Credit Card
- SEPA
  
### Getting Started
#### To get started with U-Store, follow these steps:

##### 1.Prerequisites
- Xcode 14 or later
- A Firebase project with Firestore and Authentication set up
- Swift 5.7 or later
- Installation
  
#### 2.Clone the Repository:

```bash
git clone https://github.com/yourusername/ustore.git
```
#### Navigate to the Project Directory:
```bash
cd ustore
```


### 3.Install Dependencies:

-U-Store uses Swift Package Manager for dependency management. Open the project in Xcode, and the necessary packages will be automatically resolved.

### 4.Configure Firebase:

- Download the GoogleService-Info.plist from your Firebase project settings.
- Add the GoogleService-Info.plist file to the root of your Xcode project.
### 5.Run the Application:

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

### 5.Open a Pull Request:

- Go to the original repository and open a pull request with a description of your changes.

  
 ## Design

 <img width="308" alt="Screenshot 2024-09-04 at 09 27 13" src="https://github.com/user-attachments/assets/43b966bd-8f36-4ffb-8e84-536963459ba2">

## Contact
- For any questions or feedback, please reach out to amirrllotfi@gmail.com.



