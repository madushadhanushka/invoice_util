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
    <tr>
    <th>Product Name</th>
    <th>Quantity</th>
    <th>Per price</th>
    <th>Total</th></tr><tr>
    ${generateProductlist(invoice.productList)}
    </tr></table></div>
    </div>`;
    return invoiceOutput;
}
function generateProductlist(table<Product> productList) returns xml{
    xml output;
    foreach var product in productList {
        float total = <float>product.quantity * product.unitPrice;
        output =  xml `<td>${product.productName}</td>`
        + xml `<td>${product.quantity}</td>`
        + xml `<td>${product.unitPrice}</td>`
        + xml `<td>${io:sprintf("%.2f", total)}</td></tr>`;
    }
    return output;
}