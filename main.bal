import ballerina/http;

type Product record {|
    readonly int index;
    string name;
    string description;
    decimal price;
    string stock_quality ;
    int stock_keeping_unit;
    boolean available;
|};

table <Product> key(index) ProductsDataBase = table[
    {
        index: 1,
        name: "Pen",
        description: "A pen for writing",
        price: 1.00,
        stock_quality: "Good",
        stock_keeping_unit: 100,    
        available: true
    }
];


type admin record {
    string password;
    string department;
};

type customer record {
    string email;

};

type AdminOrCustomer record {|
    readonly string username;
    boolean isAdmin;
    string lastName;
    string firstName;
    http:DATE dob;

    admin[] admin;
    customer[] customer;
|};

table<AdminOrCustomer> key (username) UsersDataBase = table[];

 

service /myShorp on new http:Listener(7070) {
    resource function post add_product(Product records) returns string {
        error? addProgrammeResults = ProductsDataBase.add(records);
        if (addProgrammeResults is error) {
            return "Error adding product: "+ records.index.toString();
        }
        return records.index.toString();
    }
    resource function post  create_users(AdminOrCustomer userDetails) returns string {
        error? adminResult = UsersDataBase.add(userDetails);

        if(adminResult is error){
            return "Error adding:" + userDetails.lastName;
        }
        return userDetails.username + "was added succesfuly";
    }
    resource function get jn() returns error? {
    }
    resource function get ji() returns error? {
    }
}
