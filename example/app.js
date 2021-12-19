import TiDocumentViewer from 'ti.documentviewer';

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});

var btn = Ti.UI.createButton({
    title: 'View documents',
});

btn.addEventListener('singletap', () => {
    const documents = [
        'https://assets.ctfassets.net/l3l0sjr15nav/29D2yYGKlHNm0fB2YM1uW4/8e638080a0603252b1a50f35ae8762fd/Get_Started_With_Smallpdf.pdf',
        'https://assets.ctfassets.net/l3l0sjr15nav/29D2yYGKlHNm0fB2YM1uW4/8e638080a0603252b1a50f35ae8762fd/Get_Started_With_Smallpdf.pdf',
        'https://assets.ctfassets.net/l3l0sjr15nav/29D2yYGKlHNm0fB2YM1uW4/8e638080a0603252b1a50f35ae8762fd/Get_Started_With_Smallpdf.pdf'
    ].map(loadRemoteFile);

    TiDocumentViewer.showDocumentViewer({ documents });
});

win.add(btn);
win.open();

function loadRemoteFile(url) {
    const filename = url.split('/').pop();
    const file = Ti.Filesystem.getFile(Ti.Filesystem.applicationCacheDirectory, filename);

    const httpClient = Ti.Network.createHTTPClient({
        onload: function () {
            file.write(httpClient.responseData);
            TiDocumentViewer.refresh();
        }
    });

    httpClient.open('GET', url);
    httpClient.send();

    return file.nativePath;
}