#[test]
fn package_name_is_available() {
	assert_eq!(env!("CARGO_PKG_NAME"), "{{ crate_name }}");
}
