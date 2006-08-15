Subject: Re: [Xenomai-core] Buildbot cannot compile xenoma:
	rtcanconfig	refences pthread_kill
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44E1BC1F.7030208@domain.hid>
References: <200608150949.30029.niklaus.giger@domain.hid>
	<44E182B8.8000300@domain.hid> <1155642921.4327.7.camel@domain.hid>
	<44E1BC1F.7030208@domain.hid>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 15:44:02 +0200
Message-Id: <1155649442.4327.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2006-08-15 at 14:20 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2006-08-15 at 10:15 +0200, Jan Kiszka wrote:
> >> Niklaus Giger wrote:
> >>> Hi
> >>>
> >>> All my PPC based compilation fail with something like
> >>>
> >>> ccache gcc -rdynamic -o .libs/rtcanconfig 
> >>> rtcanconfig.o  -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/native -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.libs/librtdm.so -Wl,--rpath -Wl,/usr/xenomai/lib
> >>> /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.libs/librtdm.so: 
> >>> undefined reference to `pthread_kill'
> >>> http://ngiger.dyndns.org/buildbot/ppc/builds/229/step-mk_xeno/0
> >>> Is this only a PPC problem? It appears first with build 226, which referred to 
> >>> revisions 1433 and 1434. Details see 
> >>> http://ngiger.dyndns.org/buildbot/ppc/builds/226
> >>>
> >>> Jan, could you please have a look at the error, as it seems to me that you 
> >>> reduced the lib dependencies a little bit too much?
> >> Well, neither rtcanconfig nor librtdm have explicit dependencies on
> >> libpthread. Unfortunately, the generic skin init code now drags in
> >> pthread_kill when the linker fails to remove xeno_handle_mlock_alert for
> >> librtdm. That doesn't happen with my gcc-4.1, likely older compilers are
> >> less smart.
> >>
> >> Anyone any ideas how to solve it WITHOUT adding -lpthread to librtdm?
> > 
> > Could you develop a bit more, i.e. what's the issue with adding this
> > dependency?
> 
> It's simply unneeded. This is only a single tiny tool, but we may see
> more of them in the future, so I would like to clean this up now.
> 

Sounds reasonable.

> > 
> >>  I
> >> would say either move that functions to a separate module
> > 
> > The reason to have this code in nucleus/bind.h is that we don't have any
> > dependency on common libs aside of the ones providing the skin syscalls,
> > and we try to avoid code duplication by not implementing this stuff into
> > each and every init.c files.
> > 
> >>  or include it
> >> via a separate header that all skins include except rtdm.
> >>
> > 
> > I'm still reluctant to make RTDM an exception to the common rule,
> > especially to fix a compiler issue.
> 
> Actually, the issue is slightly broader, though with varying
> significance. The current approach drags xeno_handle_mlock_alert and
> xeno_sigxcpu_no_mlock multiple times into the skin lib. Even with
> gcc-4.1 that increases libnative by a few data bytes, under 3.3 by ~300
> byte of dead code (overall increase of /lib with 3.3: 32 Kbyte).
> 
> The attached patch solves both the linking issue and avoids multiple
> static includes of code and variables that are only required once. I

Ok, this patch looks ok and does not rely on funky file-scoped macros,
which is good (this is what I would not want to see in the tree anymore,
hence the bits/ scheme).

> think it's cleaner this way, following the idea of asm/bits/ (BTW,
> should it become a asm-generic/bits header?).
> 

Probably, yes; and the same goes for nucleus/bind.h. In which case,
checking for __XENO_SIM__ would become useless. In any case, the various
init.c files are not parsed by the compiler when building the simulated
environment.

> Jan
> plain text document attachment (separate_mlock_alert.patch)
> Index: include/nucleus/mlock_alert.h
> ===================================================================
> --- include/nucleus/mlock_alert.h	(revision 0)
> +++ include/nucleus/mlock_alert.h	(revision 0)
> @@ -0,0 +1,37 @@
> +#ifndef _XENO_NUCLEUS_MLOCK_ALERT_H
> +#define _XENO_NUCLEUS_MLOCK_ALERT_H
> +
> +#ifndef __XENO_SIM__
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <pthread.h>
> +
> +__attribute__ ((weak))
> +int xeno_sigxcpu_no_mlock = 1;
> +
> +__attribute__ ((visibility ("internal")))
> +void xeno_handle_mlock_alert(int sig)
> +{
> +	struct sigaction sa;
> +
> +	if (xeno_sigxcpu_no_mlock) {
> +		fprintf(stderr, "Xenomai: process memory not locked "
> +			"(missing mlockall?)\n");
> +		fflush(stderr);
> +		exit(4);
> +	}
> +
> +	/* XNTRAPSW was set for the thread but no user-defined handler
> +	   has been set to override our internal handler, so let's
> +	   invoke the default signal action. */
> +
> +	sa.sa_handler = SIG_DFL;
> +	sigemptyset(&sa.sa_mask);
> +	sa.sa_flags = 0;
> +	sigaction(SIGXCPU, &sa, NULL);
> +	pthread_kill(pthread_self(), SIGXCPU);
> +}
> +#endif /* __XENO_SIM__ */
> +
> +#endif /* _XENO_NUCLEUS_MLOCK_ALERT_H */
> Index: include/nucleus/bind.h
> ===================================================================
> --- include/nucleus/bind.h	(revision 1440)
> +++ include/nucleus/bind.h	(working copy)
> @@ -6,33 +6,9 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <signal.h>
> -#include <pthread.h>
>  #include <asm/xenomai/syscall.h>
>  
> -__attribute__ ((weak))
> -int xeno_sigxcpu_no_mlock = 1;
> -
> -static void xeno_handle_mlock_alert(int sig)
> -{
> -	struct sigaction sa;
> -
> -	if (xeno_sigxcpu_no_mlock) {
> -		fprintf(stderr,
> -			"Xenomai: process memory not locked (missing mlockall?)\n");
> -		fflush(stderr);
> -		exit(4);
> -	}
> -
> -	/* XNTRAPSW was set for the thread but no user-defined handler
> -	   has been set to override our internal handler, so let's
> -	   invoke the default signal action. */
> -
> -	sa.sa_handler = SIG_DFL;
> -	sigemptyset(&sa.sa_mask);
> -	sa.sa_flags = 0;
> -	sigaction(SIGXCPU, &sa, NULL);
> -	pthread_kill(pthread_self(), SIGXCPU);
> -}
> +void xeno_handle_mlock_alert(int sig);
>  
>  static inline int
>  xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module)
> Index: src/skins/rtai/init.c
> ===================================================================
> --- src/skins/rtai/init.c	(revision 1440)
> +++ src/skins/rtai/init.c	(working copy)
> @@ -20,6 +20,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <rtai/syscall.h>
> +#include <nucleus/mlock_alert.h>
>  
>  int __rtai_muxid = -1;
>  
> Index: src/skins/posix/init.c
> ===================================================================
> --- src/skins/posix/init.c	(revision 1440)
> +++ src/skins/posix/init.c	(working copy)
> @@ -26,6 +26,7 @@
>  #include <posix/posix.h>
>  #include <posix/syscall.h>
>  #include <rtdm/syscall.h>
> +#include <nucleus/mlock_alert.h>
>  
>  int __pse51_muxid = -1;
>  int __rtdm_muxid = -1;
> Index: src/skins/vxworks/init.c
> ===================================================================
> --- src/skins/vxworks/init.c	(revision 1440)
> +++ src/skins/vxworks/init.c	(working copy)
> @@ -23,6 +23,7 @@
>  #include <stdlib.h>
>  #include <pthread.h>
>  #include <vxworks/vxworks.h>
> +#include <nucleus/mlock_alert.h>
>  
>  pthread_key_t __vxworks_tskey;
>  
> Index: src/skins/vrtx/init.c
> ===================================================================
> --- src/skins/vrtx/init.c	(revision 1440)
> +++ src/skins/vrtx/init.c	(working copy)
> @@ -23,6 +23,7 @@
>  #include <stdlib.h>
>  #include <pthread.h>
>  #include <vrtx/vrtx.h>
> +#include <nucleus/mlock_alert.h>
>  
>  pthread_key_t __vrtx_tskey;
>  
> Index: src/skins/native/init.c
> ===================================================================
> --- src/skins/native/init.c	(revision 1440)
> +++ src/skins/native/init.c	(working copy)
> @@ -24,6 +24,7 @@
>  #include <pthread.h>
>  #include <native/syscall.h>
>  #include <native/task.h>
> +#include <nucleus/mlock_alert.h>
>  
>  pthread_key_t __native_tskey;
>  
-- 
Philippe.



