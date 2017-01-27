Date: Fri, 27 Jan 2017 15:04:22 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170127150422.6aef6bfd@md1em3qc>
In-Reply-To: <20170127135222.28440-1-henning.schild@siemens.com>
References: <20170126155926.594b8e2b@md1em3qc>
 <20170127135222.28440-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] testsuite/switchtest/x86: allow in kernel-FPU
	testing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Fri, 27 Jan 2017 14:52:22 +0100
Henning Schild <henning.schild@siemens.com> wrote:

> Not running the in-kernel FPU tests while Linux might be using the FPU
> in kernel-mode is a safeguard measure for development versions that
> might still have issues with FPU context switching. i.e. it prevents
> data corruption on RAIDs beeing triggered by an FPU Bug.
> In a bug-free kernel running the switchtest in kernel-mode is not a
> problem and may be desired for proper test-coverage.
> 
> This patch introduces a command line option to switchtest to allow
> overriding the safeguard.

I am not sure i am happy with this solution either. Actually the test
should always run as part of the unit tests. It is very valuable and
skipping it "silently" is a really bad idea.
If it is really just disabled for when it might mess with your raid on
the machine you do kernel development on, maybe you should not use
such a machine for that?
So i am starting to think the test should run by default and the
conservative version should be opt-in instead of opt-out.

Henning

> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  include/rtdm/uapi/testing.h                              |  1 +
>  kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h      |  2 +-
>  kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h    |  2 +-
>  kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h |  2 +-
>  kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h  |  2 +-
>  kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h      | 14
> ++++++++++++--
> kernel/drivers/testing/switchtest.c                      |  7 +++++--
> testsuite/switchtest/switchtest.c                        | 11
> ++++++++++- 8 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
> index 06b8f1e..099a589 100644
> --- a/include/rtdm/uapi/testing.h
> +++ b/include/rtdm/uapi/testing.h
> @@ -70,6 +70,7 @@ struct rttst_swtest_task {
>  #define RTTST_SWTEST_FPU		0x1
>  #define RTTST_SWTEST_USE_FPU		0x2 /* Only for
> kernel-space tasks. */ #define RTTST_SWTEST_FREEZE
> 0x4 /* Only for kernel-space tasks. */ +#define
> RTTST_SWTEST_FORCE		0x8 /* Only for kernel-space tasks.
> */ struct rttst_swtest_dir {
>  	unsigned int from;
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
> b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h index
> a76f1e6..7bc92f3 100644 ---
> a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h +++
> b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h @@ -35,7 +35,7
> @@ static inline int fp_kernel_supported(void) return 1;
>  }
>  
> -static inline int fp_linux_begin(void)
> +static inline int fp_linux_begin(int __maybe_unused force)
>  {
>  	return -ENOSYS;
>  }
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h index
> cfdf0b3..c15e1a5 100644 ---
> a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h +++
> b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h @@ -30,7
> +30,7 @@ static inline int fp_kernel_supported(void) return 1;
>  }
>  
> -static inline int fp_linux_begin(void)
> +static inline int fp_linux_begin(int __maybe_unused force)
>  {
>  	return -ENOSYS;
>  }
> diff --git a/kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h
> b/kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h index
> 904ce83..6ef979a 100644 ---
> a/kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h +++
> b/kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h @@ -27,7
> +27,7 @@ static inline int fp_kernel_supported(void) return 0;
>  }
>  
> -static inline int fp_linux_begin(void)
> +static inline int fp_linux_begin(int __maybe_unused force)
>  {
>  	return -ENOSYS;
>  }
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h
> b/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h index
> e09ca2c..48bec0a 100644 ---
> a/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h +++
> b/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h @@ -41,7
> +41,7 @@ static inline int fp_kernel_supported(void)
> #endif	/* !CONFIG_PPC_FPU */ }
>  
> -static inline int fp_linux_begin(void)
> +static inline int fp_linux_begin(int __maybe_unused force)
>  {
>  	return -ENOSYS;
>  }
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
> b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h index
> f0ecd00..3c1fe3c 100644 ---
> a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h +++
> b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h @@ -29,13
> +29,15 @@ static inline int fp_kernel_supported(void) return 1;
>  }
>  
> -static inline int fp_linux_begin(void)
> +static inline int fp_linux_begin(int __maybe_unused force)
>  {
>  #if defined(CONFIG_X86_USE_3DNOW) \
>  	|| defined(CONFIG_MD_RAID456) ||
> defined(CONFIG_MD_RAID456_MODULE) /* Ther kernel uses x86 FPU, we can
> not also use it in our tests. */ static int once = 0;
> -	if (!once) {
> +	if (force)
> +		goto nocheck;
> +	if (once != 1) {
>  		once = 1;
>  		printk("%s:%d: Warning: Linux is compiled to use FPU
> in " "kernel-space.\nFor this reason, switchtest can not "
> @@ -43,6 +45,14 @@ static inline int fp_linux_begin(void)
>  		       __FILE__, __LINE__);
>  	}
>  	return -EBUSY;
> +nocheck:
> +	if (once != 2) {
> +		once = 2;
> +		printk("%s:%d: Warning: Switchtest is using FPU in "
> +		       "kernel-space\nwhile Linux might do so as
> well.\n",
> +		       __FILE__, __LINE__);
> +
> +	}
>  #endif /* 3DNow or RAID 456 */
>  	kernel_fpu_begin();
>  	/* kernel_fpu_begin() does no re-initialize the fpu context,
> but diff --git a/kernel/drivers/testing/switchtest.c
> b/kernel/drivers/testing/switchtest.c index 3a2e0d5..3befae2 100644
> --- a/kernel/drivers/testing/switchtest.c
> +++ b/kernel/drivers/testing/switchtest.c
> @@ -276,7 +276,10 @@ static int rtswitch_to_nrt(struct
> rtswitch_context *ctx, 
>  		case RTSWITCH_RT:
>  
> -			if (!fp_check || fp_linux_begin() < 0) {
> +			if (!fp_check ||
> +			    fp_linux_begin(to->base.flags &
> RTTST_SWTEST_FORCE)
> +			      < 0)
> +			{
>  				fp_check = 0;
>  				goto signal_nofp;
>  			}
> @@ -308,7 +311,7 @@ static int rtswitch_to_nrt(struct
> rtswitch_context *ctx, (ctx->switches_count % 4000000) * 1000;
>  			barrier();
>  
> -			fp_linux_begin();
> +			fp_linux_begin(to->base.flags &
> RTTST_SWTEST_FORCE); fp_regs_set(fp_features, expected);
>  			rtdm_event_signal(&to->rt_synch);
>  			fp_val = fp_regs_check(fp_features,
> expected, report); diff --git a/testsuite/switchtest/switchtest.c
> b/testsuite/switchtest/switchtest.c index 5c102a2..66b5b84 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -89,6 +89,7 @@ static struct timespec start;
>  static pthread_mutex_t headers_lock;
>  static unsigned long data_lines = 21;
>  static unsigned freeze_on_error;
> +static unsigned force_kernel_fpu;
>  static int fp_features;
>  static pthread_t main_tid;
>  
> @@ -815,7 +816,8 @@ static int task_create(struct cpu_tasks *cpu,
>  	case RTK:
>  		param->swt.flags = (param->fp & AFP ?
> RTTST_SWTEST_FPU : 0) | (param->fp & UFPP ? RTTST_SWTEST_USE_FPU : 0)
> -			| (freeze_on_error ? RTTST_SWTEST_FREEZE :
> 0);
> +			| (freeze_on_error ? RTTST_SWTEST_FREEZE : 0)
> +			| (force_kernel_fpu ? RTTST_SWTEST_FORCE :
> 0); 
>  		err=ioctl(cpu->fd,RTTST_RTIOC_SWTEST_CREATE_KTASK,&param->swt);
>  		if (err) {
> @@ -1012,6 +1014,8 @@ static void usage(FILE *fd, const char
> *progname) "--stress <period> or -s <period> enable a stress mode
> where:\n" "  context switches occur every <period> us;\n"
>  		"  a background task uses fpu (and check) fpu all
> the time.\n"
> +		"--force-kernel-fpu run in kernel fpu tests even if
> the kernel"
> +		"  seems to be using the fpu internally.\n"
>  		"--freeze trace upon error.\n\n"
>  		"Each 'threadspec' specifies the characteristics of
> a " "thread to be created:\n"
> @@ -1154,6 +1158,7 @@ int main(int argc, const char *argv[])
>  	opterr = 0;
>  	for (;;) {
>  		static struct option long_options[] = {
> +			{ "force-kernel-fpu", 0, NULL, 'F' },
>  			{ "freeze",  0, NULL, 'f' },
>  			{ "help",    0, NULL, 'h' },
>  			{ "lines",   1, NULL, 'l' },
> @@ -1172,6 +1177,10 @@ int main(int argc, const char *argv[])
>  			break;
>  
>  		switch(c) {
> +		case 'F':
> +			force_kernel_fpu = 1;
> +			break;
> +
>  		case 'f':
>  			freeze_on_error = 1;
>  			break;


