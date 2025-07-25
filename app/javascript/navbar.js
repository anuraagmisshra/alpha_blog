// iOS-compatible navbar functionality with Bootstrap integration
export function initializeNavbar() {
    const navbarToggler = document.querySelector('.navbar-toggler');
    const navbarCollapse = document.querySelector('.navbar-collapse');

    if (navbarToggler && navbarCollapse) {
        // Clean up any existing Bootstrap instances
        const existingCollapse = bootstrap.Collapse.getInstance(navbarCollapse);
        if (existingCollapse) {
            existingCollapse.dispose();
        }

        // Initialize Bootstrap Collapse with iOS-friendly options
        const bsCollapse = new bootstrap.Collapse(navbarCollapse, {
            toggle: false,
            parent: false
        });

        // Initialize Bootstrap Dropdowns with hover functionality
        const dropdownElementList = document.querySelectorAll('.dropdown-toggle');

        const dropdownList = [...dropdownElementList].map(dropdownToggleEl => {
            // Clean up any existing dropdown instance first
            const existingDropdown = bootstrap.Dropdown.getInstance(dropdownToggleEl);
            if (existingDropdown) {
                existingDropdown.dispose();
            }

            // Initialize Bootstrap dropdown
            const dropdown = new bootstrap.Dropdown(dropdownToggleEl, {
                autoClose: true,
                boundary: 'viewport'
            });

            // Add hover functionality for desktop only
            const dropdownParent = dropdownToggleEl.closest('.dropdown');

            if (dropdownParent) {
                function showDropdown() {
                    if (window.innerWidth >= 992) { // Desktop only
                        dropdown.show();
                    }
                }

                function hideDropdown() {
                    if (window.innerWidth >= 992) { // Desktop only
                        setTimeout(() => {
                            if (!dropdownParent.matches(':hover')) {
                                dropdown.hide();
                            }
                        }, 150);
                    }
                }

                // Add hover events
                dropdownParent.addEventListener('mouseenter', showDropdown);
                dropdownParent.addEventListener('mouseleave', hideDropdown);

                // Store for cleanup
                dropdownToggleEl._hoverHandlers = {
                    showDropdown,
                    hideDropdown,
                    dropdownParent
                };
            }

            return dropdown;
        });

        // iOS-compatible event handling for the toggler
        function handleToggleClick(e) {
            e.preventDefault();
            e.stopPropagation();
            bsCollapse.toggle();
        }

        // Remove existing listeners to prevent duplicates
        navbarToggler.removeEventListener('click', handleToggleClick);
        navbarToggler.removeEventListener('touchstart', handleToggleClick);

        // Add both click and touchstart for iOS compatibility
        navbarToggler.addEventListener('click', handleToggleClick, { passive: false });
        navbarToggler.addEventListener('touchstart', handleToggleClick, { passive: false });

        // Close navbar when clicking outside (iOS-compatible)
        function handleOutsideClick(event) {
            const isClickInsideNav = navbarCollapse.contains(event.target) ||
                navbarToggler.contains(event.target);

            if (!isClickInsideNav && navbarCollapse.classList.contains('show')) {
                bsCollapse.hide();
            }
        }

        // Use both click and touchstart for outside clicks on iOS
        document.addEventListener('click', handleOutsideClick, true);
        document.addEventListener('touchstart', handleOutsideClick, true);

        // Close navbar when clicking on nav links (mobile-friendly)
        const navLinks = navbarCollapse.querySelectorAll('.nav-link, .dropdown-item');
        navLinks.forEach(function (link) {
            function handleLinkClick() {
                if (window.innerWidth < 992) {
                    // Small delay to allow link navigation
                    setTimeout(() => {
                        bsCollapse.hide();
                    }, 100);
                }
            }

            link.removeEventListener('click', handleLinkClick);
            link.removeEventListener('touchstart', handleLinkClick);

            link.addEventListener('click', handleLinkClick);
            link.addEventListener('touchstart', handleLinkClick, { passive: true });
        });

        // Handle tab navigation for active state management
        const tabLinks = navbarCollapse.querySelectorAll('.nav-tabs-custom .nav-link');
        tabLinks.forEach(function (tabLink) {
            function handleTabClick(e) {
                // Don't prevent default navigation
                // Just update visual state and close mobile menu

                // Remove active from all tabs
                tabLinks.forEach(tab => tab.classList.remove('active'));

                // Add active to clicked tab
                tabLink.classList.add('active');

                // Close mobile menu
                if (window.innerWidth < 992) {
                    setTimeout(() => {
                        bsCollapse.hide();
                    }, 100);
                }
            }

            tabLink.removeEventListener('click', handleTabClick);
            tabLink.removeEventListener('touchstart', handleTabClick);

            tabLink.addEventListener('click', handleTabClick);
            tabLink.addEventListener('touchstart', handleTabClick, { passive: true });
        });

        // iOS-specific: Prevent scroll on navbar toggle
        navbarToggler.addEventListener('touchmove', function (e) {
            e.preventDefault();
        }, { passive: false });

        // Store references for cleanup including dropdowns
        navbarToggler._cleanupHandlers = [
            () => navbarToggler.removeEventListener('click', handleToggleClick),
            () => navbarToggler.removeEventListener('touchstart', handleToggleClick),
            () => document.removeEventListener('click', handleOutsideClick, true),
            () => document.removeEventListener('touchstart', handleOutsideClick, true),
            () => {
                // Clean up dropdown instances and hover handlers
                dropdownList.forEach(dropdown => {
                    if (dropdown) dropdown.dispose();
                });
                // Clean up hover event listeners for all dropdowns
                document.querySelectorAll('.dropdown-toggle').forEach(element => {
                    if (element._hoverHandlers) {
                        const { showDropdown, hideDropdown, dropdownParent } = element._hoverHandlers;
                        dropdownParent.removeEventListener('mouseenter', showDropdown);
                        dropdownParent.removeEventListener('mouseleave', hideDropdown);
                        delete element._hoverHandlers;
                    }
                });
            }
        ];
    }
}

// Cleanup function for page transitions
export function cleanupNavbar() {
    const navbarToggler = document.querySelector('.navbar-toggler');
    if (navbarToggler && navbarToggler._cleanupHandlers) {
        navbarToggler._cleanupHandlers.forEach(cleanup => cleanup());
        delete navbarToggler._cleanupHandlers;
    }

    // Additional cleanup for any remaining dropdown instances and hover handlers
    const dropdownElements = document.querySelectorAll('.dropdown-toggle');
    dropdownElements.forEach(element => {
        const dropdownInstance = bootstrap.Dropdown.getInstance(element);
        if (dropdownInstance) {
            dropdownInstance.dispose();
        }

        // Clean up hover handlers
        if (element._hoverHandlers) {
            const { showDropdown, hideDropdown, dropdownParent } = element._hoverHandlers;
            dropdownParent.removeEventListener('mouseenter', showDropdown);
            dropdownParent.removeEventListener('mouseleave', hideDropdown);
            delete element._hoverHandlers;
        }
    });
}
