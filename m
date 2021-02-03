Subject: Re: [PATCH 04/13] cobalt/arch: pipeline: move architecture code to
 pipeline-specific section
References: <20210131144540.243363-1-rpm@xenomai.org>
 <20210131144540.243363-4-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f7e73e28-273c-0fbb-afc1-883b04d81086@siemens.com>
Date: Wed, 3 Feb 2021 11:18:13 +0100
MIME-Version: 1.0
In-Reply-To: <20210131144540.243363-4-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 31.01.21 15:45, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> The Cobalt architecture code is overwhelmingly specific to a pipeline
> flavour, most of it for interfacing with the I-pipe. We may still need
> very little arch-specific code in the Dovetail set up though,
> specifically for implementing Cobalt's built-in FPU tests.
> 
> Let's move the existing architecture code under the ipipe/ hierarchy,
> fixing up the kernel prep script accordingly.
> 
> No functional change is introduced.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  kernel/cobalt/arch/arm/{ => ipipe}/Makefile   |  2 +-
>  kernel/cobalt/arch/arm/{ => ipipe}/README     |  0
>  .../include/asm/xenomai/calibration.h         |  0
>  .../include/asm/xenomai/features.h            |  0
>  .../{ => ipipe}/include/asm/xenomai/fptest.h  |  0
>  .../{ => ipipe}/include/asm/xenomai/machine.h |  0
>  .../{ => ipipe}/include/asm/xenomai/syscall.h |  0
>  .../include/asm/xenomai/syscall32.h           |  0
>  .../{ => ipipe}/include/asm/xenomai/thread.h  |  0
>  .../include/asm/xenomai/wrappers.h            |  0
>  kernel/cobalt/arch/arm/{ => ipipe}/machine.c  |  0
>  kernel/cobalt/arch/arm/{ => ipipe}/switch.S   |  0
>  kernel/cobalt/arch/arm/{ => ipipe}/syscall.c  |  0
>  kernel/cobalt/arch/arm/{ => ipipe}/thread.c   |  0
>  kernel/cobalt/arch/arm64/{ => ipipe}/Makefile |  0
>  kernel/cobalt/arch/arm64/{ => ipipe}/README   |  0
>  .../include/asm/xenomai/calibration.h         |  0
>  .../include/asm/xenomai/features.h            |  0
>  .../{ => ipipe}/include/asm/xenomai/fptest.h  |  0
>  .../{ => ipipe}/include/asm/xenomai/machine.h |  0
>  .../{ => ipipe}/include/asm/xenomai/syscall.h |  0
>  .../include/asm/xenomai/syscall32.h           |  0
>  .../{ => ipipe}/include/asm/xenomai/thread.h  |  0
>  .../include/asm/xenomai/wrappers.h            |  0
>  .../cobalt/arch/arm64/{ => ipipe}/machine.c   |  0
>  .../cobalt/arch/arm64/{ => ipipe}/syscall.c   |  0
>  kernel/cobalt/arch/arm64/{ => ipipe}/thread.c |  0
>  .../cobalt/arch/powerpc/{ => ipipe}/Makefile  |  0
>  kernel/cobalt/arch/powerpc/{ => ipipe}/README |  0
>  kernel/cobalt/arch/powerpc/{ => ipipe}/fpu.S  |  0
>  .../include/asm/xenomai/calibration.h         |  0
>  .../include/asm/xenomai/features.h            |  0
>  .../{ => ipipe}/include/asm/xenomai/fptest.h  |  0
>  .../{ => ipipe}/include/asm/xenomai/machine.h |  0
>  .../{ => ipipe}/include/asm/xenomai/syscall.h |  0
>  .../include/asm/xenomai/syscall32.h           |  0
>  .../{ => ipipe}/include/asm/xenomai/thread.h  |  0
>  .../include/asm/xenomai/wrappers.h            |  0
>  .../cobalt/arch/powerpc/{ => ipipe}/machine.c |  0
>  .../cobalt/arch/powerpc/{ => ipipe}/thread.c  |  0
>  kernel/cobalt/arch/x86/{ => ipipe}/Makefile   |  0
>  kernel/cobalt/arch/x86/{ => ipipe}/README     |  0
>  kernel/cobalt/arch/x86/{ => ipipe}/c1e.c      |  0
>  .../x86/{ => ipipe}/include/asm/xenomai/c1e.h |  0
>  .../include/asm/xenomai/calibration.h         |  0
>  .../include/asm/xenomai/features.h            |  0
>  .../{ => ipipe}/include/asm/xenomai/fptest.h  |  0
>  .../{ => ipipe}/include/asm/xenomai/machine.h |  0
>  .../x86/{ => ipipe}/include/asm/xenomai/smi.h |  0
>  .../{ => ipipe}/include/asm/xenomai/syscall.h |  0
>  .../include/asm/xenomai/syscall32-table.h     |  0
>  .../include/asm/xenomai/syscall32.h           |  0
>  .../{ => ipipe}/include/asm/xenomai/thread.h  |  0
>  .../include/asm/xenomai/wrappers.h            |  0
>  kernel/cobalt/arch/x86/{ => ipipe}/machine.c  |  0
>  kernel/cobalt/arch/x86/{ => ipipe}/smi.c      |  0
>  kernel/cobalt/arch/x86/{ => ipipe}/thread.c   |  0
>  scripts/prepare-kernel.sh                     | 84 ++++++++++++-------
>  58 files changed, 53 insertions(+), 33 deletions(-)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/Makefile (64%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/README (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/include/asm/xenomai/calibration.h (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/include/asm/xenomai/features.h (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/include/asm/xenomai/fptest.h (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/include/asm/xenomai/machine.h (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/include/asm/xenomai/syscall.h (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/include/asm/xenomai/syscall32.h (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/include/asm/xenomai/thread.h (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/include/asm/xenomai/wrappers.h (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/machine.c (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/switch.S (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/syscall.c (100%)
>  rename kernel/cobalt/arch/arm/{ => ipipe}/thread.c (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/Makefile (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/README (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/include/asm/xenomai/calibration.h (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/include/asm/xenomai/features.h (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/include/asm/xenomai/fptest.h (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/include/asm/xenomai/machine.h (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/include/asm/xenomai/syscall.h (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/include/asm/xenomai/syscall32.h (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/include/asm/xenomai/thread.h (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/include/asm/xenomai/wrappers.h (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/machine.c (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/syscall.c (100%)
>  rename kernel/cobalt/arch/arm64/{ => ipipe}/thread.c (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/Makefile (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/README (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/fpu.S (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/include/asm/xenomai/calibration.h (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/include/asm/xenomai/features.h (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/include/asm/xenomai/fptest.h (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/include/asm/xenomai/machine.h (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/include/asm/xenomai/syscall.h (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/include/asm/xenomai/syscall32.h (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/include/asm/xenomai/thread.h (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/include/asm/xenomai/wrappers.h (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/machine.c (100%)
>  rename kernel/cobalt/arch/powerpc/{ => ipipe}/thread.c (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/Makefile (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/README (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/c1e.c (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/c1e.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/calibration.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/features.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/fptest.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/machine.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/smi.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/syscall.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/syscall32-table.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/syscall32.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/thread.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/include/asm/xenomai/wrappers.h (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/machine.c (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/smi.c (100%)
>  rename kernel/cobalt/arch/x86/{ => ipipe}/thread.c (100%)
> 
> diff --git a/kernel/cobalt/arch/arm/Makefile b/kernel/cobalt/arch/arm/ipipe/Makefile
> similarity index 64%
> rename from kernel/cobalt/arch/arm/Makefile
> rename to kernel/cobalt/arch/arm/ipipe/Makefile
> index 295ba614b..c482fb337 100644
> --- a/kernel/cobalt/arch/arm/Makefile
> +++ b/kernel/cobalt/arch/arm/ipipe/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_XENOMAI) += xenomai.o
>  
> -xenomai-y := machine.o thread.o switch.o syscall.o
> +xenomai-$(CONFIG_IPIPE) := machine.o thread.o switch.o syscall.o
>  
>  ccflags-y := -I$(srctree)/arch/arm/xenomai/include -I$(srctree)/include/xenomai
> diff --git a/kernel/cobalt/arch/arm/README b/kernel/cobalt/arch/arm/ipipe/README
> similarity index 100%
> rename from kernel/cobalt/arch/arm/README
> rename to kernel/cobalt/arch/arm/ipipe/README
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/calibration.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm/include/asm/xenomai/calibration.h
> rename to kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/calibration.h
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/features.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/features.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm/include/asm/xenomai/features.h
> rename to kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/features.h
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
> rename to kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/machine.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm/include/asm/xenomai/machine.h
> rename to kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/machine.h
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
> rename to kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall.h
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall32.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm/include/asm/xenomai/syscall32.h
> rename to kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall32.h
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
> rename to kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/wrappers.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm/include/asm/xenomai/wrappers.h
> rename to kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/wrappers.h
> diff --git a/kernel/cobalt/arch/arm/machine.c b/kernel/cobalt/arch/arm/ipipe/machine.c
> similarity index 100%
> rename from kernel/cobalt/arch/arm/machine.c
> rename to kernel/cobalt/arch/arm/ipipe/machine.c
> diff --git a/kernel/cobalt/arch/arm/switch.S b/kernel/cobalt/arch/arm/ipipe/switch.S
> similarity index 100%
> rename from kernel/cobalt/arch/arm/switch.S
> rename to kernel/cobalt/arch/arm/ipipe/switch.S
> diff --git a/kernel/cobalt/arch/arm/syscall.c b/kernel/cobalt/arch/arm/ipipe/syscall.c
> similarity index 100%
> rename from kernel/cobalt/arch/arm/syscall.c
> rename to kernel/cobalt/arch/arm/ipipe/syscall.c
> diff --git a/kernel/cobalt/arch/arm/thread.c b/kernel/cobalt/arch/arm/ipipe/thread.c
> similarity index 100%
> rename from kernel/cobalt/arch/arm/thread.c
> rename to kernel/cobalt/arch/arm/ipipe/thread.c
> diff --git a/kernel/cobalt/arch/arm64/Makefile b/kernel/cobalt/arch/arm64/ipipe/Makefile
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/Makefile
> rename to kernel/cobalt/arch/arm64/ipipe/Makefile
> diff --git a/kernel/cobalt/arch/arm64/README b/kernel/cobalt/arch/arm64/ipipe/README
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/README
> rename to kernel/cobalt/arch/arm64/ipipe/README
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/calibration.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/include/asm/xenomai/calibration.h
> rename to kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/calibration.h
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/features.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/features.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/include/asm/xenomai/features.h
> rename to kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/features.h
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> rename to kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
> rename to kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
> rename to kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall.h
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall32.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
> rename to kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall32.h
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h
> rename to kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/wrappers.h
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/include/asm/xenomai/wrappers.h
> rename to kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/wrappers.h
> diff --git a/kernel/cobalt/arch/arm64/machine.c b/kernel/cobalt/arch/arm64/ipipe/machine.c
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/machine.c
> rename to kernel/cobalt/arch/arm64/ipipe/machine.c
> diff --git a/kernel/cobalt/arch/arm64/syscall.c b/kernel/cobalt/arch/arm64/ipipe/syscall.c
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/syscall.c
> rename to kernel/cobalt/arch/arm64/ipipe/syscall.c
> diff --git a/kernel/cobalt/arch/arm64/thread.c b/kernel/cobalt/arch/arm64/ipipe/thread.c
> similarity index 100%
> rename from kernel/cobalt/arch/arm64/thread.c
> rename to kernel/cobalt/arch/arm64/ipipe/thread.c
> diff --git a/kernel/cobalt/arch/powerpc/Makefile b/kernel/cobalt/arch/powerpc/ipipe/Makefile
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/Makefile
> rename to kernel/cobalt/arch/powerpc/ipipe/Makefile
> diff --git a/kernel/cobalt/arch/powerpc/README b/kernel/cobalt/arch/powerpc/ipipe/README
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/README
> rename to kernel/cobalt/arch/powerpc/ipipe/README
> diff --git a/kernel/cobalt/arch/powerpc/fpu.S b/kernel/cobalt/arch/powerpc/ipipe/fpu.S
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/fpu.S
> rename to kernel/cobalt/arch/powerpc/ipipe/fpu.S
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/calibration.h
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/include/asm/xenomai/calibration.h
> rename to kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/calibration.h
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/features.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/features.h
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/include/asm/xenomai/features.h
> rename to kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/features.h
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h
> rename to kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/machine.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/machine.h
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/include/asm/xenomai/machine.h
> rename to kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/machine.h
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall.h
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/include/asm/xenomai/syscall.h
> rename to kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall.h
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall32.h
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/include/asm/xenomai/syscall32.h
> rename to kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall32.h
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
> rename to kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/wrappers.h
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/include/asm/xenomai/wrappers.h
> rename to kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/wrappers.h
> diff --git a/kernel/cobalt/arch/powerpc/machine.c b/kernel/cobalt/arch/powerpc/ipipe/machine.c
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/machine.c
> rename to kernel/cobalt/arch/powerpc/ipipe/machine.c
> diff --git a/kernel/cobalt/arch/powerpc/thread.c b/kernel/cobalt/arch/powerpc/ipipe/thread.c
> similarity index 100%
> rename from kernel/cobalt/arch/powerpc/thread.c
> rename to kernel/cobalt/arch/powerpc/ipipe/thread.c
> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/ipipe/Makefile
> similarity index 100%
> rename from kernel/cobalt/arch/x86/Makefile
> rename to kernel/cobalt/arch/x86/ipipe/Makefile
> diff --git a/kernel/cobalt/arch/x86/README b/kernel/cobalt/arch/x86/ipipe/README
> similarity index 100%
> rename from kernel/cobalt/arch/x86/README
> rename to kernel/cobalt/arch/x86/ipipe/README
> diff --git a/kernel/cobalt/arch/x86/c1e.c b/kernel/cobalt/arch/x86/ipipe/c1e.c
> similarity index 100%
> rename from kernel/cobalt/arch/x86/c1e.c
> rename to kernel/cobalt/arch/x86/ipipe/c1e.c
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/c1e.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/c1e.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/c1e.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/c1e.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/calibration.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/features.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/features.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/features.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/features.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/machine.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/machine.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/smi.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/smi.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/smi.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/smi.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32-table.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32-table.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/wrappers.h
> similarity index 100%
> rename from kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> rename to kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/wrappers.h
> diff --git a/kernel/cobalt/arch/x86/machine.c b/kernel/cobalt/arch/x86/ipipe/machine.c
> similarity index 100%
> rename from kernel/cobalt/arch/x86/machine.c
> rename to kernel/cobalt/arch/x86/ipipe/machine.c
> diff --git a/kernel/cobalt/arch/x86/smi.c b/kernel/cobalt/arch/x86/ipipe/smi.c
> similarity index 100%
> rename from kernel/cobalt/arch/x86/smi.c
> rename to kernel/cobalt/arch/x86/ipipe/smi.c
> diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
> similarity index 100%
> rename from kernel/cobalt/arch/x86/thread.c
> rename to kernel/cobalt/arch/x86/ipipe/thread.c
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 1b5fb427d..7dba3d5a5 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -147,7 +147,7 @@ generate_patch() {
>  }
>  
>  
> -usage='usage: prepare-kernel --linux=<linux-tree> --ipipe=<ipipe-patch> [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
> +usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>]|[--ipipe=<ipipe-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
>  me=`basename $0`
>  
>  while test $# -gt 0; do
> @@ -157,12 +157,25 @@ while test $# -gt 0; do
>  	linux_tree=`eval "echo $linux_tree"`
>  	;;
>      --adeos=*)
> -	ipipe_patch=`echo $1|sed -e 's,^--adeos=\\(.*\\)$,\\1,g'`
> -	ipipe_patch=`eval "echo $ipipe_patch"`
> +	pipeline_patch=`echo $1|sed -e 's,^--adeos=\\(.*\\)$,\\1,g'`
> +	pipeline_patch=`eval "echo $pipeline_patch"`
> +	probe_header=include/linux/ipipe.h
> +	arch_probe_header=include/asm/ipipe.h
> +	pipeline_type=ipipe
>  	;;
>      --ipipe=*)
> -	ipipe_patch=`echo $1|sed -e 's,^--ipipe=\\(.*\\)$,\\1,g'`
> -	ipipe_patch=`eval "echo $ipipe_patch"`
> +	pipeline_patch=`echo $1|sed -e 's,^--ipipe=\\(.*\\)$,\\1,g'`
> +	pipeline_patch=`eval "echo $pipeline_patch"`
> +	probe_header=include/linux/ipipe.h
> +	arch_probe_header=include/asm/ipipe.h
> +	pipeline_type=ipipe
> +	;;
> +    --dovetail=*)
> +	pipeline_patch=`echo $1|sed -e 's,^--dovetail=\\(.*\\)$,\\1,g'`
> +	pipeline_patch=`eval "echo $pipeline_patch"`
> +	probe_header=include/linux/dovetail.h
> +	arch_probe_header=include/asm/dovetail.h
> +	pipeline_type=dovetail
>  	;;
>      --arch=*)
>  	linux_arch=`echo $1|sed -e 's,^--arch=\\(.*\\)$,\\1,g'`
> @@ -305,51 +318,58 @@ eval linux_`grep '^VERSION =' $linux_tree/Makefile | sed -e 's, ,,g'`
>  
>  linux_version="$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
>  
> +if test x$pipeline_type = x; then
> +    if test -r include/linux/ipipe.h; then

Missing $linux_tree/, here an below. Fixed up in next.

Jan

> +	probe_header=include/linux/ipipe.h
> +	arch_probe_header=include/asm/ipipe.h
> +	pipeline_type=ipipe
> +    elif test -r include/linux/dovetail.h; then
> +	probe_header=include/linux/dovetail.h
> +	arch_probe_header=include/asm/dovetail.h
> +	pipeline_type=dovetail
> +    fi
> +fi
> +
>  if test x$verbose = x1; then
>  echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree..."
>  fi
>  
> -if test -r $linux_tree/include/linux/ipipe.h; then
> +if test -r $linux_tree/$probe_header; then
>      if test x$verbose = x1; then
> -       echo "I-pipe found - bypassing patch."
> +       echo "IRQ pipeline found - bypassing patch."
>      fi
>  else
>     if test x$verbose = x1; then
> -      echo "$me: no I-pipe support found." >&2
> +      echo "$me: no IRQ pipeline support found." >&2
>     fi
> -   while test x$ipipe_patch = x; do
> -      echo -n "I-pipe patch: "
> -      read ipipe_patch
> -      if test \! -r "$ipipe_patch" -o x$ipipe_patch = x; then
> -         echo "$me: cannot read I-pipe patch from $ipipe_patch" >&2
> -         ipipe_patch=
> +   while test x$pipeline_patch = x; do
> +      echo -n "IRQ pipeline patch: "
> +      read pipeline_patch
> +      if test \! -r "$pipeline_patch" -o x$pipeline_patch = x; then
> +         echo "$me: cannot read IRQ pipeline support from $pipeline_patch" >&2
> +         pipeline_patch=
>        fi
>     done
> -   patchdir=`dirname $ipipe_patch`; 
> +   patchdir=`dirname $pipeline_patch`; 
>     patchdir=`cd $patchdir && pwd`
> -   ipipe_patch=$patchdir/`basename $ipipe_patch`
> +   pipeline_patch=$patchdir/`basename $pipeline_patch`
>     curdir=$PWD
> -   cd $linux_tree && patch --dry-run -p1 -f < $ipipe_patch || { 
> +   cd $linux_tree && patch --dry-run -p1 -f < $pipeline_patch || { 
>          cd $curdir;
> -        echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERSION with `basename $ipipe_patch`." >&2
> +        echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERSION with `basename $pipeline_patch`." >&2
>          exit 2;
>     }
> -   patch -p1 -f -s < $ipipe_patch
> +   patch -p1 -f -s < $pipeline_patch
>     cd $curdir
>  fi
>  
> -if test \! -r $linux_tree/arch/$linux_arch/include/asm/ipipe.h; then
> -   echo "$me: $linux_tree has no I-pipe support for $linux_arch" >&2
> +if test \! -r $linux_tree/arch/$linux_arch/$arch_probe_header; then
> +   echo "$me: $linux_tree has no IRQ pipeline support for $linux_arch" >&2
>     exit 2
>  fi
>  
> -ipipe_core=`grep '^#define.*IPIPE_CORE_RELEASE.*' $linux_tree/arch/$linux_arch/include/asm/ipipe.h 2>/dev/null|head -n1|sed -e 's,[^0-9]*\([0-9]*\)$,\1,'`
> -if test "x$ipipe_core" = x; then
> -    echo "$me: $linux_tree has no I-pipe support for $linux_arch" >&2
> -    exit 2
> -fi
>  if test x$verbose = x1; then
> -   echo "I-pipe core/$linux_arch #$ipipe_core installed."
> +   echo "IRQ pipeline installed."
>  fi
>  
>  patch_kernelversion_specific="y"
> @@ -387,9 +407,9 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>  test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>  
>      if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> -	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> +	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/arch/\$(SRCARCH)/xenomai/$pipeline_type/include -I\$(srctree)/include/xenomai"
>  	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
> -	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> +	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/$pipeline_type/"
>  	echo $p | patch_append arch/$linux_arch/Makefile
>      fi
>  
> @@ -415,7 +435,7 @@ esac
>  patch_kernelversion_specific="n"
>  patch_architecture_specific="y"
>  patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
> -patch_link n n kernel/cobalt/include/ipipe arch/$linux_arch/include/ipipe
> +patch_link n n kernel/cobalt/include/$pipeline_type arch/$linux_arch/include/$pipeline_type
>  patch_architecture_specific="n"
>  patch_link n m kernel/cobalt kernel/xenomai
>  patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
> @@ -425,11 +445,11 @@ patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xen
>  patch_link r n kernel/cobalt/include/linux/xenomai include/linux/xenomai
>  patch_link n m kernel/cobalt/posix kernel/xenomai/posix
>  patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
> -patch_link n m kernel/cobalt/ipipe kernel/xenomai/pipeline
> +patch_link n m kernel/cobalt/$pipeline_type kernel/xenomai/pipeline
>  patch_link r m kernel/drivers drivers/xenomai
>  patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
>  patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
> -patch_link r n include/cobalt/kernel/ipipe/pipeline include/xenomai/pipeline
> +patch_link r n include/cobalt/kernel/$pipeline_type/pipeline include/xenomai/pipeline
>  patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
>  patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
>  patch_link n version.h include/xenomai include/xenomai
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

