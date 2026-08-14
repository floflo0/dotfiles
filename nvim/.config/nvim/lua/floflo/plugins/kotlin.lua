return {
    'AlexandrosAlexiou/kotlin.nvim',
    ft = { "kotlin" },
    lazy = false,
    dependencies = {
        {
            'mason-org/mason.nvim',
            config = true,
            lazy = false,
        },
        {
            'mason-org/mason-lspconfig.nvim',
            lazy = false,
        },
        {
            'folke/trouble.nvim',
            lazy = false,
        },
        -- nvim-dap is NOT a kotlin.nvim dependency. Install and configure it
        -- separately (signs, keymaps, optionally nvim-dap-ui). kotlin.nvim only
        -- registers a `kotlin` adapter and the `:KotlinDebug` command on top.
        -- See the "Debugging Support" section below for details.
    },
    config = function()
        require('kotlin').setup {
            -- Optional: Specify root markers for multi-module projects
            -- Default: { "build.gradle", "build.gradle.kts", "pom.xml", "mvnw" }
            root_markers = {
                "gradlew",
                ".git",
                "mvnw",
                "pom.xml",
                "settings.gradle",
            },

            -- Optional: Java Runtime to run the kotlin-lsp server itself
            -- LEGACY ONLY — ignored on v262.4739.0+ (bin/intellij-server manages
            -- its own JBR; a warning is shown if this is set on a new install).
            -- Only useful with older builds that ship kotlin-lsp.sh / kotlin-lsp.cmd.
            --
            -- When set, the plugin parses JVM args from the bundled launcher script
            -- and invokes your custom JRE with the correct flags
            -- Must point to JAVA_HOME (directory containing bin/java)
            -- Examples:
            --   macOS:   "/Library/Java/JavaVirtualMachines/jdk-25.jdk/Contents/Home"
            --   Linux:   "/usr/lib/jvm/java-25-openjdk"
            --   Windows: "C:\\Program Files\\Java\\jdk-25"
            --   Env var: os.getenv("JAVA_HOME") or os.getenv("JDK25")
            jre_path = nil,

            -- Optional: JDK for symbol resolution (analyzing your Kotlin code)
            -- This is the JDK that your project code will be analyzed against
            -- Different from jre_path (which runs the server)
            -- Required for: Analyzing JDK APIs, standard library symbols, platform types
            --
            -- Usually should match your project's target JDK version
            -- Examples:
            --   macOS:   "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"
            --   Linux:   "/usr/lib/jvm/java-17-openjdk"
            --   Windows: "C:\\Program Files\\Java\\jdk-17"
            --   SDKMAN:  os.getenv("HOME") .. "/.sdkman/candidates/java/17.0.8-tem"
            jdk_for_symbol_resolution = "/usr/lib/jvm/java-21-openjdk-amd64",

            -- Optional: Specify additional JVM arguments for the kotlin-lsp server
            jvm_args = {
                "-Xms8g",
                "-Xmx8g",  -- Increase max heap (useful for large projects)
                "-XX:+UseLargePages",
                "-XX:+AlwaysPreTouch",
            },

            -- Optional: Configure inlay hints (requires kotlin-lsp v261+)
            -- All settings default to true, set to false to disable specific hints
            inlay_hints = {
                enabled = false,  -- Enable inlay hints (auto-enable on LSP attach)
                parameters = false,  -- Show parameter names
                parameters_compiled = false,  -- Show compiled parameter names
                parameters_excluded = false,  -- Show excluded parameter names
                types_property = false,  -- Show property types
                types_variable = false,  -- Show local variable types
                function_return = false,  -- Show function return types
                function_parameter = false,  -- Show function parameter types
                lambda_return = false,  -- Show lambda return types
                lambda_receivers_parameters = false,  -- Show lambda receivers/parameters
                value_ranges = false,  -- Show value ranges
                kotlin_time = false,  -- Show kotlin.time warnings
            },

            -- Optional: LSP-driven folding (requires kotlin-lsp v262.4739.0+)
            -- Enabled by default; set folding.enabled = false to opt out.
            folding = { enabled = false },

            -- Optional: build-importer preference (requires kotlin-lsp v262.4739.0+)
            -- Mirrors the VSCode `intellij.buildTool` setting:
            --   nil = let the server pick (default)
            --   "gradle" or "maven" = force a specific importer
            --   ""    = none (single-file / no build system)
            -- build_tool = "gradle",

            -- Optional: file templates for new Kotlin files (requires kotlin-lsp v262.4739.0+)
            -- When you create a new .kt file the plugin asks the server to interpolate the
            -- chosen template. Pass a table of name → Velocity template to override the
            -- defaults (Class, File, Interface, Data Class, Enum, Annotation, Object).
            -- Set { enabled = false } on the table to disable the prompt entirely.
            -- file_templates = {
            --     enabled = true,
            --     -- Class = "package ${PACKAGE_NAME}\n\nclass ${NAME} {\n\t|\n}",
            -- },
        }
    end,
}
