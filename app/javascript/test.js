// Entry point for the build script in your package.json
import "bootstrap"
import { initializeNavbar, cleanupNavbar } from "./navbar.js"

// Import Bootstrap JavaScript
import * as bootstrap from "bootstrap"

// Make Bootstrap available globally
window.bootstrap = bootstrap

console.log("Application JS loaded")

// Active Storage  
import "@rails/activestorage"
