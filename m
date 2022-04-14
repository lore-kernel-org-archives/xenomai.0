Message-ID: <b866f363-423a-8377-1d77-a9ec964d5053@siemens.com>
Date: Thu, 14 Apr 2022 13:36:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] testsuite: Add test for x86 port io
Content-Language: en-US
References: <20220413215900.23020-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220413215900.23020-1-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 13.04.22 23:59, Richard Weinberger via Xenomai wrote:
> Test case for the following regression:
> https://www.xenomai.org/pipermail/xenomai/2022-March/047451.html
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Changes since v1:
> 	- Make sure to restore SA upon failure.
> ---
>  configure.ac                       |  2 +
>  testsuite/smokey/Makefile.am       |  7 +++
>  testsuite/smokey/x86io/Makefile.am |  7 +++
>  testsuite/smokey/x86io/x86io.c     | 77 ++++++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+)
>  create mode 100644 testsuite/smokey/x86io/Makefile.am
>  create mode 100644 testsuite/smokey/x86io/x86io.c
> 
> diff --git a/configure.ac b/configure.ac
> index 019453793..62506de69 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -169,6 +169,7 @@ esac
>  
>  AC_MSG_RESULT([$target_cpu_arch])
>  XENO_TARGET_ARCH=$target_cpu_arch
> +AM_CONDITIONAL(XENO_X86,[test x$target_cpu_arch = xx86])
>  AC_ENABLE_SHARED
>  AC_PROG_LIBTOOL
>  
> @@ -1044,6 +1045,7 @@ AC_CONFIG_FILES([ \
>  	testsuite/smokey/gdb/Makefile \
>  	testsuite/smokey/y2038/Makefile \
>  	testsuite/smokey/can/Makefile
> +	testsuite/smokey/x86io/Makefile
>  	testsuite/clocktest/Makefile \
>  	testsuite/xeno-test/Makefile \
>  	utils/Makefile \
> diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
> index 4a9773f58..79dc61e9f 100644
> --- a/testsuite/smokey/Makefile.am
> +++ b/testsuite/smokey/Makefile.am
> @@ -82,6 +82,10 @@ DIST_SUBDIRS = 		\
>  	xddp		\
>  	y2038
>  
> +if XENO_X86
> +DIST_SUBDIRS += x86io
> +endif
> +
>  if XENO_COBALT
>  if CONFIG_XENO_LIBS_DLOPEN
>  COBALT_SUBDIRS += dlopen
> @@ -89,6 +93,9 @@ endif
>  if XENO_PSHARED
>  COBALT_SUBDIRS += memory-pshared
>  endif
> +if XENO_X86
> +COBALT_SUBDIRS += x86io
> +endif
>  wrappers = $(XENO_POSIX_WRAPPERS)
>  SUBDIRS = $(COBALT_SUBDIRS)
>  else
> diff --git a/testsuite/smokey/x86io/Makefile.am b/testsuite/smokey/x86io/Makefile.am
> new file mode 100644
> index 000000000..d623af042
> --- /dev/null
> +++ b/testsuite/smokey/x86io/Makefile.am
> @@ -0,0 +1,7 @@
> +noinst_LIBRARIES = libx86io.a
> +
> +libx86io_a_SOURCES = x86io.c
> +
> +libx86io_a_CPPFLAGS = 		\
> +	@XENO_USER_CFLAGS@	\
> +	-I$(top_srcdir)/include
> diff --git a/testsuite/smokey/x86io/x86io.c b/testsuite/smokey/x86io/x86io.c
> new file mode 100644
> index 000000000..4db228660
> --- /dev/null
> +++ b/testsuite/smokey/x86io/x86io.c
> @@ -0,0 +1,77 @@
> +/*
> + * Test for a working iopl() after a regression on 5.15:
> + * https://www.xenomai.org/pipermail/xenomai/2022-March/047451.html
> + *
> + * Copyright (C) 2022 sigma star gmbh
> + * Author Richard Weinberger <richard@sigma-star.at>
> + *
> + * Released under the terms of GPLv2.
> + */
> +#include <pthread.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <smokey/smokey.h>
> +#include <string.h>
> +#include <sys/io.h>
> +#include <unistd.h>
> +
> +#define PORT (0x378)
> +
> +static int saw_segv;
> +
> +static void *tfn(void *d)
> +{
> +	struct sched_param schedp = {0};
> +	int ret;
> +
> +	schedp.sched_priority = 1;
> +	__Terrno(ret, sched_setscheduler(0, SCHED_FIFO, &schedp));
> +
> +	(void)inb(PORT);
> +
> +	return (void *)(unsigned long)ret;
> +}
> +
> +static void sgfn(int sig, siginfo_t *si, void *ctx)
> +{
> +	saw_segv = 1;
> +}
> +
> +smokey_test_plugin(x86io, SMOKEY_NOARGS, "Check x86 port io");
> +
> +int run_x86io(struct smokey_test *t, int argc, char *const argv[])
> +{
> +	struct sigaction sa, old_sa;
> +	unsigned long ptret;
> +	pthread_t pt;
> +	int ret;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_sigaction = sgfn;
> +	sa.sa_flags = SA_SIGINFO;
> +	sigemptyset(&sa.sa_mask);
> +
> +	if (!__Terrno(ret, sigaction(SIGSEGV, &sa, &old_sa)))
> +		goto out;
> +
> +	if (!__Terrno(ret, iopl(3)))
> +		goto out_restore;
> +
> +	if (!__T(ret, pthread_create(&pt, NULL, tfn, NULL)))
> +		goto out_restore;
> +
> +	if (!__T(ret, pthread_join(pt, (void *)&ptret)))
> +		goto out_restore;
> +
> +out_restore:
> +	sigaction(SIGSEGV, &old_sa, NULL);
> +
> +out:
> +	if (ret)
> +		return -ret;
> +	if (ptret)
> +		return -ptret;
> +	if (saw_segv)
> +		return -EFAULT;
> +	return 0;
> +}

OK, let's through this at our lab and see if anything explodes.

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

