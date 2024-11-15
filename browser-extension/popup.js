document.getElementById('send-url-button').addEventListener('click', async function( ) {
  const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
  const url = tab.url;
  if (url) {
    chrome.runtime.sendMessage({ url });
    this.disabled = true;
  }
});
