##
# Makefile to build DSP_Lib into libraries
# Taken from: https://github.com/mikeferguson/stm32/blob/9e27786de4e6df74dc735f3c5667fbe4874e59c5/libraries/CMSIS/Makefile
##
ARCH        := M0l
LIB         := Lib/libarm_cortex$(ARCH)_math.a

# Architectures to build for
ARCHS       := M0b
M0l_FLAGS   := -mthumb -mcpu=cortex-m0 -DARM_MATH_CM0
# M3l_FLAGS   := -mthumb -mcpu=cortex-m3 -DARM_MATH_CM3
# M4l_FLAGS   := -mthumb -mcpu=cortex-m4 -DARM_MATH_CM4
# M4lf_FLAGS  := -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -DARM_MATH_CM4 -D__FPU_PRESENT

# Directories
DSPLIB      := Source
DSPDIRS     := BasicMathFunctions          \
               CommonTables                \
               ComplexMathFunctions        \
               ControllerFunctions         \
               FastMathFunctions           \
               FilteringFunctions          \
               MatrixFunctions             \
               StatisticsFunctions         \
               SupportFunctions            \
               TransformFunctions

# Build Paths
BUILD_PATH  := Lib/build
BUILDDIRS   := $(BUILD_PATH)
BUILDDIRS   += $(foreach dir,$(DSPDIRS),$(BUILD_PATH)/$(DSPLIB)/$(dir))

# Targets to build
LIBS        := $(foreach tgt,$(ARCHS),Lib/libarm_cortex$(tgt)_math.a)
SRCS        := $(wildcard $(DSPLIB)/*/*.c)
ASRCS        += $(wildcard $(DSPLIB)/*/*.S)
OBJS        := $(patsubst %.c, %.o, $(SRCS))
OBJS        += $(patsubst %.S, %.o, $(ASRCS))
OBJS        := $(foreach obj,$(OBJS),$(BUILD_PATH)/$(obj))

# Tools
#TOOLS_PATH = /opt/gcc-arm-none-eabi/bin
TOOLS_PATH = /usr/bin

CC          := $(TOOLS_PATH)/arm-linux-gnueabi-gcc
CXX         := $(TOOLS_PATH)/arm-linux-gnueabi-g++
LD          := $(TOOLS_PATH)/arm-linux-gnueabi-ld
AR          := $(TOOLS_PATH)/arm-linux-gnueabi-ar
AS          := $(TOOLS_PATH)/arm-linux-gnueabi-gcc
CP          := $(TOOLS_PATH)/arm-linux-gnueabi-objcopy
OD          := $(TOOLS_PATH)/arm-linux-gnueabi-objdump
SIZE        := $(TOOLS_PATH)/arm-linux-gnueabi-size

# Flags
INCLUDES    := -I./Include -I../Core/Include
CFLAGS      := -c -fno-common -g3 -Os -ffunction-sections
CXXFLAGS    := $(CFLAGS) -fno-exceptions
CPFLAGS     := -Obinary -v
ODFLAGS     := -S -t
ARFLAGS     := 



all: $(BUILDDIRS) $(OBJS) $(LIB)

print-%  : ; @echo $* = $($*)

clean:
	rm -rf $(BUILD_PATH)

$(BUILD_PATH)/%.o: %.c 
	$(CC) $(CFLAGS) $(INCLUDES) $($(ARCH)_FLAGS) -o $@ $<

$(BUILD_PATH)/%.o: %.S 
	$(CC) $(CFLAGS) $(INCLUDES) $($(ARCH)_FLAGS) -o $@ $<

$(LIB): $(OBJS)
	$(AR) rcs $@ $?

$(BUILDDIRS):
	@mkdir -p $@



#print-%  : ; @echo $* = $($*)
