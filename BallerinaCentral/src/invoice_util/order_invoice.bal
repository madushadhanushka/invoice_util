import ballerina/time;
import ballerina/io;

public function generateInvoice(Invoice invoice) returns xml {
    string|error converted_time = time:format(invoice.invoiceDate,time:TIME_FORMAT_RFC_1123);
    string time = "";
    if (converted_time is string) {
        time = converted_time;
    }
    xml invoiceOutput = xml `<div>
    <div><b>Prime Mart</b></div>
    <div>Name: ${invoice.customerName}</div>
    <div>Address: ${invoice.customerAddress}</div>
    <div>Billing Address: ${invoice.customerBillingAddress}</div>
    <div>Mobile: ${invoice.customerMobileNumber}</div>
    <div>Billing Date: ${time}</div>
    <div><table>
    <tr><th>Item Name</th></tr>
    <tr><th>Quantity</th></tr>
    <tr><th>Per price</th></tr>
    <tr><th>Total</th></tr>
    ${generateItemlist(invoice.itemList)}
    </table></div>
    </div>`;
    return invoiceOutput;
}
function generateItemlist(table<Item> itemList) returns xml{
    xml ouput = xml `<tr></tr>`;
    foreach var item in itemList {
        float total = <float>item.quantity * item.unitPrice;
        ouput += xml `<tr>
        <td>${item.itemName}</td>
        <td>${item.quantity}</td>
        <td>${item.unitPrice}</td>
        <td>${io:sprintf("%.2f", total)}</td></tr>`;
    }
    return ouput;
}