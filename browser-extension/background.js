chrome.runtime.onMessage.addListener(async (message, sender, sendResponse) => {
  if (message.url) {
    try {
      const response = await fetch('http://localhost:3000/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ url: message.url }),
      });
      console.log('Song downloaded: ' + message.url, response);
    } catch (error) {
      console.error('Failed to download:', error);
    }
  }
});
