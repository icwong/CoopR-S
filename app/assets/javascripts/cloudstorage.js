var getDoc = document.getElementById('getDoc');


//document.getElementById("getDoc").onclick = selectSourceFile;

function selectSourceFile(){
	alert("here");
	var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "https://apis.google.com/js/api.js?onload=onApiLoad"; 
    document.getElementsByTagName("head")[0].appendChild(script);
    
    return false;
	
}
  
function getComparePDFurl(){
	 var url = "/compare.pdf?j1=" + getCookie( JOB_ONE ) + '&j2=' + getCookie( JOB_TWO );
	 return url;
}

function saveFileToDrive(url){
	filepicker.exportFile(
  url,
  {
    mimetype:'document/pdf',
    suggestedFilename: 'newFile'
  },
  function(Blob){
    console.log(Blob.url);
  }
);
	/*
	var xhr = new XMLHttpRequest();
	xhr.open('GET', url, true);

xhr.responseType = 'blob';
xhr.onload = function(e) {
  if (this.status == 200) {
    var myBlob = this.response;
    // myBlob is now the blob that the object URL pointed to..

	var fileToLoad = myBlob;
	
	filepicker.exportFile(
  myBlob,
  function(myBlob){
    console.log(myBlob.url);
  }
	);
*/
	//var fileReader = new FileReader();
/*
	fileReader.onload = function(fileLoadedEvent) 
	{
		var textFromFileLoaded = fileLoadedEvent.target.result;

		 WYMeditor.INSTANCES[0].html(textFromFileLoaded);

	};
*/
/*
//fileReader.readAsText(fileToLoad, "UTF-8");
	//fileReader.readAsText(fileToLoad);
	  }
	};
	xhr.send();
*/	
}

function saveTextAsDriveFile(url)
{
	var textToWrite = document.getElementById("inputTextToSave").value;
	var textFileAsBlob = new Blob([textToWrite], {type:'text/plain', url : "url"});
	//var fileNameToSaveAs = document.getElementById("inputFileNameToSaveAs").value;
	
	var blob = {
	// text: ,
  url: 'https://www.filestackapi.com/api/file/AMltoa8ATECOsFTMduLz',
  filename: 'hello.txt',
  mimetype: 'text/plain',
  isWriteable: true,
  size: 100
	};
	/*
	filepicker.exportFile(
  blob,
  function(Blob){
    console.log(Blob.url);
  }
	);
	*/
	filepicker.exportFile(
  textFileAsBlob,
  function(TextFileAsBlob){
    console.log(textFileAsBlob.url);
    
  }
);


	/*
	

	var downloadLink = document.createElement("a");
	downloadLink.download = fileNameToSaveAs;
	downloadLink.innerHTML = "Download File";
	if (window.webkitURL != null)
	{
		// Chrome allows the link to be clicked
		// without actually adding it to the DOM.
		downloadLink.href = window.webkitURL.createObjectURL(textFileAsBlob);
	}
	else
	{
		// Firefox requires the link to be added to the DOM
		// before it can be clicked.
		downloadLink.href = window.URL.createObjectURL(textFileAsBlob);
		downloadLink.onclick = destroyClickedElement2;
		downloadLink.style.display = "none";
		document.body.appendChild(downloadLink);
	}

	downloadLink.click();
	*/
}

function destroyClickedElement2(event)
{
	document.body.removeChild(event.target);
}

function loadDriveFileAsText(url)
{
	url = "https://process.filestackapi.com/ALNjEZIbJTOg3xF1Dh5vnz/output=format:html/" + url;
var xhr = new XMLHttpRequest();
xhr.open('GET', url, true);



//url = url + 'output=format:html';
//alert(url);

xhr.responseType = 'blob';
xhr.onload = function(e) {
  if (this.status == 200) {
    var myBlob = this.response;
    // myBlob is now the blob that the object URL pointed to..
    

	var fileToLoad = myBlob;
	
	//filepicker.convert(url, {format: 'html'} );

	var fileReader = new FileReader();

	fileReader.onload = function(fileLoadedEvent) 
	{
		var textFromFileLoaded = fileLoadedEvent.target.result;

		 WYMeditor.INSTANCES[0].html(textFromFileLoaded);

	};


//fileReader.readAsText(fileToLoad, "UTF-8");
	fileReader.readAsText(fileToLoad);
  }
};
xhr.send();

	
}

function putText (message) {
	var txtArea = document.getElementsByClassName('wym_iframe combokeys')[0];
	var para = document.createElement( "p" );
	var node = document.createTextNode( message );
	para.appendChild(node);
	txtArea.appendChild(para);
}
