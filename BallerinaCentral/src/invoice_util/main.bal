import ballerina/io;
import ballerina/time;

public function main() {
    table<Item> items = table {
        {key itemName, quantity, unitPrice},[
            {"SD card reader", 1, 20},
            {"USB cable", 2, 1}
        ]
    };
    time:Time invoiceDate = time:currentTime();
    time:Time|error invoiceDateResult = time:createTime(2017, 3, 28, 23, 42, 45, 554, "America/Panama");
    if(invoiceDateResult is time:Time) {
        invoiceDate = invoiceDateResult;
    }
    Invoice invoce = {customerName: "john", 
    customerAddress: "New York", 
    customerBillingAddress: "Callifornia", 
    customerMobileNumber: "0123456",
    discount: 0,
    itemList: items,
    invoiceDate: invoiceDate};
    xml invoceHTML = generateInvoice(invoce);
    io:println(invoceHTML);
}
