#!/usr/bin/env bash

if [[ "$PLATFORM_NAME" == *simulator* ]]; then
	exit 0
fi

echo 'codesign dylibs'
for lib in $(find "$CODESIGNING_FOLDER_PATH/Frameworks" -iname '*.dylib'); do
	codesign --verbose=4 --force --timestamp=none --sign "$EXPANDED_CODE_SIGN_IDENTITY" "$lib"
done
