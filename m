From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eZd47tm8p9"
Content-Transfer-Encoding: 7bit
Message-ID: <17528.28463.599578.54637@domain.hid>
Date: Sat, 27 May 2006 17:24:31 +0200
Subject: Re: [Xenomai-core] [sim] ... doesn't build
In-Reply-To: <44786C8F.9070201@domain.hid>
References: <44786C8F.9070201@domain.hid>
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


--eZd47tm8p9
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > Hi,
 > 
 > I just tried to get the simulator from trunk built but failed here:
 > 
 > In file included from ../../../../xenomai/sim/../include/posix/posix.h:29,
 >                  from
 > ../../../../xenomai/sim/../ksrc/skins/posix/internal.h:24,
 >                  from
 > ../../../../xenomai/sim/../ksrc/skins/posix/thread.h:23,
 >                  from
 > ../../../../xenomai/sim/../ksrc/skins/posix/sched.c:48:
 > ../../../../xenomai/sim/../include/posix/pthread.h:246: conflicting
 > types for `pthread_attr_getaffinity_np'
 > /usr/include/pthread.h:383: previous declaration of
 > `pthread_attr_getaffinity_np'
 > ../../../../xenomai/sim/../include/posix/pthread.h:249: conflicting
 > types for `pthread_attr_setaffinity_np'
 > /usr/include/pthread.h:377: previous declaration of
 > `pthread_attr_setaffinity_np'
 > 
 > Looks like glibc-2.4 (that one comes with my opensuse 10.1) now also
 > knows get/setaffinity. Prototypes of glibc:
 > 
 > extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
 >                                         size_t __cpusetsize,
 >                                         __const cpu_set_t *__cpuset)
 > __THROW;
 > extern int pthread_attr_getaffinity_np (__const pthread_attr_t *__attr,
 >                                         size_t __cpusetsize,
 >                                         cpu_set_t *__cpuset) __THROW;
 > 

Could you try the attached patch ?

 > Moreover, I get tons of this warning:
 > 
 > /usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union that
 > defines no instances
 > 
 > But this is an "imported" issue, isn't it? Likely due to some picky gcc
 > switch during the simulator build.

It depends on what is defined at line 69 of pthreadtypes.h...

-- 


					    Gilles Chanteperdrix.

--eZd47tm8p9
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-posix-overrides-h.diff"
Content-Transfer-Encoding: 7bit

Index: sim/skins/posix/posix_overrides.h
===================================================================
--- sim/skins/posix/posix_overrides.h	(revision 1135)
+++ sim/skins/posix/posix_overrides.h	(working copy)
@@ -72,6 +72,8 @@
 #define pthread_attr_setname_np pse51_threadattr_setname_np
 #define pthread_attr_getfp_np pse51_threadattr_getfp_np
 #define pthread_attr_setfp_np pse51_threadattr_setfp_np
+#define pthread_attr_setaffinity_np pse51_threadattr_setaffinity_np
+#define pthread_attr_getaffinity_np pse51_threadattr_getaffinity_np
 #define pthread_create pse51_thread_create
 #define pthread_detach pse51_thread_detach
 #define pthread_equal pse51_thread_equal

--eZd47tm8p9--

