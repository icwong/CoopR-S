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



function saveTextAsDriveFile()
{
	var textToWrite = document.getElementById("inputTextToSave").value;
	var textFileAsBlob = new Blob([textToWrite], {type:'text/plain'});
	var fileNameToSaveAs = document.getElementById("inputFileNameToSaveAs").value;
	
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
var xhr = new XMLHttpRequest();
xhr.open('GET', url, true);

xhr.responseType = 'blob';
xhr.onload = function(e) {
  if (this.status == 200) {
    var myBlob = this.response;
    // myBlob is now the blob that the object URL pointed to..
    

	var fileToLoad = myBlob;

	var fileReader = new FileReader();

	fileReader.onload = function(fileLoadedEvent) 
	{
		var textFromFileLoaded = fileLoadedEvent.target.result;
	//	putText( textFromFileLoaded );
		 //document.getElementById("inputTextToSave").value = textFromFileLoaded;
		
		 document.getElementById("post_body").innerHTML = textFromFileLoaded;
		 
		 //document.getElementById("post_attachment").value = textFromFileLoaded;
		 //document.cookie = "temp=" + textFromFileLoaded;
		//document.getElementById("inputTextToSave").text_area = textFromFileLoaded;
	};

//fileReader.readAsDataURL(fileToLoad);
	fileReader.readAsText(fileToLoad, "UTF-8");
  }
};
xhr.send();

	//window.location.reload(false);
	
}

function putText (message) {
	var txtArea = document.getElementsByClassName('wym_iframe combokeys')[0];
	var para = document.createElement( "p" );
	var node = document.createTextNode( message );
	para.appendChild(node);
	txtArea.appendChild(para);
}
