const functions = require('@google-cloud/functions-framework');
const { Datastore } = require("@google-cloud/datastore");

const datastore = new Datastore();

functions.http('bid', async (req, res) => {
  const bid = req.body;

  console.log("Bid from user:", bid);

  const key = datastore.key(["bids", "bid"]);
  const entity = {
    key: key,
    data: bid,
  };

  await datastore.save(entity);

  res.set("Content-Type", "application/json");
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET, POST");
  res.set("Access-Control-Allow-Headers", "Content-Type");
  res.status(200).send(bid);
});