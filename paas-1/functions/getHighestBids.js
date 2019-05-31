const {Datastore} = require('@google-cloud/datastore');
const PROJECTID = 'cascld';

const datastore = new Datastore({
    projectId: PROJECTID
});

exports.getHighestBid = async function(req, res) {  
  const key = datastore.key(["bids", "bid"]);
    
  return datastore.get(key, (err, entity) => {
    let result = null;
    
    if (entity == null) {
      	result = { highest: 0, hostname: "Google Functions" };
    } else {
      	result = { highest: entity.bid, hostname: "Google Functions" };
    }
    res.set('Access-Control-Allow-Origin', "*")
  	res.set('Access-Control-Allow-Methods', 'GET, POST')
    res.status(200).send(result);
  });
};