bring cloud;
bring http;
bring fs;


// We create a bucket with a file inside
let bucket = new cloud.Bucket();
// We create the website
let website = new cloud.Website(path: "./front-end/index.html");
// Here we have the Api Gateway
let api = new cloud.Api();



// Read the file with GET reqtest
//  Create an endpoint for HTTP GET requests
api.get("{fileName}", inflight (req: cloud.ApiRequest): cloud.ApiResponse => {
  let fileName = req.vars.get("fileName");
  let items = bucket.list();

  //  If the bucket do not contain the file name
  if (!items.contains(fileName)) {
    return cloud.ApiResponse {
      status: 404,
      body: "File not found"
    };
  }

  //  Otherwise we can safely read it
  return cloud.ApiResponse {
    status: 200,
    body: bucket.get(fileName)
  };
});



//  Create an endpoint for HTTP put requests
api.put("{fileName}", inflight (req: cloud.ApiRequest): cloud.ApiResponse => { 
  let fileName = req.vars.get("fileName");
  let text = req.vars.get("text");
  let items = bucket.list();


  //  If the bucket do not contain the file create a new one
  if (!items.contains(fileName)) {

    bucket.put(fileName,text);

    return cloud.ApiResponse {     
      status: 201,
      body: "Written new File"
    };
  }

  //file already exist
  return cloud.ApiResponse {
    status: 400,
    body: "File already exist"
  };

  // !!TODO Read the old file to push it back with new changes
  //  Otherwise change the existing one (TODO)
});
