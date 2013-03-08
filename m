Message-ID: <51398412.2020800@xenomai.org>
Date: Fri, 08 Mar 2013 07:24:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51372B12.2030400@mitrol.it>	<51373149.4050700@xenomai.org>	<5137370B.2050402@mitrol.it>	<51373841.70704@xenomai.org>	<51385910.80203@mitrol.it>	<51388A3A.2090004@xenomai.org>
	<51388DD2.2020805@mitrol.it>	<51388EB2.6000206@xenomai.org>
	<51389940.1090100@mitrol.it> <51398293.9030103@xenomai.org>
In-Reply-To: <51398293.9030103@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sporadic problem : rt_task_sleep
	locked	after	debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>, Xenomai <xenomai@xenomai.org>

On 03/08/2013 07:17 AM, Gilles Chanteperdrix wrote:

> On 03/07/2013 02:42 PM, Paolo Minazzi wrote:
> 
>> Il 07/03/2013 13.57, Gilles Chanteperdrix ha scritto:
>>> #define ARM(x...)	x
>>> #define	THUMB(x...)
>> I have a problem of double definition of  __xn_tscinfo
>>
>> #make
>> 2ms.c: In function 'InitIrq':
>> 2ms.c:182: warning: incompatible implicit declaration of built-in 
>> function 'exit'
>> /DVD/xenomai-2.6.2.1/src/skins/common/.libs/libxenomai.a(libxenomai_la-bind.o):(.data+0x0): 
>> multiple definition of `__xn_tscinfo'
>> /DVD/xenomai-2.6.2.1/src/skins/native/.libs/libnative.a(libnative_la-init.o):(.data+0x4): 
>> first defined here
>> collect2: ld returned 1 exit status
>> make: *** [All] Error 1
>>
>>
>> __xn_tscinfo is defined in src/include/asm/xenomai/bits/bind.h
>>
>> ...
>> ...
>> #include <asm-generic/xenomai/bits/bind.h>
>> #include <asm/xenomai/syscall.h>
>>
>> struct __xn_full_tscinfo __xn_tscinfo = {
>>          .kinfo = {
>>                  .type = -1,
>>          },
>> };
>> ...
>> ...
>>
>> It is strange define a struct in a .h file.
> 
> 
> Right, normally this file should only be included in
> src/skins/common/bind.c, but it happens to be included in all skins.
> Will fix.
> 

Could you try to compile again static libraries with the following patch
applied?

diff --git a/include/asm-nios2/bits/bind.h b/include/asm-nios2/bits/bind.h
index 067e7e2..668d8b8 100644
--- a/include/asm-nios2/bits/bind.h
+++ b/include/asm-nios2/bits/bind.h
@@ -12,7 +12,7 @@

 #include <asm-generic/xenomai/bits/bind.h>

-__attribute__((weak)) volatile void *xeno_nios2_hrclock = NULL;
+volatile void *xeno_nios2_hrclock = NULL;

 static inline void xeno_nios2_features_check(struct xnfeatinfo *finfo)
 {
diff --git a/include/asm-sh/bits/bind.h b/include/asm-sh/bits/bind.h
index 3b2b54d..bd25f80 100644
--- a/include/asm-sh/bits/bind.h
+++ b/include/asm-sh/bits/bind.h
@@ -14,10 +14,8 @@

 struct xnarch_tsc_area;

-__attribute__((weak))
 volatile struct xnarch_tsc_area *xeno_sh_tsc = NULL;

-__attribute__((weak))
 volatile unsigned long *xeno_sh_tcnt = NULL;

 static volatile void *__xeno_kmem_map(unsigned long pa, unsigned int
pagesz)
diff --git a/src/skins/native/init.c b/src/skins/native/init.c
index 2c36444..5d433b3 100644
--- a/src/skins/native/init.c
+++ b/src/skins/native/init.c
@@ -24,7 +24,7 @@
 #include <pthread.h>
 #include <native/syscall.h>
 #include <native/task.h>
-#include <asm/xenomai/bits/bind.h>
+#include <asm-generic/xenomai/bits/bind.h>

 int __native_muxid = -1;
 static int fork_handler_registered;
diff --git a/src/skins/posix/init.c b/src/skins/posix/init.c
index 332081a..83d27a6 100644
--- a/src/skins/posix/init.c
+++ b/src/skins/posix/init.c
@@ -30,7 +30,7 @@
 #include <posix/mutex.h>
 #include <rtdk.h>

-#include <asm/xenomai/bits/bind.h>
+#include <asm-generic/xenomai/bits/bind.h>

 int __pse51_muxid = -1;
 int __pse51_rtdm_muxid = -1;
diff --git a/src/skins/psos+/init.c b/src/skins/psos+/init.c
index b72825f..5098f91 100644
--- a/src/skins/psos+/init.c
+++ b/src/skins/psos+/init.c
@@ -20,7 +20,7 @@
 #include <errno.h>
 #include <sys/mman.h>
 #include <psos+/psos.h>
-#include <asm/xenomai/bits/bind.h>
+#include <asm-generic/xenomai/bits/bind.h>

 int __psos_muxid = -1;

diff --git a/src/skins/rtdm/init.c b/src/skins/rtdm/init.c
index dbbcbb1..9672486 100644
--- a/src/skins/rtdm/init.c
+++ b/src/skins/rtdm/init.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <rtdm/syscall.h>
-#include <asm/xenomai/bits/bind.h>
+#include <asm-generic/xenomai/bits/bind.h>

 int __rtdm_muxid = -1;

diff --git a/src/skins/uitron/init.c b/src/skins/uitron/init.c
index a6cc77f..0ffc8bd 100644
--- a/src/skins/uitron/init.c
+++ b/src/skins/uitron/init.c
@@ -20,7 +20,7 @@
 #include <errno.h>
 #include <sys/mman.h>
 #include <uitron/uitron.h>
-#include <asm/xenomai/bits/bind.h>
+#include <asm-generic/xenomai/bits/bind.h>

 int __uitron_muxid = -1;

diff --git a/src/skins/vrtx/init.c b/src/skins/vrtx/init.c
index 8a81660..d3d6cdb 100644
--- a/src/skins/vrtx/init.c
+++ b/src/skins/vrtx/init.c
@@ -23,7 +23,7 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <vrtx/vrtx.h>
-#include <asm/xenomai/bits/bind.h>
+#include <asm-generic/xenomai/bits/bind.h>

 int __vrtx_muxid = -1;

diff --git a/src/skins/vxworks/init.c b/src/skins/vxworks/init.c
index 181b575..b2cdad4 100644
--- a/src/skins/vxworks/init.c
+++ b/src/skins/vxworks/init.c
@@ -23,7 +23,7 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <vxworks/vxworks.h>
-#include <asm/xenomai/bits/bind.h>
+#include <asm-generic/xenomai/bits/bind.h>

 int __vxworks_muxid = -1;



-- 
                                                                Gilles.

