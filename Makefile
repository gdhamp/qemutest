TARGET_EXEC ?= hello

BUILD_DIR ?= ./build
SRC_DIRS ?= ./src

SRCS := $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c -or -name *.s)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CFLAGS := -static
CPPFLAGS ?= $(INC_FLAGS) -I./CMSIS/Core/Include -I ./CMSIS/DSP/Include -MMD -MP


ARCH        := M0l
LIBDIR		:= CMSIS/DSP/Lib
LIB         := arm_cortex$(ARCH)_math
TOOLS_PATH = /usr/bin

CC          := $(TOOLS_PATH)/arm-linux-gnueabi-gcc
CXX         := $(TOOLS_PATH)/arm-linux-gnueabi-g++
LD          := $(TOOLS_PATH)/arm-linux-gnueabi-ld
AR          := $(TOOLS_PATH)/arm-linux-gnueabi-ar
AS          := $(TOOLS_PATH)/arm-linux-gnueabi-gcc
CP          := $(TOOLS_PATH)/arm-linux-gnueabi-objcopy
OD          := $(TOOLS_PATH)/arm-linux-gnueabi-objdump
SIZE        := $(TOOLS_PATH)/arm-linux-gnueabi-size

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -L $(LIBDIR) -l$(LIB) -o $@ $(LDFLAGS) 

qemu: $(BUILD_DIR)/$(TARGET_EXEC)
	qemu-arm -singlestep -g 1234 -L /usr/arm-linux-gnueabi/ $<


# assembly
$(BUILD_DIR)/%.s.o: %.s
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp
	$(MKDIR_P) $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

print-%  : ; @echo $* = $($*)

.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p
