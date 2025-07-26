// Entry point for the build script in your package.json
import "bootstrap"
import { initializeNavbar, cleanupNavbar } from "./navbar.js"

// Import Bootstrap JavaScript
import * as bootstrap from "bootstrap"

// Make Bootstrap available globally
window.bootstrap = bootstrap

// Turbo for fast page navigation
import "@hotwired/turbo-rails"

// Active Storage  
import "@rails/activestorage"

// Initialize components when page loads
document.addEventListener('DOMContentLoaded', function () {
    // Enable all tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })

    // Enable all popovers
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    })

    // Initialize iOS-compatible navbar (handles dropdowns internally)
    initializeNavbar();
})

// Re-initialize components after Turbo navigation
document.addEventListener('turbo:load', function () {
    // Clean up previous navbar instance
    cleanupNavbar();

    // Reinitialize tooltips after page change
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })

    // Reinitialize popovers after page change
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    })

    // Reinitialize iOS-compatible navbar (handles dropdowns internally)
    initializeNavbar();
})

import "trix"
import "@rails/actiontext"