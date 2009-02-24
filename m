Message-ID: <49A4209F.60502@domain.hid>
Date: Tue, 24 Feb 2009 17:30:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <a0e7fce50902240018g6be57617g2c5f14c55685ef24@domain.hid>
In-Reply-To: <a0e7fce50902240018g6be57617g2c5f14c55685ef24@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] blackfin: build xenomai in FLAT format
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yi li <liyi.dev@domain.hid>
Cc: Xenomai-core@domain.hid

yi li wrote:
> This patch fixes xenomai-2.4.x branch build scripts, to build xenomai
> as FLAT on Blackfin.
> 
> 1. "-mfdpic" option is by default set by bfin-linux-uclibc-gcc. It is
> not required and it can cause error for bfin-uclinux-gcc.

Ack.

> 2.  libpthread_rt.la should not depend on "lpthread".
> 

Nak. In flat mode, turning the link dependencies order upside down will not buy
us anything. Two-phase link is the only way to prevent circular/invalid
dependencies with a static only format when symbol wrapping is involved.

> -Yi
> 
> diff -Nurp --exclude=.svn xenomai-2.4.x-clean/configure xenomai-2.4.x/configure
> --- xenomai-2.4.x-clean/configure	2008-12-04 19:21:40.000000000 +0800
> +++ xenomai-2.4.x/configure	2009-02-23 17:12:14.000000000 +0800
> @@ -22569,10 +22569,10 @@ case $XENO_TARGET_ARCH in
>          ;;
>   blackfin)
>  	# Produce libraries in FDPIC format.
> -	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe -mfdpic"
> -	XENO_USER_LDFLAGS="$XENO_USER_CFLAGS -mfdpic"
> -	XENO_USER_APP_CFLAGS="$XENO_USER_APP_CFLAGS -mfdpic"
> -	XENO_USER_APP_LDFLAGS="$XENO_USER_APP_LDFLAGS -mfdpic"
> +	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe"
> +	XENO_USER_LDFLAGS="$XENO_USER_CFLAGS"
> +	XENO_USER_APP_CFLAGS="$XENO_USER_APP_CFLAGS"
> +	XENO_USER_APP_LDFLAGS="$XENO_USER_APP_LDFLAGS"
>          ;;
>   arm)
>  	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe
> -march=armv$CONFIG_XENO_ARM_ARCH"
> diff -Nurp --exclude=.svn xenomai-2.4.x-clean/configure.in
> xenomai-2.4.x/configure.in
> --- xenomai-2.4.x-clean/configure.in	2008-12-04 19:21:40.000000000 +0800
> +++ xenomai-2.4.x/configure.in	2009-02-23 17:12:14.000000000 +0800
> @@ -648,10 +648,10 @@ case $XENO_TARGET_ARCH in
>          ;;
>   blackfin)
>  	# Produce libraries in FDPIC format.
> -	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe -mfdpic"
> -	XENO_USER_LDFLAGS="$XENO_USER_CFLAGS -mfdpic"
> -	XENO_USER_APP_CFLAGS="$XENO_USER_APP_CFLAGS -mfdpic"
> -	XENO_USER_APP_LDFLAGS="$XENO_USER_APP_LDFLAGS -mfdpic"
> +	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe"
> +	XENO_USER_LDFLAGS="$XENO_USER_CFLAGS"
> +	XENO_USER_APP_CFLAGS="$XENO_USER_APP_CFLAGS"
> +	XENO_USER_APP_LDFLAGS="$XENO_USER_APP_LDFLAGS"
>          ;;
>   arm)
>  	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe
> -march=armv$CONFIG_XENO_ARM_ARCH"
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/skins/posix/Makefile.am
> xenomai-2.4.x/src/skins/posix/Makefile.am
> --- xenomai-2.4.x-clean/src/skins/posix/Makefile.am	2008-03-10
> 06:33:59.000000000 +0800
> +++ xenomai-2.4.x/src/skins/posix/Makefile.am	2009-02-23
> 17:12:14.000000000 +0800
> @@ -2,7 +2,7 @@ includedir = $(prefix)/include/posix
> 
>  lib_LTLIBRARIES = libpthread_rt.la
> 
> -libpthread_rt_la_LDFLAGS = -version-info 1:0:0 -lpthread
> +libpthread_rt_la_LDFLAGS = -version-info 1:0:0
> 
>  libpthread_rt_la_SOURCES = \
>  	init.c \
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/skins/posix/Makefile.in
> xenomai-2.4.x/src/skins/posix/Makefile.in
> --- xenomai-2.4.x-clean/src/skins/posix/Makefile.in	2008-06-02
> 05:32:28.000000000 +0800
> +++ xenomai-2.4.x/src/skins/posix/Makefile.in	2009-02-23
> 17:12:14.000000000 +0800
> @@ -239,7 +239,7 @@ target_vendor = @target_vendor@
>  top_builddir = @top_builddir@
>  top_srcdir = @top_srcdir@
>  lib_LTLIBRARIES = libpthread_rt.la
> -libpthread_rt_la_LDFLAGS = -version-info 1:0:0 -lpthread
> +libpthread_rt_la_LDFLAGS = -version-info 1:0:0
>  libpthread_rt_la_SOURCES = \
>  	init.c \
>  	thread.c \
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/testsuite/clocktest/Makefile.am
> xenomai-2.4.x/src/testsuite/clocktest/Makefile.am
> --- xenomai-2.4.x-clean/src/testsuite/clocktest/Makefile.am	2008-03-01
> 04:41:56.000000000 +0800
> +++ xenomai-2.4.x/src/testsuite/clocktest/Makefile.am	2009-02-23
> 17:12:14.000000000 +0800
> @@ -9,7 +9,7 @@ clocktest_CPPFLAGS = -I$(top_srcdir)/inc
>  clocktest_LDFLAGS = $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)
> 
>  clocktest_LDADD = \
> -	../../skins/posix/libpthread_rt.la -lpthread -lrt
> +	-lpthread -lrt ../../skins/posix/libpthread_rt.la
> 
>  install-data-local:
>  	$(mkinstalldirs) $(DESTDIR)$(testdir)
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/testsuite/clocktest/Makefile.in
> xenomai-2.4.x/src/testsuite/clocktest/Makefile.in
> --- xenomai-2.4.x-clean/src/testsuite/clocktest/Makefile.in	2008-06-02
> 05:32:28.000000000 +0800
> +++ xenomai-2.4.x/src/testsuite/clocktest/Makefile.in	2009-02-23
> 17:12:14.000000000 +0800
> @@ -232,7 +232,7 @@ clocktest_SOURCES = clocktest.c
>  clocktest_CPPFLAGS = -I$(top_srcdir)/include/posix
> $(XENO_USER_CFLAGS) -I$(top_srcdir)/include
>  clocktest_LDFLAGS = $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)
>  clocktest_LDADD = \
> -	../../skins/posix/libpthread_rt.la -lpthread -lrt
> +	-lpthread -lrt ../../skins/posix/libpthread_rt.la
> 
>  EXTRA_DIST = runinfo.in
>  all: all-am
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/testsuite/cyclic/Makefile.am
> xenomai-2.4.x/src/testsuite/cyclic/Makefile.am
> --- xenomai-2.4.x-clean/src/testsuite/cyclic/Makefile.am	2008-03-01
> 04:41:56.000000000 +0800
> +++ xenomai-2.4.x/src/testsuite/cyclic/Makefile.am	2009-02-23
> 17:12:14.000000000 +0800
> @@ -9,7 +9,7 @@ cyclictest_CPPFLAGS = -I$(top_srcdir)/in
>  cyclictest_LDFLAGS = $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)
> 
>  cyclictest_LDADD = \
> -	../../skins/posix/libpthread_rt.la -lpthread -lrt
> +	-lpthread -lrt ../../skins/posix/libpthread_rt.la
> 
>  install-data-local:
>  	$(mkinstalldirs) $(DESTDIR)$(testdir)
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/testsuite/cyclic/Makefile.in
> xenomai-2.4.x/src/testsuite/cyclic/Makefile.in
> --- xenomai-2.4.x-clean/src/testsuite/cyclic/Makefile.in	2008-06-02
> 05:32:28.000000000 +0800
> +++ xenomai-2.4.x/src/testsuite/cyclic/Makefile.in	2009-02-23
> 17:12:14.000000000 +0800
> @@ -232,7 +232,7 @@ cyclictest_SOURCES = cyclictest.c
>  cyclictest_CPPFLAGS = -I$(top_srcdir)/include/posix
> $(XENO_USER_CFLAGS) -DIPIPE_TRACE=1 -I$(top_srcdir)/include
>  cyclictest_LDFLAGS = $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)
>  cyclictest_LDADD = \
> -	../../skins/posix/libpthread_rt.la -lpthread -lrt
> +	-lpthread -lrt ../../skins/posix/libpthread_rt.la
> 
>  EXTRA_DIST = runinfo.in
>  all: all-am
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/testsuite/irqbench/Makefile.am
> xenomai-2.4.x/src/testsuite/irqbench/Makefile.am
> --- xenomai-2.4.x-clean/src/testsuite/irqbench/Makefile.am	2008-03-01
> 04:41:56.000000000 +0800
> +++ xenomai-2.4.x/src/testsuite/irqbench/Makefile.am	2009-02-23
> 17:12:14.000000000 +0800
> @@ -19,7 +19,7 @@ irqloop_LDFLAGS = \
>  	$(XENO_USER_LDFLAGS)
> 
>  irqloop_LDADD = \
> -	../../skins/posix/libpthread_rt.la -lpthread -lrt
> +	-lpthread -lrt ../../skins/posix/libpthread_rt.la
> 
> 
>  irqbench_SOURCES = irqbench.c
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/testsuite/irqbench/Makefile.in
> xenomai-2.4.x/src/testsuite/irqbench/Makefile.in
> --- xenomai-2.4.x-clean/src/testsuite/irqbench/Makefile.in	2008-06-02
> 05:32:28.000000000 +0800
> +++ xenomai-2.4.x/src/testsuite/irqbench/Makefile.in	2009-02-23
> 17:12:14.000000000 +0800
> @@ -247,7 +247,7 @@ irqloop_LDFLAGS = \
>  	$(XENO_USER_LDFLAGS)
> 
>  irqloop_LDADD = \
> -	../../skins/posix/libpthread_rt.la -lpthread -lrt
> +	-lpthread -lrt ../../skins/posix/libpthread_rt.la
> 
>  irqbench_SOURCES = irqbench.c
>  irqbench_CPPFLAGS = \
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/testsuite/switchtest/Makefile.am
> xenomai-2.4.x/src/testsuite/switchtest/Makefile.am
> --- xenomai-2.4.x-clean/src/testsuite/switchtest/Makefile.am	2008-03-01
> 04:41:56.000000000 +0800
> +++ xenomai-2.4.x/src/testsuite/switchtest/Makefile.am	2009-02-23
> 17:12:14.000000000 +0800
> @@ -9,7 +9,7 @@ switchtest_CPPFLAGS = -I$(top_srcdir)/in
>  switchtest_LDFLAGS =  $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)
> 
>  switchtest_LDADD = \
> -	../../skins/posix/libpthread_rt.la -lpthread -lrt
> +	-lpthread -lrt ../../skins/posix/libpthread_rt.la
> 
>  install-data-local:
>  	$(mkinstalldirs) $(DESTDIR)$(testdir)
> diff -Nurp --exclude=.svn
> xenomai-2.4.x-clean/src/testsuite/switchtest/Makefile.in
> xenomai-2.4.x/src/testsuite/switchtest/Makefile.in
> --- xenomai-2.4.x-clean/src/testsuite/switchtest/Makefile.in	2008-06-02
> 05:32:28.000000000 +0800
> +++ xenomai-2.4.x/src/testsuite/switchtest/Makefile.in	2009-02-23
> 17:12:14.000000000 +0800
> @@ -232,7 +232,7 @@ switchtest_SOURCES = switchtest.c
>  switchtest_CPPFLAGS = -I$(top_srcdir)/include/posix
> $(XENO_USER_CFLAGS) -g -I$(top_srcdir)/include
>  switchtest_LDFLAGS = $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)
>  switchtest_LDADD = \
> -	../../skins/posix/libpthread_rt.la -lpthread -lrt
> +	-lpthread -lrt ../../skins/posix/libpthread_rt.la
> 
>  EXTRA_DIST = runinfo.in
>  all: all-am
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

