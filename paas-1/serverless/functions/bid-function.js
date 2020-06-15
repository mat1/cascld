const { Datastore } = require("@google-cloud/datastore");

const datastore = new Datastore();

exports.bid = async (req, res) => {
  // Allow CORS
  res.set("Access-Control-Allow-Origin", "*");

  if (req.method === "OPTIONS") {
    res.set("Access-Control-Allow-Methods", "*");
    res.set("Access-Control-Allow-Headers", "*");
    return res.status(204).send("");
  }

  const bid = req.body;

  console.log("Bid from user:", bid);

  const key = datastore.key(["bids", "bid"]);
  const entity = {
    key: key,
    data: bid,
  };

  await datastore.save(entity);

  res.status(200).send(bid);
};
