MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17528.22828.865403.975935@domain.hid>
Date: Sat, 27 May 2006 15:50:36 +0200
Subject: Re: [Xenomai-core] Xenomai v2.2-rc2
In-Reply-To: <200605261944.18514.niklaus.giger@domain.hid>
References: <446F852B.7090400@domain.hid>
	<200605240721.24897.niklaus.giger@domain.hid>
	<17527.11352.471153.316802@domain.hid>
	<200605261944.18514.niklaus.giger@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
 > posix->tthread:: tthread.c:91 pthread_join(child1, &tmp) == ESRCH
 > tthread.c:91 pthread_join(child1, &tmp) == ESRCH
 > 
 > Running libtool --mode=execute gdb ./tthread I can give you the following call 
 > stack:
 > tthread.c:89 TEST passed.
 > tthread.c:91 pthread_join(child1, &tmp) == ESRCH
 > 
 > Program received signal SIGSEGV, Segmentation fault.
 > 0x1000e81c in pse51_thread_join (thread=0x6061ff71, value_ptr=0x100f9f00) 
 > at ../../../ksrc/skins/posix/thread.c:409
 > 409         if (!pse51_obj_active(thread, PSE51_THREAD_MAGIC, struct 
 > pse51_thread)
 > (gdb) info stack
 > #0  0x1000e81c in pse51_thread_join (thread=0x6061ff71, value_ptr=0x100f9f00) 
 > at ../../../ksrc/skins/posix/thread.c:409
 > #1  0x10006734 in root_thread (cookie=0x0) at tthread.c:91
 > #2  0x1000d728 in thread_trampoline (cookie=0x100d1838) 
 > at ../../../ksrc/skins/posix/thread.c:56
 > #3  0x10050f78 in mvm_thread_trampoline_kroot_ ()
 > #4  0x0ffd10b4 in XenoThread::trampoline_kroot_ () 
 > from /home/buildslave/buildbot/quick-sim/build/sim/vm/.libs/libmvm.so.2
 > #5  0x0ffd1150 in XenoThread::body () 
 > from /home/buildslave/buildbot/quick-sim/build/sim/vm/.libs/libmvm.so.2
 > #6  0x0ffd2c58 in MvmThread::life () 
 > from /home/buildslave/buildbot/quick-sim/build/sim/vm/.libs/libmvm.so.2
 > #7  0x0fba6ad0 in makecontext () from /lib/tls/libc.so.6
 > Previous frame inner to this frame (corrupt stack?)
 > (gdb)                                                
 > 
 > Do you have any clue? (Doubling the stack in vm/thread.cc didn't help.)

This test is really questionable, it tests that pthread_join returns
ESRCH when passed a pthread_t argument that is not yet initialized. But
if the not yet initialized pthread_t value is an invalid address, it
may cause a segmentation fault. The best thing to do is to remove this
test.

-- 


					    Gilles Chanteperdrix.

