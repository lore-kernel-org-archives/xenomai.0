Date: Fri, 3 Jul 2015 12:51:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150703105149.GZ13256@hermes.click-hack.org>
References: <20150702165642.GS13256@hermes.click-hack.org>
 <5595757A.60301@siemens.com>
 <20150702173508.GU13256@hermes.click-hack.org>
 <20150702175526.GV13256@hermes.click-hack.org>
 <55957B86.7020009@siemens.com>
 <20150702184232.GX13256@hermes.click-hack.org>
 <559587A0.7020005@siemens.com>
 <20150702185525.GY13256@hermes.click-hack.org>
 <559591E5.5060106@siemens.com> <55959E70.1020407@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55959E70.1020407@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Remove
 unused mode parameter from COBALT_SYSCALL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Jul 02, 2015 at 10:26:24PM +0200, Jan Kiszka wrote:
> Just FYI - still requires testing and more review - find a first
> generator version below.
> 
> Jan
> 
> 
> cobalt/posix/syscall: Generate cobalt_syscalls and cobalt_sysmodes
> 
> ---
>  .../arch/x86/include/asm/xenomai/syscall32.h       |  12 +-
>  kernel/cobalt/posix/Makefile                       |  12 ++
>  kernel/cobalt/posix/gen-syscall-entries.sh         |  24 +++
>  kernel/cobalt/posix/syscall.c                      | 208 ++-------------------
>  scripts/prepare-kernel.sh                          |   4 +-
>  5 files changed, 57 insertions(+), 203 deletions(-)
>  create mode 100755 kernel/cobalt/posix/gen-syscall-entries.sh
> 
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
> index 8bd40d4..58b7336 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
> @@ -45,14 +45,14 @@
>  #define __syshand32x__(__name)	((cobalt_syshand)(cobalt32x_ ## __name))
>  
>  #define __COBALT_CALL32x_INITHAND(__handler)	\
> -  , [__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __handler
> +	[__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
>  
>  #define __COBALT_CALL32x_INITMODE(__mode)	\
> -  , [__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __mode
> +	[__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
>  
>  /* x32 default entry (no thunk) */
>  #define __COBALT_CALL32x_ENTRY(__name, __handler)		\
> -	, [sc_cobalt_ ## __name + __COBALT_X32_BASE] = __handler
> +	[sc_cobalt_ ## __name + __COBALT_X32_BASE] = __handler,
>  
>  /* x32 thunk installation */
>  #define __COBALT_CALL32x_pure_THUNK(__name)	\
> @@ -113,14 +113,14 @@
>  #define __syshand32emu__(__name)	((cobalt_syshand)(cobalt32emu_ ## __name))
>  
>  #define __COBALT_CALL32emu_INITHAND(__handler)	\
> -  , [__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __handler
> +	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
>  
>  #define __COBALT_CALL32emu_INITMODE(__mode)	\
> -  , [__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __mode
> +	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
>  
>  /* ia32 default entry (no thunk) */
>  #define __COBALT_CALL32emu_ENTRY(__name, __handler)		\
> -	, [sc_cobalt_ ## __name + __COBALT_IA32_BASE] = __handler
> +	[sc_cobalt_ ## __name + __COBALT_IA32_BASE] = __handler,
>  
>  /* ia32 thunk installation */
>  #define __COBALT_CALL32emu_THUNK(__name)	\

Whether this is needed is debatable. From my point of view, it is
not needed. But in any case, this has nothing to do with what this
patch does.


> diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
> index 3049be4..2da764a 100644
> --- a/kernel/cobalt/posix/Makefile
> +++ b/kernel/cobalt/posix/Makefile
> @@ -22,4 +22,16 @@ xenomai-y :=		\
>  	timer.o		\
>  	timerfd.o
>  
> +syscall_entries := $(srctree)/$(src)/gen-syscall-entries.sh
> +
> +quiet_cmd_syscall_entries = GEN     $@
> +      cmd_syscall_entries = $(CONFIG_SHELL) '$(syscall_entries)' $^ > $@
> +
> +$(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c)
> +	$(call if_changed,syscall_entries)
> +
> +target += syscall_entries.h
> +
> +$(obj)/syscall.o: $(obj)/syscall_entries.h
> +
>  xenomai-$(CONFIG_XENO_ARCH_SYS3264) += compat.o syscall32.o
> diff --git a/kernel/cobalt/posix/gen-syscall-entries.sh b/kernel/cobalt/posix/gen-syscall-entries.sh
> new file mode 100755
> index 0000000..36b1e69
> --- /dev/null
> +++ b/kernel/cobalt/posix/gen-syscall-entries.sh
> @@ -0,0 +1,24 @@
> +#! /bin/sh
> +
> +set -e
> +
> +shift
> +
> +echo "#ifdef COBALT_LIST_CALL_ENTRIES"
> +awk '
> +match($0, /COBALT_SYSCALL\([^,]*, [^,]*/)  {
> +	str=substr($0, RSTART + 15, RLENGTH - 15)
> +	match(str, /[^,]*/)
> +	print "__COBALT_CALL_ENTRY(" substr(str, RSTART, RLENGTH) ")"
> +}
> +' $*
> +echo "#endif"
> +
> +echo "#ifdef COBALT_LIST_MODES"
> +awk '
> +match($0, /COBALT_SYSCALL\([^,]*, [^,]*/)  {
> +	str=substr($0, RSTART + 15, RLENGTH - 15)
> +	print "__COBALT_MODE(" str ")"
> +}
> +' $*
> +echo "#endif"

This is particularly inelegant:
- you do not need awk to do that, sed is sufficient
- with using awk, you can generate the two files in one pass, and
remove the #ifdefs trick;
- I think the awk script should at least generate an error in case
of parser error

I will submit an awk script which does that.


> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
> index 36cfc3b..abe9fea 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -548,222 +548,40 @@ static int cobalt_ni(void)
>  #define __COBALT_NI	__syshand__(ni)
>  
>  #define __COBALT_CALL_NI				\
> -	[0 ... __NR_COBALT_SYSCALLS-1] = __COBALT_NI	\
> +	[0 ... __NR_COBALT_SYSCALLS-1] = __COBALT_NI,	\
>  	__COBALT_CALL32_INITHAND(__COBALT_NI)
>  
>  #define __COBALT_CALL_NFLAGS				\
> -	[0 ... __NR_COBALT_SYSCALLS-1] = 0		\
> +	[0 ... __NR_COBALT_SYSCALLS-1] = 0,		\
>  	__COBALT_CALL32_INITMODE(0)
>  
>  #define __COBALT_CALL_ENTRY(__name)				\
> -	[sc_cobalt_ ## __name] = __syshand__(__name)		\
> +	[sc_cobalt_ ## __name] = __syshand__(__name),		\
>  	__COBALT_CALL32_ENTRY(__name, __syshand__(__name))
>  
>  #define __COBALT_MODE(__name, __mode)	\
> -	[sc_cobalt_ ## __name] = __xn_exec_##__mode
> +	[sc_cobalt_ ## __name] = __xn_exec_##__mode,

Again, unrelated changes.

-- 
					    Gilles.
https://click-hack.org

