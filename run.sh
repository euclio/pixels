RUSTFLAGS=--cfg=web_sys_unstable_apis cargo build --manifest-path examples/minimal-winit/Cargo.toml --target wasm32-unknown-unknown
wasm-bindgen --out-dir target/generated --web target/wasm32-unknown-unknown/debug/minimal-winit.wasm --debug
python -m http.server
