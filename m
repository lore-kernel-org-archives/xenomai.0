From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <7289437c0705280557k2dea8db6r7e4e162078a3c846@domain.hid>
References: <7289437c0705280043o7b8eaf85hbbfad33b95c243fb@domain.hid>
	<1180342178.6188.37.camel@domain.hid> <465A9AD6.7040008@domain.hid>
	<1180343533.6188.40.camel@domain.hid>
	<7289437c0705280557k2dea8db6r7e4e162078a3c846@domain.hid>
Content-Type: text/plain
Date: Mon, 28 May 2007 15:17:55 +0200
Message-Id: <1180358275.4727.28.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
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
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-05-28 at 14:57 +0200, Perrine Martignoni wrote:
> Sorry for the details.
> I work on an ARM and I use the cross compiler ELDK version 4.1
> (build : 2007-01-22-uclibc).
>  
> When I compile sources of xenomai, I have this error message : 
>  
> -Wl,shm_unlink -Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap
> cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.a
> -lpthread -lrt
> 
> ../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In
> function `__wrap_shm_open':
> 
> shm.c:(.text+0x74): undefined reference to `shm_open'
> 
> ../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In
> function `__wrap_shm_unlink':
> 
> shm.c:(.text+0xdc): undefined reference to `shm_unlink'
> 
> collect2: ld returned 1 exit status
> 

Try adding this patch on top of the stock Xenomai release you are using:

--- include/asm-arm/syscall.h	(revision 2472)
+++ include/asm-arm/syscall.h	(working copy)
@@ -167,6 +167,22 @@
 
 #undef CONFIG_XENO_HW_DIRECT_TSC
 
+#include <errno.h>
+
+inline __attribute__((weak)) int shm_open(const char *name,
+					  int oflag,
+					  mode_t mode)
+{
+	errno = ENOSYS;
+	return -1;
+}
+
+inline __attribute__((weak)) int shm_unlink(const char *name)
+{
+	errno = ENOSYS;
+	return -1;
+}
+
 #endif /* __KERNEL__ */
 
 #define XENOMAI_SYSARCH_ATOMIC_ADD_RETURN	0

-- 
Philippe.



