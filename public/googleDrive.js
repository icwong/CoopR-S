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
}

function destroyClickedElement2(event)
{
	document.body.removeChild(event.target);
}

function loadDriveFileAsText(url)
{
//	URL url = new URL(document.getElementById("result"));
//Scanner s = new Scanner(url.openStream());




	
	//alert(document.getElementById("result"));
	// var fileToLoad = document.getElementById("result").files[0];
	// var fileToLoad = document.getElementById("result");
	var fileToLoad = url;

	var fileReader = new FileReader();
	fileReader.onload = function(fileLoadedEvent) 
	{
		var textFromFileLoaded = fileLoadedEvent.target.result;
		document.getElementById("inputTextToSave").value = textFromFileLoaded;
	};
	fileReader.readAsText(fileToLoad, "UTF-8");
	
	
}

/*
function selectSourceFile()
{
	
	var imported = document.createElement('script');
	imported.src = 'https://apis.google.com/js/api.js?onload=onApiLoad';
	document.head.appendChild(imported);


	alert("here");
}


*/