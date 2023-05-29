# Opis projektu
Ten projekt składa się z schematu bazy danych SQL oraz powiązanych skryptów dla fikcyjnego sklepu internetowego. Schemat bazy danych zawiera tabele do przechowywania informacji o klientach, zamówieniach, produktach, kategoriach, miastach, krajach i statusach zamówień. Zawiera również widoki i funkcję zdefiniowaną przez użytkownika w celu ułatwienia pobierania danych i wykonywania obliczeń.

## Schemat bazy danych
Schemat bazy danych zawiera następujące tabele:
- Client: Przechowuje informacje o klientach, takie jak imię, nazwisko, dane kontaktowe i adres.
- Orders: Przechowuje informacje o zamówieniach składanych przez klientów, w tym identyfikator zamówienia, identyfikator klienta, datę faktury, status zamówienia i całkowitą kwotę.
- Detail_Order: Zawiera szczegóły każdego zamówienia, w tym identyfikator produktu, identyfikator zamówienia i ilość.
- Products: Przechowuje informacje o produktach dostępnych w sklepie, w tym identyfikator produktu, nazwę, cenę, kategorię i ilość w magazynie.
- Category: Przechowuje informacje o kategoriach produktów, w tym identyfikator kategorii, nazwę i opis.
- City: Przechowuje informacje o miastach, w tym identyfikator miasta, nazwę i kod pocztowy.
- Country: Przechowuje informacje o krajach, w tym identyfikator kraju, nazwę i kod kraju.
- Status: Przechowuje informacje o statusach zamówień, w tym identyfikator statusu i nazwę.

## Widoki
Projekt zawiera kilka widoków, które umożliwiają wygodne pobieranie danych z bazy danych:
- OrdersWithDetails: Łączy dane z tabel Orders, Detail_Order i Products, aby zapewnić kompleksowy widok zamówień wraz z powiązanymi produktami i ilościami.
- ClientOrders: Prezentuje widok zamówień dokonanych przez poszczególnych klientów, w tym imię klienta, nazwisko, nazwę produktu, ilość i całkowitą kwotę.
- ProductStock: Wyświetla aktualne informacje o stanie magazynowym dla każdego produktu, w tym identyfikator produktu, nazwę i ilość.

## Funkcje
Projekt zawiera funkcję zdefiniowaną przez użytkownika o nazwie CalcuClientTotalOrderValue. Funkcja ta przyjmuje identyfikator klienta jako argument wejściowy i oblicza całkowitą wartość zamówienia dla tego klienta. Pobiera sumę pola total_amount z tabeli Orders dla określonego klienta.

## Procedura składowana
Projekt zawiera procedurę składowaną o nazwie GetClientsByCategory. Procedura ta przyjmuje identyfikator kategorii jako argument wejściowy i pobiera informacje o klientach, którzy złożyli zamówienia na produkty w tej kategorii. Wykonuje połączenia między tabelami Client, Orders, Detail_Order i Products, aby pobrać wymagane dane.

---

# Project Description
This project consists of a SQL database schema and associated scripts for a fictional online shop. The database schema includes tables for storing information about clients, orders, products, categories, cities, countries, and order statuses. It also includes views and a user-defined function to facilitate data retrieval and calculations.

## Database Schema
The database schema includes the following tables:
- Client: Stores information about clients, such as their name, last name, contact details, and address.
- Orders: Stores information about orders placed by clients, including the order ID, client ID, invoice date, status, and total amount.
- Detail_Order: Contains details of each order, including the product ID, order ID, and quantity.
- Products: Stores information about products available in the shop, including the product ID, name, price, category, and quantity in stock.
- Category: Stores information about product categories, including the category ID, name, and description.
- City: Stores information about cities, including the city ID, name, and postal code.
- Country: Stores information about countries, including the country ID, name, and country code.
- Status: Stores information about order statuses, including the status ID and name.

## Views
The project includes several views that provide convenient ways to retrieve data from the database:
- OrdersWithDetails: Combines data from the Orders, Detail_Order, and Products tables to provide a comprehensive view of orders with their associated products and quantities.
- ClientOrders: Presents a view of orders made by individual clients, including the client's name, product name, quantity, and total amount.
- ProductStock: Displays the current stock information for each product, including the product ID, name, and quantity.

## User-Defined Function
The project includes a user-defined function called CalcuClientTotalOrderValue. This function takes a client ID as input and calculates the total order value for that client. It retrieves the sum of the total_amount field from the Orders table for the specified client.

## Stored Procedure
The project includes a stored procedure named GetClientsByCategory. This procedure takes a category ID as input and retrieves information about clients who have placed orders for products in that category. It performs joins between the Client, Orders, Detail_Order, and Products tables to fetch the required data
