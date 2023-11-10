# Type a script or drag a script file from your workspace to insert its path.
if [[ -f "${PODS_ROOT}/SwiftGen/bin/swiftgen" ]]; then
  "${PODS_ROOT}/SwiftGen/bin/swiftgen" config run --config swiftgen.yml
else
  echo "warning: SwiftGen is not installed. Run 'pod install --repo-update' to install it."
fi
