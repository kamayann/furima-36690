const pay = () => {
  Payjp.setPublicKey("pk_test_14ea9bec9868adce915ee9df"); 
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    
    const formResult = document.getElementById('charge-form');
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("buyer_purchase[number]"),
      cvc: formData.get("buyer_purchase[cvc]"),
      exp_month: formData.get("buyer_purchase[exp_month]"),
      exp_year: `20${formData.get("buyer_purchase[exp_year]")}`,
    };

      Payjp.createToken(card, (status, response) => {
        if (status == 200) {
          const token = response.id;
          const renderDom = document.getElementById('charge-form');
          const tokenObj = `<input value=${token} name='token' type="hidden">`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }

        document.getElementById("buyer_purchase_number").removeAttribute("name");
        document.getElementById("buyer_purchase_cvc").removeAttribute("name");
        document.getElementById("buyer_purchase_exp_month").removeAttribute("name");
        document.getElementById("buyer_purchase_exp_year").removeAttribute("name");

        document.getElementById('charge-form').submit();
      });
  });
};

window.addEventListener("load", pay);
