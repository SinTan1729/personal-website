const loader = () => {
  // Put last modified time
  const last_modified_span = document.getElementById("last-modified");
  const last_modified_time = new Date(document.lastModified);
  last_modified_span.innerHTML = last_modified_time.toDateString();
  // Open all links in new tab
  document.querySelectorAll("a").forEach((url) => {
    url.target = "_blank";
    url.rel = "noreferrer noopener";
  });
};

// Start loading here
loader();
// Render math
renderMathInElement(document.body);
