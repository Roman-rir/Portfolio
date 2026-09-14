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
  const toolkitScroll = document.querySelector('.toolkit-scroll');
  const toolkitMotionToggle = document.getElementById('toolkitMotionToggle');
  let toolkitPaused = false;
  function syncToolkitMotion() {
    root.dataset.toolkitMotion = toolkitPaused || motionQuery.matches || document.hidden ? 'paused' : 'running';
    toolkitMotionToggle.hidden = motionQuery.matches;
    toolkitMotionToggle.textContent = toolkitPaused ? 'Resume scrolling' : 'Pause scrolling';
    toolkitMotionToggle.setAttribute('aria-pressed', String(toolkitPaused));
  }
  toolkitMotionToggle.addEventListener('click', () => {
    toolkitPaused = !toolkitPaused;
    syncToolkitMotion();
  });
  motionQuery.addEventListener('change', syncToolkitMotion);
  document.addEventListener('visibilitychange', syncToolkitMotion);
  syncToolkitMotion();
  if ('IntersectionObserver' in window) {
    new IntersectionObserver(entries => {
      toolkitScroll.classList.toggle('is-in-view', entries[0].isIntersecting);
    }, { threshold: .05 }).observe(toolkitScroll);
  } else toolkitScroll.classList.add('is-in-view');

  let progressPending = false;
  function updateReadingProgress() {
    if (progressPending) return;
    progressPending = true;
    requestAnimationFrame(() => {
      const distance = document.documentElement.scrollHeight - innerHeight;
      root.style.setProperty('--reading-progress', distance > 0 ? Math.min(1, Math.max(0, scrollY / distance)) : 0);
      progressPending = false;
    });
  }
  window.addEventListener('scroll', updateReadingProgress, { passive: true });
  window.addEventListener('resize', updateReadingProgress);
  window.addEventListener('load', updateReadingProgress);
  updateReadingProgress();
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
  function setupBackgroundVideo(videoId, toggleId, label) {
    const video = document.getElementById(videoId);
    const toggle = document.getElementById(toggleId);
    let userPaused = false;
    let visible = !('IntersectionObserver' in window);
    function updateButton() {
      toggle.classList.toggle('is-paused', video.paused);
      const action = `${video.paused ? 'Play' : 'Pause'} ${label}`;
      toggle.setAttribute('aria-label', action);
      toggle.title = action;
    }
    function play() {
      const request = video.play();
      if (request) request.catch(updateButton);
    }
    function syncPlayback() {
      if (!visible || document.hidden || motionQuery.matches || navigator.connection?.saveData) video.pause();
      else if (!userPaused) play();
    }
    toggle.addEventListener('click', () => {
      if (video.paused) { userPaused = false; play(); }
      else { userPaused = true; video.pause(); }
    });
    video.addEventListener('play', updateButton);
    video.addEventListener('pause', updateButton);
    video.addEventListener('error', () => { toggle.hidden = true; });
    motionQuery.addEventListener('change', syncPlayback);
    document.addEventListener('visibilitychange', syncPlayback);
    updateButton();
    if ('IntersectionObserver' in window) {
      new IntersectionObserver(entries => {
        visible = entries[0].isIntersecting;
        syncPlayback();
      }, { threshold: .05 }).observe(video);
    } else syncPlayback();
  }
  setupBackgroundVideo('heroVideo', 'videoToggle', 'background video');
  setupBackgroundVideo('aboutVideo', 'aboutVideoToggle', 'About background video');

  const recognitionFlow = document.getElementById('recognitionFlow');
  const recognitionToggle = document.getElementById('recognitionMotionToggle');
  let recognitionPaused = false;
  function syncRecognitionMotion() {
    root.dataset.recognitionMotion = recognitionPaused || motionQuery.matches || document.hidden ? 'paused' : 'running';
    recognitionToggle.hidden = motionQuery.matches;
    recognitionToggle.textContent = recognitionPaused ? 'Resume recognition animations' : 'Pause recognition animations';
    recognitionToggle.setAttribute('aria-pressed', String(recognitionPaused));
  }
  recognitionToggle.addEventListener('click', () => {
    recognitionPaused = !recognitionPaused;
    syncRecognitionMotion();
  });
  motionQuery.addEventListener('change', syncRecognitionMotion);
  document.addEventListener('visibilitychange', syncRecognitionMotion);
  syncRecognitionMotion();
  if ('IntersectionObserver' in window) {
    new IntersectionObserver(entries => {
      recognitionFlow.classList.toggle('is-in-view', entries[0].isIntersecting);
    }, { threshold: .05 }).observe(recognitionFlow);
  } else recognitionFlow.classList.add('is-in-view');

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
    updateReadingProgress();
  }));

  document.querySelectorAll('[data-reset-projects]').forEach(link => link.addEventListener('click', () => filters[0].click()));

  if ('IntersectionObserver' in window) {

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
