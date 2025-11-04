# Makefile for im-select

# Compiler and flags
SWIFTC = swiftc
SWIFT_FLAGS = -O
TARGET = im-select
SOURCE = main.swift

# Installation paths
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

# Default target
all: $(TARGET)

# Build the binary
$(TARGET): $(SOURCE)
	$(SWIFTC) $(SWIFT_FLAGS) $(SOURCE) -o $(TARGET)

# Build without optimization (for debugging)
debug: SWIFT_FLAGS = -g
debug: clean $(TARGET)

# Install the binary
install: $(TARGET)
	install -d $(BINDIR)
	install -m 755 $(TARGET) $(BINDIR)/$(TARGET)

# Uninstall the binary
uninstall:
	rm -f $(BINDIR)/$(TARGET)

# Clean build artifacts
clean:
	rm -fr $(TARGET) *.dSYM

# Run the program (query current input method)
run: $(TARGET)
	./$(TARGET)

# Help target
help:
	@echo "Available targets:"
	@echo "  all        - Build the release binary (default)"
	@echo "  debug      - Build debug binary with symbols"
	@echo "  install    - Install binary to $(BINDIR)"
	@echo "  uninstall  - Remove binary from $(BINDIR)"
	@echo "  clean      - Remove build artifacts"
	@echo "  run        - Build and run the program"
	@echo "  help       - Show this help message"

.PHONY: all debug install uninstall clean run help
