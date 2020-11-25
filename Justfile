serve:
    RUSTFLAGS=--cfg=web_sys_unstable_apis cargo build --target wasm32-unknown-unknown --manifest-path examples/minimal-winit/Cargo.toml
    rm -rf target/generated
    wasm-bindgen --out-dir target/generated --web target/wasm32-unknown-unknown/debug/minimal-winit.wasm
    cp index.html target/generated
    python -m http.server
