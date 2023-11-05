// WING
// CALL WING API put to write a new file on the bucket
function writeFile(fileName, fileContent) {
    var myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");

    var raw = JSON.stringify({
        "content": fileContent
    });

    var requestOptions = {
        method: 'PUT',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
    };
    // Manually update port every time (changes at every save)
    fetch("http://127.0.0.1:52367/files/" + fileName, requestOptions)
        .then(response => response.text())
        .then(result => console.log(result))
        .catch(error => console.log('error', error));
}

// CALL WING API get to read a file on the bucket
function readFile(fileName) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    fetch("http://127.0.0.1:52367/files/" + fileName, requestOptions)
        .then(response => response.text())
        .then(result => console.log(result))
        .catch(error => console.log('error', error));
    //return fileContent;
}