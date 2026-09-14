(() => {
  'use strict';
  const root = document.documentElement;
  const themeToggle = document.getElementById('themeToggle');
  const systemTheme = window.matchMedia('(prefers-color-scheme: light)');
  let savedTheme = null;
  try { savedTheme = localStorage.getItem('roman-theme'); } catch (_) { /* Private browsing can disable storage. */ }
  if (savedTheme !== 'light' && savedTheme !== 'dark') savedTheme = null;

  function applyTheme(theme) {
    root.dataset.theme = theme;
    const isDark = theme === 'dark';
    const label = `Switch to ${isDark ? 'light' : 'dark'} mode`;
    themeToggle.setAttribute('aria-label', label);
    themeToggle.title = label;
    document.querySelector('meta[name="theme-color"]').content = isDark ? '#11130f' : '#f5f4ed';
  }
  applyTheme(savedTheme || (systemTheme.matches ? 'light' : 'dark'));
  themeToggle.addEventListener('click', () => {
    savedTheme = root.dataset.theme === 'dark' ? 'light' : 'dark';
    applyTheme(savedTheme);
    try { localStorage.setItem('roman-theme', savedTheme); } catch (_) { /* Theme still works without persistence. */ }
  });
  systemTheme.addEventListener('change', (event) => {
    if (!savedTheme) applyTheme(event.matches ? 'light' : 'dark');
  });
  window.addEventListener('storage', (event) => {
    if (event.key !== 'roman-theme' && event.key !== null) return;
    savedTheme = event.newValue === 'light' || event.newValue === 'dark' ? event.newValue : null;
    applyTheme(savedTheme || (systemTheme.matches ? 'light' : 'dark'));
  });

  const navToggle = document.getElementById('navToggle');
  const navLinks = document.getElementById('navLinks');
  function setMenu(open) {
    navLinks.classList.toggle('open', open);
    navToggle.setAttribute('aria-expanded', String(open));
    navToggle.setAttribute('aria-label', `${open ? 'Close' : 'Open'} navigation`);
  }
  navToggle.addEventListener('click', () => setMenu(!navLinks.classList.contains('open')));
  navLinks.querySelectorAll('a').forEach(link => link.addEventListener('click', () => setMenu(false)));
  document.addEventListener('click', (event) => {
    if (!event.target.closest('.site-nav')) setMenu(false);
  });
  document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && navLinks.classList.contains('open')) {
      setMenu(false);
      navToggle.focus();
    }
  });
  window.matchMedia('(min-width: 851px)').addEventListener('change', () => setMenu(false));

  const motionQuery = window.matchMedia('(prefers-reduced-motion: reduce)');
  const projectVisuals = document.querySelectorAll('.proj-visual');
  const projectMotionToggle = document.getElementById('projectMotionToggle');
  let projectMotionPaused = false;
  function syncProjectMotion() {
    root.dataset.projectMotion = projectMotionPaused || motionQuery.matches || document.hidden ? 'paused' : 'running';
    projectMotionToggle.hidden = motionQuery.matches;
    projectMotionToggle.textContent = projectMotionPaused ? 'Resume animations' : 'Pause animations';
    projectMotionToggle.setAttribute('aria-pressed', String(projectMotionPaused));
  }
  projectMotionToggle.addEventListener('click', () => {
    projectMotionPaused = !projectMotionPaused;
    syncProjectMotion();
  });
  motionQuery.addEventListener('change', syncProjectMotion);
  document.addEventListener('visibilitychange', syncProjectMotion);
  syncProjectMotion();
  if ('IntersectionObserver' in window) {
    const projectMotionObserver = new IntersectionObserver(entries => {
      entries.forEach(entry => entry.target.classList.toggle('is-in-view', entry.isIntersecting));
    }, { threshold: .1 });
    projectVisuals.forEach(visual => projectMotionObserver.observe(visual));
  } else {
    projectVisuals.forEach(visual => visual.classList.add('is-in-view'));
  }
  const video = document.getElementById('heroVideo');
  const videoToggle = document.getElementById('videoToggle');
  let userPaused = false;
  let videoVisible = true;
  function updateVideoButton() {
    const paused = video.paused;
    videoToggle.classList.toggle('is-paused', paused);
    videoToggle.setAttribute('aria-label', `${paused ? 'Play' : 'Pause'} background video`);
    videoToggle.title = `${paused ? 'Play' : 'Pause'} background video`;
  }
  function playVideo() {
    const result = video.play();
    if (result) result.catch(updateVideoButton);
  }
  videoToggle.addEventListener('click', () => {
    if (video.paused) { userPaused = false; playVideo(); }
    else { userPaused = true; video.pause(); }
  });
  video.addEventListener('play', updateVideoButton);
  video.addEventListener('pause', updateVideoButton);
  video.addEventListener('error', () => { videoToggle.hidden = true; });
  updateVideoButton();
  if (!motionQuery.matches && !navigator.connection?.saveData) playVideo();
  motionQuery.addEventListener('change', (event) => {
    if (event.matches) video.pause();
    else if (!userPaused && !navigator.connection?.saveData && videoVisible && !document.hidden) playVideo();
  });
  document.addEventListener('visibilitychange', () => {
    if (document.hidden) video.pause();
    else if (!userPaused && !motionQuery.matches && !navigator.connection?.saveData && videoVisible) playVideo();
  });

  const cards = Array.from(document.querySelectorAll('.proj-card'));
  const filters = document.querySelectorAll('.filter');
  const projectStatus = document.getElementById('projectStatus');
  filters.forEach(button => button.addEventListener('click', () => {
    const filter = button.dataset.filter;
    filters.forEach(item => item.setAttribute('aria-pressed', String(item === button)));
    let count = 0;
    cards.forEach(card => {
      const show = filter === 'all' || card.dataset.category.split(' ').includes(filter);
      card.hidden = !show;
      if (show) count++;
    });
    projectStatus.textContent = `Showing ${count} ${count === 1 ? 'project' : 'projects'}.`;
  }));

  if ('IntersectionObserver' in window) {
    const videoObserver = new IntersectionObserver(entries => {
      videoVisible = entries[0].isIntersecting;
      if (!videoVisible) video.pause();
      else if (!userPaused && !motionQuery.matches && !navigator.connection?.saveData && !document.hidden) playVideo();
    }, { threshold: .05 });
    videoObserver.observe(video);

    if (!motionQuery.matches) {
      const revealObserver = new IntersectionObserver(entries => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.remove('is-revealing');
            revealObserver.unobserve(entry.target);
          }
        });
      }, { threshold: .08 });
      document.querySelectorAll('.reveal').forEach(element => {
        element.classList.add('is-revealing');
        revealObserver.observe(element);
      });
    }

    const sectionObserver = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        navLinks.querySelectorAll('a').forEach(link => {
          const active = link.hash === `#${entry.target.id}`;
          link.classList.toggle('active', active);
          if (active) link.setAttribute('aria-current', 'location');
          else link.removeAttribute('aria-current');
        });
      });
    }, { rootMargin: '-15% 0px -65% 0px', threshold: 0 });
    document.querySelectorAll('main > section[id]').forEach(section => sectionObserver.observe(section));
  }
})();
