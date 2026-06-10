.PHONY: install run1 run2 run3 clean

# Install dependencies for all tasks
install:
	@echo "Installing dependencies for all tasks..."
	@if [ -d "task1-upload-queue" ] && [ -f "task1-upload-queue/package.json" ]; then \
		cd task1-upload-queue && npm install; \
	else \
		echo "Task 1 not initialized yet. Run 'npm create vite@latest' in task1-upload-queue/"; \
	fi
	@if [ -d "task2-file-list" ] && [ -f "task2-file-list/package.json" ]; then \
		cd task2-file-list && npm install; \
	else \
		echo "Task 2 not initialized yet. Run 'npm create vite@latest' in task2-file-list/"; \
	fi
	@if [ -d "task3-chunk-upload" ] && [ -f "task3-chunk-upload/package.json" ]; then \
		cd task3-chunk-upload && npm install; \
	else \
		echo "Task 3 not initialized yet. Run 'npm create vite@latest' in task3-chunk-upload/"; \
	fi

# Run task 1: Upload Queue
run1:
	@echo "Running Task 1: Upload Queue..."
	@cd task1-upload-queue && npm run dev

# Run task 2: File List
run2:
	@echo "Running Task 2: File List..."
	@cd task2-file-list && npm run dev

# Run task 3: Chunk Upload
run3:
	@echo "Running Task 3: Chunk Upload..."
	@cd task3-chunk-upload && npm run dev

# Clean all node_modules
clean:
	@echo "Cleaning node_modules..."
	@rm -rf task1-upload-queue/node_modules
	@rm -rf task2-file-list/node_modules
	@rm -rf task3-chunk-upload/node_modules
	@echo "Clean complete!"
