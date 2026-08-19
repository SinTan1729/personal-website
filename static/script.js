// SPDX-FileCopyrightText: 2025 Sayantan Santra <sayantan.santra689@gmail.com>
// SPDX-License-Identifier: GPL-3.0

// Put last modified time inside page
const lastModifiedTime = () => {
  const last_modified_span = document.getElementById("last-modified");
  const last_modified_time = new Date(document.lastModified);
  last_modified_span.innerHTML = last_modified_time.toDateString();
};

// Start loading here
lastModifiedTime();
// This uses KaTeX script loaded earlier
renderMathInElement(document.body);
