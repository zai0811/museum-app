// Import and register all your exceptions from the importmap under exceptions/*

import { application } from "controllers/application"

// Eager load all exceptions defined in the import map under exceptions/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load exceptions as they appear in the DOM (remember not to preload exceptions in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("exceptions", application)
