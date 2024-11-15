document.getElementById('send-url-button').addEventListener('click', async () => {
  console.log(chrome);
  const tab = await chrome.tabs.query({active: true, currentWindow: true});
  console.log(tab);
  const url = tab[0].url;
  console.log(url);
  if (url) {
    try {
      const response = await fetch('http://localhost:3000/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({url}),
      });
      console.log('Song downloaded.', response);
    } catch (error) {
      console.error('Failed to download:', error);
    }
  }
});
