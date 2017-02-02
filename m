Date: Thu, 2 Feb 2017 10:09:45 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170202100945.769865d9@md1em3qc>
In-Reply-To: <27e6bbb0-cf0c-7a7f-b62c-9ffd7debf400@matrixresearch.com>
References: <27e6bbb0-cf0c-7a7f-b62c-9ffd7debf400@matrixresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomomai-3 kernel freeze on RPI2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Gwynne <john.gwynne@matrixresearch.com>
Cc: xenomai@xenomai.org

Am Wed, 1 Feb 2017 13:42:07 -0500
schrieb John Gwynne <john.gwynne@matrixresearch.com>:

> I've been watching for a while for a solution, or even conformation,
> of a potential kernel freeze problem on the Raspberry PI 2/3 platform
> with the Xenomai patches.  Having not seen anything that appears
> related, I'm posting this description of what I've experienced.
> 
> I'm interesting in advice on how to solve this problem as well as how
> to best debug the issue.  I've enabled 'Detect Hard and Soft Lockups'
> and 'Panic on Soft Lockups', but have not been successful in
> recovering from the hung state (other than by a power cycle) nor
> retrieving information related to the cause.

Did you capture the console output via serial? That might give a clue
especially with increased loglevels and maybe additional printks on the
"new" or "suspicous" paths.

Your tests look like they put stress on the SD-card and CPU. Maybe try
stressing just the SD-card interrupt-path. (i.e. multiple dd
to /dev/null) Or just the CPU, or another interrupt.

Further debugging techniques would be JTAG and tracing to nvram. They
depend on your hardware and i am not sure they can be used on the
Raspberry Pi.

regards,
Henning

> The details are below.
> 
> Thanks,
> john
> 
> ()  Problem:
> Under heavy load, a kernel compiled with the Xenomai patches 
> ('CONFIG_XENOMAI=y' in .config) will freeze without warnings or error 
> messages.  The same kernel version compiled with xenomai patches off
> ('# CONFIG_XENOMAI is not set' in .config) does not experience such
> problems.
> 
> () Hardware:
> Tested on several Raspberry 2 and 3 boards with various sdcards and 
> power supplies.  Using the default system boot configuration and
> system clock (i.e. not overclocked).
> 
> () Software:
> kernel 4.1.21 from https://github.com/raspberrypi/linux/tree/rpi-4.1.y
> Mathieu Rondonneau RPI2 patch from this list, Apr 16 2016
> ipipe-core-4.1.18-arm-8.patch
> xenomai-3-3.0.3
> note: I have tested, with similar results, many other kernels and as
> far back as kernel 3.18 & xenomai-3-3.0.1
> 
> () Conditions to reproduce kernel freeze:
> Boot xenomai patched kernel
> Launch a kernel build process and unzip process.  I commonly do this 
> through 'screen' as follows:
> (I'm leaving out obvious setup steps such as 'mkdir <foobar>', 'make 
> defconfig', etc)
> []# screen
> []# cd linux-rpi-3.18.y/
> []# for i in `seq 1 5`; do make -j4 bzImage; make clean; done
> []# <ctl-a> c  (new screen & shell)
> []# cd tmp
> []# for i in `seq 1 30`; do unzip ../linux-rpi-3.18.y.zip; rm -rf 
> linux-rpi-3.18.y; done
> []# <ctl-a> c  (new screen & shell)
> []# top
> 
> With the 'CONFIG_XENOMAI=y' kernel, this will typically create a
> kernel freeze in 3 to 20 minutes.
> 
> Note that this load does not seem to be enough to use swap space and
> I have not launched any Xemonai threads.
> 
> () Comments
> I have tested this level of load for 18+ hours using the same kernel 
> compiled with  '# CONFIG_XENOMAI is not set' in the configuration
> file. There is no failure in this case.
> 
> The basic .config file differences are shown below. I can make
> available the actual configuration files if needed.
> 
> < '# CONFIG_XENOMAI is not set' .config file
>  > '# CONFIG_XENOMAI=y' .config file  
> 
> < CONFIG_PREEMPT_RCU=y
>  > CONFIG_TREE_RCU=y
>  > CONFIG_OPTPROBES=y  
> < CONFIG_HAVE_CONTEXT_TRACKING=y
> < CONFIG_UNINLINE_SPIN_UNLOCK=y
>  > CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
>  > CONFIG_INLINE_READ_UNLOCK=y
>  > CONFIG_INLINE_READ_UNLOCK_IRQ=y
>  > CONFIG_INLINE_WRITE_UNLOCK=y
>  > CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
>  > CONFIG_XENOMAI=y
>  > CONFIG_XENO_OPT_STATS=y
>  > CONFIG_XENO_OPT_RR_QUANTUM=1000
>  > CONFIG_XENO_OPT_AUTOTUNE=y
>  > CONFIG_XENO_OPT_TIMER_LIST=y
>  > CONFIG_XENO_OPT_HOSTRT=y
>  > CONFIG_XENO_OPT_VFILE=y
>  > CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
>  > CONFIG_XENO_OPT_SYS_HEAPSZ=1024
>  > CONFIG_XENO_OPT_PRIVATE_HEAPSZ=128
>  > CONFIG_XENO_OPT_SHARED_HEAPSZ=128
>  > CONFIG_XENO_OPT_NRTIMERS=128
>  > CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
>  > CONFIG_XENO_OPT_TIMING_KSCHEDLAT=0
>  > CONFIG_XENO_OPT_TIMING_IRQLAT=0
>  > CONFIG_XENO_OPT_RTDM_COMPAT_DEVNODE=y
>  > CONFIG_XENO_DRIVERS_AUTOTUNE=y
>  > CONFIG_XENO_DRIVERS_TIMERBENCH=y
>  > CONFIG_XENO_DRIVERS_SWITCHTEST=y
>  > CONFIG_XENO_ARCH_UNLOCKED_SWITCH=y
>  > CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
>  > CONFIG_IPIPE_WANT_ACTIVE_MM=y
>  > CONFIG_XENO_ARCH_WANT_TIP=y
>  > CONFIG_XENO_ARCH_FPU=y
>  > CONFIG_XENO_ARCH_OUTOFLINE_XNLOCK=y
>  > CONFIG_XENO_VERSION_MAJOR=3
>  > CONFIG_XENO_VERSION_MINOR=0
>  > CONFIG_XENO_REVISION_LEVEL=3
>  > CONFIG_XENO_VERSION_STRING="3.0.3"
>  > CONFIG_XENO_VERSION_NAME="Groovy Cosmic Halo"
>  > CONFIG_IPIPE_ARM_KUSER_TSC=y
>  > CONFIG_NEED_KUSER_HELPERS=y
>  > CONFIG_IPIPE=y
>  > CONFIG_IPIPE_CORE=y
>  > CONFIG_IPIPE_CORE_APIREV=2
>  > CONFIG_IPIPE_WANT_APIREV_2=y
>  > CONFIG_IPIPE_TARGET_APIREV=2
>  > CONFIG_IPIPE_HAVE_HOSTRT=y  
> < CONFIG_PREEMPT=y
> < CONFIG_PREEMPT_COUNT=y
>  > CONFIG_PREEMPT_VOLUNTARY=y  
> < CONFIG_SECCOMP=y
>  > CONFIG_IPV6_SUBTREES=y
>  > CONFIG_BT_HCIUART=m
>  > CONFIG_BT_HCIUART_H4=y
>  > CONFIG_BT_HCIUART_3WIRE=y
>  > CONFIG_BT_HCIUART_BCM=y
>  > CONFIG_QCA7000=m
>  > CONFIG_GPIO_BCM_VIRT=y
>  > CONFIG_DRM=m
>  > CONFIG_DRM_KMS_HELPER=m
>  > CONFIG_DRM_KMS_FB_HELPER=y
>  > CONFIG_DRM_GEM_CMA_HELPER=y
>  > CONFIG_DRM_KMS_CMA_HELPER=y
>  > CONFIG_DRM_VC4=m
>  > CONFIG_HDMI=y
>  > CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>  > CONFIG_SND_BCM2708_SOC_BOOMBERRY_DAC=m
>  > CONFIG_SND_BCM2708_SOC_BOOMBERRY_DIGI=m
>  > CONFIG_HID_BETOP_FF=m
>  > CONFIG_MCP3422=m  
> < CONFIG_DEBUG_PREEMPT=y
> < CONFIG_DYNAMIC_FTRACE=y
> < CONFIG_FTRACE_MCOUNT_RECORD=y
> 
> 
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


