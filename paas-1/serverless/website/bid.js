const getHighestBidUrl = "https://YOUR-CLOUD-FUNCTION-URL";
const bidUrl = "https://YOUR-CLOUD-FUNCTION-URL";

const getHighestBid = () => {
  fetch(getHighestBidUrl)
    .then((r) => r.json())
    .then((r) => {
      const bidApp = document.getElementById("bid-app");

      const min = r.highest + 1;

      bidApp.innerHTML = `  
        <h1>Highest Bid: ${r.highest}</h1>
        <h4>Generated by: ${r.hostname}</h4>
        <input id="bid" type="number" min=${min} />
        <button type="submit" onclick="bid()">Bid!</button>
    `;
    });
};

const bid = () => {
  const bid = document.getElementById("bid").value;

  fetch(bidUrl, {
    method: "POST",
    body: JSON.stringify({ bid: Number(bid) }),
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((_) => {
      console.log("Success");
      getHighestBid();
    })
    .catch((error) => console.error("Error:", error));
};

getHighestBid();
