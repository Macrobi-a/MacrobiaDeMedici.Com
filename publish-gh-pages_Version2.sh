#!/usr/bin/env bash
set -euo pipefail

# Default remote (change if you prefer HTTPS)
DEFAULT_REMOTE="git@github.com:Macrobi-a/MacrobiaDeMedici.Com.git"

usage() {
  cat <<EOF
Usage: $0 [REMOTE_URL]
If REMOTE_URL is provided, it will be used instead of the default:
  $DEFAULT_REMOTE
EOF
}

REMOTE="${1:-$DEFAULT_REMOTE}"

# create a temporary directory for the commit
WORKDIR="$(mktemp -d)"
cleanup() {
  rm -rf "$WORKDIR"
}
trap cleanup EXIT

echo "Creating site files in $WORKDIR ..."
cd "$WORKDIR"

# Write files
cat > template.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>My Name</title>
  <link rel="shortcut icon" href="http://ycombinator.com/arc/arc.png">
  <style>
    :root{
      --accent: #ff6600;
      --text: #111;
      --muted: #666;
      --max-width: 900px;
      --sidebar-width: 175px;
      --gap: 24px;
      font-family: Verdana, Geneva, Tahoma, sans-serif;
    }

    html,body{height:100%;margin:0;color:var(--text);background:#fff;}
    .page {
      max-width: var(--max-width);
      margin: 24px auto;
      display: grid;
      grid-template-columns: var(--sidebar-width) 1fr;
      gap: var(--gap);
      padding: 0 16px;
      align-items: start;
    }

    /* Sidebar */
    .sidebar {
      background: var(--accent);
      color: white;
      padding: 8px;
      min-height: 1px;
    }
    .sidebar img.spacer {
      display:block;
      width:100%;
      height:1px;
      visibility:hidden;
    }

    /* Main content */
    main {
      padding: 4px 8px;
    }

    nav a {
      color: inherit;
      text-decoration: none;
      margin-right: 12px;
    }
    nav a:hover { text-decoration: underline; }

    .profile {
      display:flex;
      gap:16px;
      align-items:flex-start;
    }
    .profile img {
      width:210px;
      height:210px;
      object-fit:cover;
      margin:0 16px 8px 0;
      flex: 0 0 210px;
    }

    hr { border:none; border-top:1px solid #ddd; margin:18px 0; }

    footer { color:var(--muted); font-size:0.9rem; margin-top:16px; }

    /* Responsive */
    @media (max-width:720px){
      .page { grid-template-columns: 1fr; }
      .profile { flex-direction:column; align-items:center; }
      .profile img { width:160px; height:160px; flex:0 0 auto; margin:0 0 12px 0; }
      nav { margin-bottom:8px; }
    }
  </style>
</head>
<body>
  <div class="page" role="document">
    <aside class="sidebar" role="complementary" aria-label="Primary sidebar">
      <!-- Decorative 1px spacer to mirror original layout -->
      <img class="spacer" src="https://via.placeholder.com/1x1" alt="" aria-hidden="true">
    </aside>

    <main role="main">
      <nav aria-label="Main navigation">
        <strong><a href="index.html">Home</a></strong>
        <a href="bio.html">Bio</a>
        <a href="https://twitter.com/yourhandle" rel="noopener" target="_blank">Twitter</a>
      </nav>

      <!-- PAGE CONTENT START -->
      <!-- Replace the content below with per-page content. -->
      <!-- CONTENT -->
      <!-- PAGE CONTENT END -->

      <hr>
      <footer>
        &copy; 2024 My Name.
      </footer>
    </main>
  </div>
</body>
</html>
HTML

cat > index.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>My Name — Home</title>
  <link rel="shortcut icon" href="http://ycombinator.com/arc/arc.png">
  <style>
    :root{
      --accent: #ff6600;
      --text: #111;
      --muted: #666;
      --max-width: 900px;
      --sidebar-width: 175px;
      --gap: 24px;
      font-family: Verdana, Geneva, Tahoma, sans-serif;
    }
    html,body{height:100%;margin:0;color:var(--text);background:#fff;}
    .page { max-width: var(--max-width); margin: 24px auto; display: grid; grid-template-columns: var(--sidebar-width) 1fr; gap: var(--gap); padding: 0 16px; }
    .sidebar { background: var(--accent); color: white; padding: 8px; }
    .sidebar img.spacer { display:block; width:100%; height:1px; visibility:hidden; }
    main { padding: 4px 8px; }
    nav a { color: inherit; text-decoration: none; margin-right: 12px; }
    .profile { display:flex; gap:16px; align-items:flex-start; }
    .profile img { width:210px; height:210px; object-fit:cover; margin:0 16px 8px 0; flex:0 0 210px; }
    hr { border:none; border-top:1px solid #ddd; margin:18px 0; }
    footer { color:var(--muted); font-size:0.9rem; margin-top:16px; }
    @media (max-width:720px){ .page { grid-template-columns: 1fr; } .profile { flex-direction:column; align-items:center; } .profile img { width:160px; height:160px; flex:0 0 auto; margin:0 0 12px 0; } }
  </style>
</head>
<body>
  <div class="page" role="document">
    <aside class="sidebar" role="complementary" aria-label="Primary sidebar">
      <img class="spacer" src="https://via.placeholder.com/1x1" alt="" aria-hidden="true">
    </aside>

    <main role="main">
      <nav aria-label="Main navigation">
        <strong><a href="index.html">Home</a></strong>
        <a href="bio.html">Bio</a>
        <a href="https://twitter.com/yourhandle" rel="noopener" target="_blank">Twitter</a>
      </nav>

      <div class="profile">
        <img src="https://via.placeholder.com/200x200" alt="Photo of My Name" width="210" height="210">
        <div>
          <p>This is a clone of Paul Graham's website. I can write my own bio here.</p>

          <p>The design is intentionally simple. It focuses entirely on the text.</p>

          <h3>Essays</h3>
          <ul>
            <li><a href="essay1.html">The First Essay</a></li>
            <li><a href="essay2.html">Why Simple is Better</a></li>
            <li><a href="essay3.html">How to Clone a Website</a></li>
          </ul>
        </div>
      </div>

      <hr>
      <footer>
        &copy; 2024 My Name.
      </footer>
    </main>
  </div>
</body>
</html>
HTML

cat > essay1.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>The First Essay</title>
  <link rel="shortcut icon" href="http://ycombinator.com/arc/arc.png">
  <style>
    :root{
      --accent: #ff6600;
      --text: #111;
      --muted: #666;
      --max-width: 900px;
      --sidebar-width: 175px;
      --gap: 24px;
      font-family: Verdana, Geneva, Tahoma, sans-serif;
    }
    html,body{height:100%;margin:0;color:var(--text);background:#fff;}
    .page { max-width: var(--max-width); margin: 24px auto; display: grid; grid-template-columns: var(--sidebar-width) 1fr; gap: var(--gap); padding: 0 16px; align-items:start; }
    .sidebar { background: var(--accent); color: white; padding: 8px; }
    .sidebar img.spacer { display:block; width:100%; height:1px; visibility:hidden; }
    main { padding: 4px 8px; }
    nav a { color: inherit; text-decoration: none; margin-right: 12px; }
    .back { display:inline-flex; align-items:center; gap:8px; text-decoration:none; color:inherit; }
    .prose { max-width: 600px; line-height:1.6; color:var(--text); }
    .prose h1 { font-size:1.25rem; margin:0 0 8px 0; }
    .meta { color:var(--muted); font-size:0.95rem; margin-bottom:16px; }
    hr { border:none; border-top:1px solid #ddd; margin:18px 0; }
    footer { color:var(--muted); font-size:0.9rem; margin-top:16px; }
    @media (max-width:720px){ .page { grid-template-columns: 1fr; } .prose { max-width:100%; } }
  </style>
</head>
<body>
  <div class="page" role="document">
    <aside class="sidebar" role="complementary" aria-label="Primary sidebar">
      <img class="spacer" src="https://via.placeholder.com/1x1" alt="" aria-hidden="true">
    </aside>

    <main role="main">
      <nav aria-label="Main navigation">
        <a class="back" href="index.html" title="Back to home">
          <img src="https://via.placeholder.com/15x15" width="15" height="15" alt="Back icon" aria-hidden="true">
          Back
        </a>
      </nav>

      <article class="prose" aria-labelledby="essay-title">
        <h1 id="essay-title">The First Essay</h1>
        <div class="meta">February 2024</div>

        <p>This is where your essay content goes. Because this uses standard modern HTML, separate paragraphs with <code>&lt;p&gt;</code> tags as usual.</p>

        <p>Paul Graham's essays are famous for their readability. The reading column is intentionally capped at roughly 500–600px to make it easy for the eye to track back to the start of the next line.</p>

        <p>End of the essay.</p>

        <p style="font-size:0.85rem;color:var(--muted)">
          Thanks to <a href="#" rel="noopener">Someone</a> for reading drafts of this.
        </p>
      </article>

      <hr>
      <footer>&copy; 2024 My Name.</footer>
    </main>
  </div>
</body>
</html>
HTML

# .nojekyll (empty file)
cat > .nojekyll <<'TXT'
# This file is intentionally empty
TXT

cat > README.md <<'MARKDOWN'
# MacrobiaDeMedici.Com

Static site for Macrobi-a.

This repository contains a small static site. Publish using the `gh-pages` branch (root) or configure GitHub Pages to serve from it.
MARKDOWN

# Initialize git and create gh-pages branch
echo "Initializing git repo and creating gh-pages branch..."
git init -q
git checkout -b gh-pages

git add .
git commit -m "Publish site to gh-pages" -q

echo
echo "Ready to push the gh-pages branch to the remote:"
echo "  $REMOTE"
echo
read -r -p "Press Enter to push now (or Ctrl-C to abort) "

# Add remote and push
git remote add origin "$REMOTE"
echo "Pushing gh-pages to $REMOTE ..."
git push -u origin gh-pages

echo
echo "Done. If the push succeeded, go to your repository settings → Pages and select the 'gh-pages' branch as the source (root)."
echo "Your site should be available shortly at https://Macrobi-a.github.io/MacrobiaDeMedici.Com/ or the URL shown in the Pages settings."