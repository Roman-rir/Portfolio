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
  const navIndicator = document.createElement('span');
  navIndicator.className = 'nav-indicator';
  navIndicator.setAttribute('aria-hidden', 'true');
  navLinks.append(navIndicator);
  navLinks.classList.add('has-indicator');
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

  const siteNav = document.querySelector('.site-nav');
  const hero = document.querySelector('.personal-hero');
  const experienceChain = document.querySelector('.experience-chain');
  const chainItems = experienceChain.querySelectorAll('.t-item');
  let progressPending = false;
  function updateReadingProgress() {
    if (progressPending) return;
    progressPending = true;
    requestAnimationFrame(() => {
      const distance = document.documentElement.scrollHeight - innerHeight;
      root.style.setProperty('--reading-progress', distance > 0 ? Math.min(1, Math.max(0, scrollY / distance)) : 0);
      siteNav.classList.toggle('is-scrolled', scrollY > 8);
      if (!motionQuery.matches) {
        if (scrollY < innerHeight * 1.3) hero.style.setProperty('--hero-scroll', scrollY.toFixed(1));
        // Fill the experience rail from the first node to the last as the timeline passes.
        const chain = experienceChain.getBoundingClientRect();
        const progress = Math.min(1, Math.max(0, (innerHeight * .65 - chain.top) / chain.height));
        const nodeSize = chainItems[0].querySelector('.timeline-node').offsetHeight;
        const railLength = chainItems[chainItems.length - 1].offsetTop - nodeSize;
        experienceChain.style.setProperty('--chain-h', `${(progress * railLength).toFixed(1)}px`);
      }
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
    projectMotionToggle.hidden = motionQuery.matches || projectVisuals.length === 0;
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

  // Switch project views without cropping the full-size source images.
  document.querySelectorAll('[data-project-gallery]').forEach(gallery => {
    const main = gallery.querySelector('[data-gallery-main]');
    const image = main.querySelector('img');
    const title = gallery.querySelector('[data-gallery-title]');
    const detail = gallery.querySelector('[data-gallery-detail]');
    const count = gallery.querySelector('[data-gallery-count]');
    const choices = Array.from(gallery.querySelectorAll('[data-gallery-select]'));
    const figure = main.closest('.work-figure');
    let swapTimer;
    choices.forEach((choice, index) => choice.addEventListener('click', () => {
      if (choice.getAttribute('aria-pressed') === 'true') return;
      const preview = choice.querySelector('img');
      // Fade the current image out, swap the source, and fade back in once the new image is ready.
      const animate = !motionQuery.matches;
      if (animate) {
        image.classList.add('is-swapping');
        figure.classList.add('is-swapping');
      }
      clearTimeout(swapTimer);
      swapTimer = setTimeout(() => {
        const reveal = () => { image.classList.remove('is-swapping'); figure.classList.remove('is-swapping'); };
        image.addEventListener('load', reveal, { once: true });
        image.addEventListener('error', reveal, { once: true });
        image.setAttribute('src', preview.getAttribute('src'));
        if (image.complete) reveal();
      }, animate ? 220 : 0);
      image.alt = preview.alt;
      image.setAttribute('width', preview.getAttribute('width'));
      image.setAttribute('height', preview.getAttribute('height'));
      main.setAttribute('href', choice.dataset.fullsize || preview.getAttribute('src'));
      main.dataset.tone = choice.dataset.tone;
      main.setAttribute('aria-label', `Open full-size image: ${choice.dataset.title}`);
      title.textContent = choice.dataset.title;
      detail.textContent = choice.dataset.detail;
      count.textContent = `${String(index + 1).padStart(2, '0')} / ${String(choices.length).padStart(2, '0')}`;
      choices.forEach(item => item.setAttribute('aria-pressed', String(item === choice)));
    }));
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
    updateReadingProgress();
  }));

  document.querySelectorAll('[data-reset-projects]').forEach(link => link.addEventListener('click', () => filters[0].click()));

  if ('IntersectionObserver' in window) {

    if (!motionQuery.matches) {
      // Wrap each heading word so it can rise into view once its block is revealed.
      document.querySelectorAll('.reveal h2').forEach(heading => {
        let index = 0;
        (function split(node) {
          Array.from(node.childNodes).forEach(child => {
            if (child.nodeType === Node.ELEMENT_NODE) { split(child); return; }
            if (child.nodeType !== Node.TEXT_NODE || !child.textContent.trim()) return;
            const fragment = document.createDocumentFragment();
            child.textContent.split(/(\s+)/).forEach(part => {
              if (!part) return;
              if (/^\s+$/.test(part)) { fragment.append(part); return; }
              const word = document.createElement('span');
              const inner = document.createElement('span');
              word.className = 'word';
              inner.textContent = part;
              inner.style.setProperty('--w', index++);
              word.append(inner);
              fragment.append(word);
            });
            child.replaceWith(fragment);
          });
        })(heading);
      });

      // Blocks entering together are staggered; once settled, hover transitions run without delay.
      const revealObserver = new IntersectionObserver(entries => {
        let batch = 0;
        entries.forEach(entry => {
          if (!entry.isIntersecting) return;
          const element = entry.target;
          element.style.setProperty('--reveal-delay', `${Math.min(batch++, 5) * 90}ms`);
          element.classList.remove('is-revealing');
          element.classList.add('has-entered');
          setTimeout(() => element.classList.add('is-settled'), 1500);
          revealObserver.unobserve(element);
        });
      }, { threshold: .08, rootMargin: '0px 0px -6% 0px' });
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
        moveNavIndicator();
      });
    }, { rootMargin: '-15% 0px -65% 0px', threshold: 0 });
    document.querySelectorAll('main > section[id]').forEach(section => sectionObserver.observe(section));
  }

  // A sliding marker under the active (or hovered) navigation link.
  function moveNavIndicator(target = navLinks.querySelector('a.active')) {
    navIndicator.classList.toggle('is-visible', Boolean(target));
    if (!target) return;
    navIndicator.style.setProperty('--nav-x', `${target.offsetLeft}px`);
    navIndicator.style.setProperty('--nav-w', `${target.offsetWidth}px`);
  }
  navLinks.querySelectorAll('a').forEach(link => {
    link.addEventListener('pointerenter', () => moveNavIndicator(link));
    link.addEventListener('focus', () => moveNavIndicator(link));
  });
  navLinks.addEventListener('pointerleave', () => moveNavIndicator());
  navLinks.addEventListener('focusout', () => moveNavIndicator());
  window.addEventListener('resize', () => moveNavIndicator());
  document.fonts?.ready.then(() => moveNavIndicator());

  // Hero stats count up once, the first time they are seen.
  function formatStat(element, value) {
    element.textContent = String(value).padStart(Number(element.dataset.pad || 0), '0') + (element.dataset.suffix || '');
  }
  if (!motionQuery.matches && 'IntersectionObserver' in window) {
    const statObserver = new IntersectionObserver(entries => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        statObserver.unobserve(entry.target);
        const element = entry.target;
        const target = Number(element.dataset.count);
        const start = performance.now() + 700;
        formatStat(element, 0);
        (function tick(now) {
          const t = Math.min(1, Math.max(0, (now - start) / 1200));
          formatStat(element, Math.round(target * (1 - Math.pow(1 - t, 3))));
          if (t < 1) requestAnimationFrame(tick);
        })(performance.now());
      });
    }, { threshold: .6 });
    document.querySelectorAll('[data-count]').forEach(stat => statObserver.observe(stat));
  }

  // Rotating focus areas in the hero panel; screen readers get the full list instead.
  const rotator = document.querySelector('.hero-rotator');
  const rotatorWords = rotator.dataset.words.split('|');
  let rotatorIndex = 0;
  setInterval(() => {
    if (motionQuery.matches || document.hidden) return;
    rotatorIndex = (rotatorIndex + 1) % rotatorWords.length;
    rotator.classList.remove('is-swapping');
    void rotator.offsetWidth;
    rotator.classList.add('is-swapping');
    setTimeout(() => { rotator.textContent = rotatorWords[rotatorIndex]; }, 280);
  }, 2800);

  // Pointer effects run only for precise pointers with motion allowed.
  const finePointer = window.matchMedia('(hover: hover) and (pointer: fine)');
  const pointerMotion = () => finePointer.matches && !motionQuery.matches;

  document.querySelectorAll('.proj-card, .skill-group, .certificate-card, .honor-feature, .logo-tile, .research-banner, .recognition-step').forEach(card => {
    const glow = document.createElement('span');
    glow.className = 'spotlight';
    glow.setAttribute('aria-hidden', 'true');
    card.prepend(glow);
    card.addEventListener('pointermove', event => {
      if (!finePointer.matches) return;
      const rect = card.getBoundingClientRect();
      card.style.setProperty('--mx', `${event.clientX - rect.left}px`);
      card.style.setProperty('--my', `${event.clientY - rect.top}px`);
    });
  });

  document.querySelectorAll('.btn-primary, .nav-cta').forEach(button => {
    button.addEventListener('pointermove', event => {
      if (!pointerMotion()) return;
      const rect = button.getBoundingClientRect();
      button.style.setProperty('--mag-x', `${((event.clientX - rect.left) / rect.width - .5) * 10}px`);
      button.style.setProperty('--mag-y', `${((event.clientY - rect.top) / rect.height - .5) * 8}px`);
    });
    button.addEventListener('pointerleave', () => {
      button.style.removeProperty('--mag-x');
      button.style.removeProperty('--mag-y');
    });
  });

  hero.addEventListener('pointermove', event => {
    if (!pointerMotion()) return;
    const rect = hero.getBoundingClientRect();
    hero.style.setProperty('--hx', `${event.clientX - rect.left}px`);
    hero.style.setProperty('--hy', `${event.clientY - rect.top}px`);
    hero.style.setProperty('--px', ((event.clientX - rect.left) / rect.width - .5).toFixed(3));
    hero.style.setProperty('--py', ((event.clientY - rect.top) / rect.height - .5).toFixed(3));
    hero.style.setProperty('--glow-on', 1);
  });
  hero.addEventListener('pointerleave', () => {
    ['--px', '--py'].forEach(name => hero.style.removeProperty(name));
    hero.style.setProperty('--glow-on', 0);
  });
})();
