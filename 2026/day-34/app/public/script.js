async function loadProducts() {

    const response = await fetch("/products");

    const data = await response.json();

    document.getElementById("status").innerHTML = `
        <p><strong>Database:</strong> ${data.database}</p>
        <p><strong>Redis:</strong> ${data.redis}</p>
        <p><strong>Page Visits:</strong> ${data.pageVisits}</p>
    `;

    let html = "";

    data.products.forEach(product => {
        html += `
            <div class="product">
                <h3>${product.name}</h3>
                <p>₹ ${product.price}</p>
            </div>
        `;
    });

    document.getElementById("products").innerHTML = html;
}
