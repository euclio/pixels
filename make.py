#!/usr/bin/env python3

import os
import shutil
import subprocess
import textwrap

subprocess.run(
    [
        "cargo",
        "build",
        "--target",
        "wasm32-unknown-unknown",
        "--manifest-path",
        "examples/minimal-winit/Cargo.toml",
    ],
    env=dict(os.environ, **{"RUSTFLAGS": "--cfg=web_sys_unstable_apis"}),
    check=True,
)
shutil.rmtree("target/generated", ignore_errors=True)
subprocess.run(
    [
        "wasm-bindgen",
        "--out-dir",
        "target/generated",
        "--web",
        "target/wasm32-unknown-unknown/debug/minimal-winit.wasm",
    ],
    check=True,
)
with open("target/generated/index.html", "w") as f:
    f.write(
        textwrap.dedent(
            """
            <html>
              <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
              </head>
              <body>
                <script type="module">
                  import init from "./minimal-winit.js";
                  init();
                </script>
              </body>
            </html>
            """
        )
    )
subprocess.run(["python3", "-m", "http.server"], cwd="target/generated", check=True)
