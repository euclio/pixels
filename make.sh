set -euxo pipefail

RUSTFLAGS=--cfg=web_sys_unstable_apis cargo build --target wasm32-unknown-unknown --manifest-path examples/minimal-winit/Cargo.toml
rm -rf target/generated
wasm-bindgen --out-dir target/generated --web target/wasm32-unknown-unknown/debug/minimal-winit.wasm
cat << EOF > target/generated/index.html
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
EOF
cd target/generated
python -m http.server
