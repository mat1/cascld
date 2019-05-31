const { Datastore } = require("@google-cloud/datastore");
const PROJECTID = "cascld";

const datastore = new Datastore({
  projectId: PROJECTID
});

exports.bid = async function(req, res) {
  const bid = req.body;

  console.log(bid);

  const key = datastore.key(["bids", "bid"]);
  const entity = {
    key: key,
    data: bid
  };

  await datastore.save(entity);

  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "GET, POST");
  res.set("Access-Control-Allow-Headers", "Content-Type");
  res.status(200).send(bid);
};
