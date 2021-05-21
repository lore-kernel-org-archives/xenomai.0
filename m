Subject: Re: [I-PIPE] ipipe-core-5.4.119-arm-2 released
References: <d33f6074-8e95-d0d9-4153-261121d389cb@bootlin.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f069a3cb-88c6-c269-fdba-2c9029ce5e0c@siemens.com>
Date: Fri, 21 May 2021 11:35:25 +0200
MIME-Version: 1.0
In-Reply-To: <d33f6074-8e95-d0d9-4153-261121d389cb@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, xenomai@xenomai.org

On 21.05.21 11:22, Michael Opdenacker via Xenomai wrote:
> Greetings,
> 
> After downloading this new patch and patching the 5.4.119 kernel sources
> for arm through "./scripts/prepare-kernel.sh", I'm facing kernel
> compiling issues with the "sama5_defconfig" configuration:
> 
>   CC      kernel/xenomai/intr.o
> In file included from include/xenomai/cobalt/kernel/thread.h:26:0,
>                  from include/xenomai/cobalt/kernel/sched.h:24,
>                  from kernel/xenomai/intr.c:24:
> kernel/xenomai/intr.c: In function ‘inc_irqstats’:
> include/xenomai/cobalt/kernel/stat.h:61:49: error: passing argument 1 of ‘atomic_long_xchg’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   __prev = (xnstat_exectime_t *)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
>                                                  ^
> include/xenomai/cobalt/kernel/stat.h:147:2: note: in expansion of macro ‘xnstat_exectime_set_current’
>   xnstat_exectime_set_current(sched, new_account); \
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/xenomai/intr.c:123:2: note: in expansion of macro ‘xnstat_exectime_lazy_switch’
>   xnstat_exectime_lazy_switch(sched, &statp->account, start);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/atomic.h:76:0,
>                  from ./include/asm-generic/bitops/lock.h:5,
>                  from ./arch/arm/include/asm/bitops.h:243,
>                  from ./include/linux/bitops.h:26,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/asm-generic/bug.h:19,
>                  from ./arch/arm/include/asm/bug.h:60,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:12,
>                  from ./include/asm-generic/current.h:5,
>                  from ./arch/arm/include/generated/asm/current.h:1,
>                  from ./include/linux/mutex.h:14,
>                  from kernel/xenomai/intr.c:21:
> ...
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:262: kernel/xenomai/intr.o] Error 1
> make[1]: *** [scripts/Makefile.build:496: kernel/xenomai] Error 2
> make: *** [Makefile:1734: kernel] Error 2
> 
> I'm using the Linaro ARM 2018.05 toolchain (Linaro GCC 7.3-2018.05), but
> I also tried with another toolchain (gcc 10.2), and getting the same issue.
> 
> I don't have any trouble with ipipe-core-4.19.144-arm-10.patch on
> sama5_defconfig.
> 
> Does it ring a bell to anyone?
> 

Yes:

https://source.denx.de/Xenomai/xenomai/-/commit/18ab00b7b0c2c2d0ed1f560cf4fb4161f6e9bde6

What's your Xenomai version? We likely need a 3.1.1 soon...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

