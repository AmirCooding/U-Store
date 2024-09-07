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
  
### List of Favorites:
- Users can mark products as favorites to easily access them later.

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
  
## Getting Started
#### To get started with U-Store, follow these steps:

#### 1.Prerequisites
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


#### 3.Install Dependencies:

-U-Store uses Swift Package Manager for dependency management. Open the project in Xcode, and the necessary packages will be automatically resolved.

#### 4.Configure Firebase:

- Download the GoogleService-Info.plist from your Firebase project settings.
- Add the GoogleService-Info.plist file to the root of your Xcode project.
#### 5.Run the Application:

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

#### 1.Fork the Repository:
- Click the "Fork" button on GitHub to create your own copy of the repository.
  
#### 2.Create a Feature Branch:

```bash
git checkout -b feature/your-feature

```

#### 3.Commit Your Cahnges:
```bash
git commit -am 'Add some feature'

```
```bash
git push origin feature/your-feature
```

#### 4.Open a Pull Request:

- Go to the original repository and open a pull request with a description of your changes.

  
 ## Design
![Login](https://github.com/user-attachments/assets/54da62c1-aa0f-4762-8c3b-b6f37d31a064)
![Home](https://github.com/user-attachments/assets/354bde78-0096-4b39-9039-b004549d9005)
![Explore](https://github.com/user-attachments/assets/b8d316bb-9af6-425f-bcaf-65d3166a63be)
 ![Account](https://github.com/user-attachments/assets/b405fe0b-6e6c-4aab-8b80-2c5bccf06a30)


## Contact
- For any questions or feedback, please reach out to amirrllotfi@gmail.com.



