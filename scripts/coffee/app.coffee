###
 * Koupe
 *
 * COFFEE/JS Document - ~/scripts/app.js - Main Script
 *
 * coded by leny @ krkn
 * started at 05/09/14
###

$ ->
    console.log "koupe:started"

    $ 'a[rel*="external"]'
        .attr "target", "_new"
