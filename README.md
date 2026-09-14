# Md. Robiul Islam Roman Portfolio

A responsive, static portfolio with light and dark themes and a local computing video. No framework, dependency installation, or build step is required.

## Local preview

From this directory, run a static web server, for example with Python installed:

```powershell
python -m http.server 4173
```

Open `http://localhost:4173` in your browser.

## Deploy to Vercel

Import `Roman-rir/Portfolio` from GitHub into Vercel, or link this local directory to an existing Vercel project. `vercel.json` configures the project as a static site:

- Framework Preset: **Other**
- Root Directory: repository root
- Build Command: empty
- Output Directory: **.**

For a CLI deployment with Node.js installed, run these commands separately and follow the account/project prompts:

```powershell
npx vercel login
npx vercel link
npx vercel deploy
```

After checking the preview deployment, publish production with:

```powershell
npx vercel deploy --prod
```

Keep images, PDF downloads, and video files with the site when deploying. Local computer paths cannot be used as public video URLs. Git-based deployments require the site changes and media to be committed and pushed to the connected repository.

Vercel references: [static build settings](https://vercel.com/docs/builds/configure-a-build), [project configuration](https://vercel.com/docs/project-configuration/vercel-json), and [CLI deployment](https://vercel.com/docs/cli/deploy).

## Files

- `index.html` - portfolio homepage
- `styles.css` - responsive layouts and both color themes
- `script.js` - theme toggle and page interactions
- `assets/` - portfolio images, optimized computing video, and video poster
- `Roman_Academic_CV (1).pdf` - current downloadable academic CV and source for academic content
- `MD_Robiul_Islam_Roman_CV_semiconductor.pdf` - previous semiconductor CV
- `resume.pdf` - earlier resume
- `vercel.json` - static hosting configuration
- `.vercelignore` - files excluded from CLI uploads
- `.nojekyll` - preserves compatibility with GitHub Pages
