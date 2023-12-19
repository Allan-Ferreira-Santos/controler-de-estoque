project_run: 
	@echo "[APP] init flutter version"
	echo yes | fvm use stable --force

build_runner_clean:
	@echo "[APP] Cleanup build_runner ..."
	@($(FLUTTER_CMD)fvm flutter pub run build_runner clean)

build_runner: build_runner_clean
	@echo "[APP] build_runner build ..."
	@($(FLUTTER_CMD) fvm flutter pub run build_runner build --delete-conflicting-outputs)

build_runner_watch: build_runner_clean
	@echo "[APP] build_runner build ..."
	@($(FLUTTER_CMD) fvm flutter pub run build_runner watch --delete-conflicting-outputs)