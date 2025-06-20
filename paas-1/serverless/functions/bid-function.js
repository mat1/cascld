const functions = require("@google-cloud/functions-framework");
const { Datastore } = require("@google-cloud/datastore");

const datastore = new Datastore();

functions.http("bid", async (req, res) => {
  const bid = req.body;

  console.log("Bid from user:", bid);

  const key = datastore.key(["bids", "bid"]);

  const entity = {
    key: key,
    data: bid,
  };

  await datastore.save(entity);

  res.setHeader("Content-Type", "application/json");
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");
  res.status(200).send(JSON.stringify(bid));
});
