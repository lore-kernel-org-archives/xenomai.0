Message-ID: <4D359506.6090907@domain.hid>
Date: Tue, 18 Jan 2011 14:26:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=w67oJVc+iwJdN3znbje0PMiEcjtEUic3xMcNj@domain.hid>	
	<4D3561A5.6000804@domain.hid> <4D35635A.4040403@domain.hid>
	<1295347610.1857.74.camel@domain.hid>
In-Reply-To: <1295347610.1857.74.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] segfault sharing mutex from kernel space to user
	space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
> On Tue, 2011-01-18 at 10:54 +0100, Jan Kiszka wrote:
>> On 2011-01-18 10:47, Jan Kiszka wrote:
>>> On 2011-01-17 21:15, Jeff Weber wrote:
>>>> I get a segfault when attempting to rt_mutex_acquire a mutex created in
>>>> kernel space.  I've reduced the issue to the following sample code.
>>>> Help finding my mistake is appreciated.
>>>>
>>>> TIA,
>>>> Jeff
>>>>
>>>>
>>>> Kernel space Code:
>>>> #include <linux/module.h>
>>>> #include <linux/init.h>
>>>> #include <native/mutex.h>
>>>> #include "testAPI.h"  /* defines MTXNAME */
>>>>
>>>> #define MODNAME  "XenoTest"
>>>>
>>>> static RT_MUTEX sMtx;
>>>>
>>>> static int __init mymodule_init(void)
>>>> {
>>>>     int status;
>>>>
>>>>     status = rt_mutex_create(&sMtx, MTXNAME);
>>>>     if (status) {
>>>>     printk ("rt_mutex_create: %d\n", status);
>>>>         return 1;
>>>>     }
>>>>
>>>>     printk ("loaded module %s\n", MODNAME);
>>>>     return 0;
>>>> }
>>>>
>>>> static void __exit mymodule_exit(void)
>>>> {
>>>>     rt_mutex_delete(&sMtx);
>>>>
>>>>     printk ("unloaded module %s\n", MODNAME);
>>>>     return;
>>>> }
>>>>
>>>> module_init(mymodule_init);
>>>> module_exit(mymodule_exit);
>>>>
>>>> MODULE_LICENSE("GPL");
>>>>
>>>>
>>>>
>>>> User space Code:
>>>> #include <stdio.h>
>>>> #include <sys/mman.h>
>>>> #include <native/mutex.h>
>>>> #include <native/task.h>
>>>>
>>>> #include "testAPI.h"    /* defines MTXNAME */
>>>>
>>>> #define PRIO    0
>>>> #define MODE    0
>>>>
>>>> int main(void)
>>>> {
>>>>     RT_MUTEX mtx;
>>>>     RT_TASK  tsk;
>>>>     RT_MUTEX_INFO info;
>>>>     int status;
>>>>
>>>>     mlockall(MCL_CURRENT|MCL_FUTURE);
>>>>
>>>>     status = rt_task_shadow(&tsk, NULL, PRIO, MODE);
>>>>     if (status) {
>>>>         fprintf(stderr, "rt_task_shadow: %d\n", status);
>>>>         return 1;
>>>>     }
>>>>
>>>>     status = rt_mutex_bind(&mtx, MTXNAME, TM_INFINITE);
>>>>     if (status) {
>>>>         fprintf(stderr, "rt_mutex_bind: %d\n", status);
>>>>         return 1;
>>>>     }
>>>>
>>>>     status = rt_mutex_inquire(&mtx, &info);
>>>>     if (status) {
>>>>         fprintf(stderr, "rt_mutex_inquire: %d\n", status);
>>>>         return 1;
>>>>     }
>>>>
>>>>     status = rt_mutex_acquire(&mtx, TM_INFINITE); /* SEGFAULT HERE! */
>>>>     if (status) {
>>>>         fprintf(stderr, "rt_mutex_acquire: %d\n", status);
>>>>         return 1;
>>>>     }
>>>>
>>>>     status = rt_mutex_release(&mtx);
>>>>     if (status) {
>>>>         fprintf(stderr, "rt_mutex_release: %d\n", status);
>>>>         return 1;
>>>>     }
>>>>
>>>>     printf("test success\n");   // back to primary mode
>>>>     return 0;
>>>> }
>>>>
>>>> my kernel
>>>>
>>>> backtrace:
>>>> Program terminated with signal 11, Segmentation fault.
>>>> #0  0xb770077a in xnarch_atomic_cmpxchg (v=0xb777ac00, old=0, newval=21)
>>>>     at ../../../src/include/asm/xenomai/atomic.h:95
>>>> 95              __asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
>>>> (gdb) bt full
>>>> #0  0xb770077a in xnarch_atomic_cmpxchg (v=0xb777ac00, old=0, newval=21)
>>>>     at ../../../src/include/asm/xenomai/atomic.h:95
>>>>         ptr = 0xb777ac00
>>>>         prev = 4294967295
>>>> #1  0xb7700815 in xnsynch_fast_acquire (fastlock=0xb777ac00, new_ownerh=21)
>>>>     at ../../../include/nucleus/synch.h:52
>>>>         lock_state = 3077595124
>>>> #2  0xb7700c3a in rt_mutex_acquire_inner (mutex=0xbfecd690, timeout=0,
>>>>     mode=XN_RELATIVE) at mutex.c:83
>>>>         err = 134513420
>>>>         cur = 21
>>>> #3  0xb7700e01 in rt_mutex_acquire (mutex=0xbfecd690, timeout=0) at
>>>> mutex.c:129
>>>> No locals.
>>>> #4  0x0804884a in main () at uspace.c:38
>>>>         mtx = {opaque = 19, fastlock = 0xb777ac00, lockcnt = 0}
>>>>         tsk = {opaque = 21, opaque2 = 3075921616}
>>>>         info = {locked = 0, nwaiters = 0,
>>>>           name = "TestMtx\000\000\000\060\000@domain.hid%", '\000'
>>>> <repeats 12 times>,
>>>>           owner =
>>>> "\000\000\000\000\364\036\331\336\020\037\331\336\365Pd\340\005\005UU\000\037\331\336\000\000\000\000\023\000\000"}
>>>>         status = 0
>>>>
>>>> my config:
>>>> arch: x86
>>>> linux: 2.6.35.10
>>>> xenomai: 2.5.5.2
>>>>
>>>> BTW: I did a checkout of git tag v2.5.5.2, and XENO_VERSION_STRING is
>>>> "2.5.5.1"
>>>>
>>> A) In-kernel use of the Xenomai skins is deprecated, and mixing user and
>>> kernel space use won't make it easier for you to overcome this in your
>>> system.
>>>
>>> B) If you actually depend on a shared mutex (I would really recommend to
>>> revalidate that need), you must create it in user space so that it gains
>>> a user space compatible fastlock.
>> Hmm, which just turned out to be impossible as rt_mutex_bind is only for
>> user space.
>>
>> /me is now really unsure if we should fix it (beyond catching &
>> reporting the invalid setup). Designing applications like this points
>> out several potential technical and legal issues. Other opinions?
> 
> No, I agree. The __in-kernel__ native API is almost dead  (not the one
> used from user-space obviously) and will be gone for Xenomai 3.x. We
> don't need to pile up doomed code over dead code.
> 
> But we really want to prevent such usage over 2.x, because it seems to
> be leading to memory corruption. I can reproduce a similar issue here on
> x86_64, which is silenced when moving the RT_MUTEX_INFO buffer, and I
> don't think rt_mutex_inquire() has any memory overwrite issue.

If I agree that the in-kernel native API is deprecated. If we look at
it, we see that the rt_mutex_create implementation was made much more
complicated than, for instance, the one of the posix skin one which
allows Jeff's case to work correctly. I have to admit that I am puzzled
as to why such complication.

-- 
                                                                Gilles.

