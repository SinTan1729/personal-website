// SPDX-FileCopyrightText: 2025-2026 Sayantan Santra <sayantan.santra689@gmail.com>
// SPDX-License-Identifier: GPL-3.0

// Put last modified time inside page
const putLastModifiedTime = () => {
  const lastModifiedView = document.getElementById('last-modified');
  const lastModifiedTime = new Date(document.lastModified);

  lastModifiedView.dateTime = lastModifiedTime.toISOString();
  lastModifiedView.textContent = lastModifiedTime.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
};

// Start loading here
putLastModifiedTime();
// This uses KaTeX script loaded earlier
document.body.querySelectorAll('.math').forEach((elem) => {
  renderMathInElement(elem, {
    delimiters: [{ left: '\\(', right: '\\)', display: false }],
    throwOnError: true,
  });
});
