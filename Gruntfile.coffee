"use strict"

module.exports = ( grunt ) ->

    require( "matchdep" ).filterDev( "grunt-*" ).forEach grunt.loadNpmTasks

    grunt.initConfig
        # HTML
        jade:
            options:
                pretty: yes
            pages:
                expand: yes
                cwd: 'jade'
                src: [ "*.jade" ]
                dest: '.'
                ext: '.html'
        # CSS
        stylus:
            options:
                compress: no
                use: [
                    require "kouto-swiss"
                ]
            styles:
                files:
                    "styles/styles.css": "styles/stylus/styles.styl"
        csslint:
            options:
                "box-model": no
                "non-link-hover": no
                "adjoining-classes": no
                "box-sizing": no
                "compatible-vendor-prefixes": no
                "gradients": no
                "text-indent": no
                "fallback-colors": no
                "font-faces": no
                "universal-selector": no
                "unqualified-attributes": no
                "overqualified-elements": no
                "floats": no
                "font-sizes": no
                "ids": no
                "important": no
                "outline-none": no
                "qualified-headings": no
                "unique-headings": no
                "duplicate-background-images": no
            styles:
                files:
                    src: [
                        "styles/styles.css"
                    ]
        csso:
            options:
                report: "gzip"
            styles:
                files:
                    "styles/styles.min.css": "styles/styles.css"
        # JS
        bower:
            options:
                targetDir: "scripts/vendors"
                cleanup: yes
            vendors: {}
        coffeelint:
            options:
                arrow_spacing:
                    level: "error"
                camel_case_classes:
                    level: "error"
                colon_assignment_spacing:
                    spacing:
                        left: 0
                        right: 1
                    level: "error"
                duplicate_key:
                    level: "error"
                empty_constructor_needs_parens:
                    level: "error"
                indentation:
                    level: "ignore"
                max_line_length:
                    level: "ignore"
                no_backticks:
                    level: "error"
                no_empty_param_list:
                    level: "error"
                no_stand_alone_at:
                    level: "error"
                no_tabs:
                    level: "error"
                no_throwing_strings:
                    level: "error"
                no_trailing_semicolons:
                    level: "error"
                no_unnecessary_fat_arrows:
                    level: "error"
                space_operators:
                    level: "error"
            scripts:
                files:
                    src: [ "scripts/coffee/*.coffee" ]
        coffee:
            scripts:
                expand: yes
                cwd: 'scripts/coffee'
                src: [ "*.coffee" ],
                dest: 'scripts',
                ext: '.js'
        uglify:
            options:
                foo: yes
            vendors:
                expand: yes
                cwd: 'scripts/vendors'
                src: [ "**/*.js", "!**/*.min.js" ],
                dest: 'scripts/vendors',
                ext: '.min.js'
            scripts:
                expand: yes
                cwd: 'scripts'
                src: [ "*.js", "!*.min.js" ],
                dest: 'scripts',
                ext: '.min.js'
        # Preview
        connect:
            pages:
                options:
                    port: 8888
                    hostname: "*"
                    base: "."
                    keepalive: yes
                    livereload: yes
        # Watch
        watch:
            options:
                livereload: yes
            jade:
                files: "jade/**/*.jade"
                tasks: [ "jade" ]
            styles:
                files: "styles/stylus/**/*.styl"
                tasks: [ "styles" ]
            scripts:
                files: "scripts/coffee/**/*.coffee"
                tasks: [ "scripts" ]
            docs:
                files: "_docs/**/*.md"
                tasks: [ "generate" ]
        concurrent:
            docs:
                tasks: [ "connect", "watch" ]
                options:
                    logConcurrentOutput: yes

    grunt.registerTask "default", [
        "html"
        "styles"
        "bower"
        "scripts"
    ]

    grunt.registerTask "html", [
        "jade"
    ]

    grunt.registerTask "styles", [
        "stylus"
        "csslint"
        "csso"
    ]

    grunt.registerTask "scripts", [
        "coffeelint"
        "coffee"
        "uglify"
    ]

    grunt.registerTask "preview", [
        "default"
        "connect"
    ]

    grunt.registerTask "work", [
        "default"
        "concurrent"
    ]
