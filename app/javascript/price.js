function priceCalc () {
  const price = document.getElementById("item-price");
  price.addEventListener("input", () => {
    const priceInput = price.value;
    const priceTax = Math.floor(priceInput * 0.1);
    const tax = document.getElementById("add-tax-price");
    tax.innerHTML = priceTax;
    const priceProfit = priceInput - priceTax;
    const profit = document.getElementById("profit");
    profit.innerHTML = priceProfit;
  });

};
window.addEventListener('load', priceCalc);