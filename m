Subject: Re: [Xenomai-help] building cyclic testsuit
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <ac3922a00609280338n59d81a59x7eba1d1b09b5d1c@domain.hid>
References: <ac3922a00609280338n59d81a59x7eba1d1b09b5d1c@domain.hid>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 12:53:45 +0200
Message-Id: <1159440826.4949.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-09-28 at 12:38 +0200, Syed Amer Gilani wrote:
> The "make install" part of installation breaks with following error:
> 
> ../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-init.o): In
> function `__init_posix_interface':
> init.c:(.text+0x280): undefined reference to `pthread_atfork'
> collect2: ld returned 1 exit status
> make[3]: *** [cyclictest] Fehler 1
> make[3]: Leaving directory `/home/amg/xenobuild/src/testsuite/cyclic'
> make[2]: *** [install-recursive] Fehler 1
> make[2]: Leaving directory `/home/amg/xenobuild/src/testsuite'
> make[1]: *** [install-recursive] Fehler 1
> make[1]: Leaving directory `/home/amg/xenobuild/src'
> make: *** [install-recursive] Fehler 1

I guess you are using uClibc? If so, try applying the patch below.
Feedback welcome, so that we can decide whether a similar fix has to be
merged or not.

--- include/asm-powerpc/syscall.h	(revision 1672)
+++ include/asm-powerpc/syscall.h	(working copy)
@@ -190,6 +190,13 @@
 }
 #endif /* __powerpc64__ */
 
+inline __attribute__((weak)) int pthread_atfork(void (*prepare)(void),
+						void (*parent)(void),
+						void (*child)(void))
+{
+	return 0;
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* !_XENO_ASM_POWERPC_SYSCALL_H */
> 
> how can i fix this?
> simply skipping cyclic does not work with "--without--cyclic" or
> "--disable-cyclic"

> Regards,
> Syed Amer Gilani
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



