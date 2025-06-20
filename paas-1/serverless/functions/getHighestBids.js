const functions = require("@google-cloud/functions-framework");
const { Datastore } = require("@google-cloud/datastore");

// Verwendet Datastore des Projekts
const datastore = new Datastore();

functions.http("getHighestBid", async (req, res) => {
  console.log("getHighestBid", req);

  const key = datastore.key(["bids", "bid"]);

  const entities = await datastore.get(key);

  console.log("Entities from datastore", entities);

  const result = {
    highest: entities[0] == null ? 0 : entities[0].bid,
    hostname: "Google Functions",
  };

  res.setHeader("Content-Type", "application/json");
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST");
  res.status(200).send(JSON.stringify(result));
});