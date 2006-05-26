From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.2-rc2
Date: Fri, 26 May 2006 19:44:18 +0200
References: <446F852B.7090400@domain.hid>
	<200605240721.24897.niklaus.giger@domain.hid>
	<17527.11352.471153.316802@domain.hid>
In-Reply-To: <17527.11352.471153.316802@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261944.18514.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Am Freitag, 26. Mai 2006 18:27 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
<..>
>  > Where does the simulator get this configuration from? Can it be changed
>  > to run tests in periodic and aperiodic mode?
>
> The nucleus look for the parameter "tick_arg". Over kernel-space, this
> parameter is a module parameter; over simulator, this parameter is an
> environment variable. So, running:
> tick_arg=10000000 ./tthread
> should make the test run.
Thanks for your explanation. I will try to integrate this in the test suite.
>
>  > Would  the test be adapedt to emit a "skipping: periodic mode not
>  > configured" if it is not properly configured?
>
> An example of bit decay. This test used to be skipped over non periodic
> mode.
That is exactly the point why I try to run the buildbot. Automatic regression 
tests should catch these kind of errors.
>
> Now, it is repaired.
Thanks a lot. Such quick fixes motivate me to continue my work.

But I get now in 
http://ngiger.dyndns.org/buildbot/sim/builds/60/step-check_sim/0
the following error:
Some problems were reported in:
posix->tthread:: tthread.c:91 pthread_join(child1, &tmp) == ESRCH
tthread.c:91 pthread_join(child1, &tmp) == ESRCH

Running libtool --mode=execute gdb ./tthread I can give you the following call 
stack:
tthread.c:89 TEST passed.
tthread.c:91 pthread_join(child1, &tmp) == ESRCH

Program received signal SIGSEGV, Segmentation fault.
0x1000e81c in pse51_thread_join (thread=0x6061ff71, value_ptr=0x100f9f00) 
at ../../../ksrc/skins/posix/thread.c:409
409         if (!pse51_obj_active(thread, PSE51_THREAD_MAGIC, struct 
pse51_thread)
(gdb) info stack
#0  0x1000e81c in pse51_thread_join (thread=0x6061ff71, value_ptr=0x100f9f00) 
at ../../../ksrc/skins/posix/thread.c:409
#1  0x10006734 in root_thread (cookie=0x0) at tthread.c:91
#2  0x1000d728 in thread_trampoline (cookie=0x100d1838) 
at ../../../ksrc/skins/posix/thread.c:56
#3  0x10050f78 in mvm_thread_trampoline_kroot_ ()
#4  0x0ffd10b4 in XenoThread::trampoline_kroot_ () 
from /home/buildslave/buildbot/quick-sim/build/sim/vm/.libs/libmvm.so.2
#5  0x0ffd1150 in XenoThread::body () 
from /home/buildslave/buildbot/quick-sim/build/sim/vm/.libs/libmvm.so.2
#6  0x0ffd2c58 in MvmThread::life () 
from /home/buildslave/buildbot/quick-sim/build/sim/vm/.libs/libmvm.so.2
#7  0x0fba6ad0 in makecontext () from /lib/tls/libc.so.6
Previous frame inner to this frame (corrupt stack?)
(gdb)                                                

Do you have any clue? (Doubling the stack in vm/thread.cc didn't help.)

Best regards

-- 
Niklaus Giger

