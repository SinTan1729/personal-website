// SPDX-FileCopyrightText: 2025 Sayantan Santra <sayantan.santra689@gmail.com>
// SPDX-License-Identifier: GPL-3.0

// Put last modified time inside page
const lastModifiedTime = () => {
  const last_modified_span = document.getElementById("last-modified");
  const last_modified_time = new Date(document.lastModified);
  last_modified_span.innerHTML = last_modified_time.toDateString();
};

// Open all links in new tab
const openInNewTab = () => {
  document.querySelectorAll("a").forEach((url) => {
    url.target = "_blank";
    url.rel = "noreferrer noopener";
  });
};

// Only open one detail element at one time
const onlyOpenOneDetail = () => {
  const detailsList = document.querySelectorAll("details");
  function handleDetailToggle(event) {
    if (event.newState == "closed") return;
    for (let detail of detailsList) {
      detail.open = detail == event.target;
    }
  }
  for (let details of detailsList) {
    details.ontoggle = handleDetailToggle;
  }
};

// Start loading here
lastModifiedTime();
openInNewTab();
onlyOpenOneDetail();
// This uses KaTeX script loaded earlier
renderMathInElement(document.body);
