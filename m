MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17433.46842.657384.406082@domain.hid>
Date: Thu, 16 Mar 2006 20:05:30 +0100
Subject: Re: [Xenomai-core] Re: POSIX include problem
In-Reply-To: <4419A7B0.6000003@domain.hid>
References: <44195924.9090709@domain.hid>
	<17433.35726.567615.125720@domain.hid>
	<4419A7B0.6000003@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Hi Gilles,
 > >  > 
 > >  > don't know yet what's going wrong, but the following demo code doesn't
 > >  > compile against the POSIX skin due to unresolved SIG_BLOCK:
 > >  > 
 > >  > #include <pthread.h>
 > >  > #include <signal.h>
 > >  > 
 > >  > int main()
 > >  > {
 > >  >         return SIG_BLOCK;
 > >  > }
 > >  > 
 > >  > Comment out the pthread include, and it will work again. Any ideas?
 > > 
 > > Fixed in revision 714
 > > 
 > 
 > Yep, thanks.
 > 
 > I found this while trying Thomas Gleixner's cyclic test over the POSIX
 > skin (http://www.tglx.de/projects/misc/cyclictest). After fixing a
 > rather ugly bug in his code (missing mlockall) I ran into a yet unknown
 > issue with the POSIX skin: the code just hangs when wrapped to Xenomai.
 > 
 > Compilation:
 > gcc -o cyclictest cyclictest.c <posix-cflags> <posix-ldflags>
 > 
 > Invocation:
 > cyclictest -n -p 99
 > 
 > Maybe its just real-time starvation (but the watchdog doesn't trigger,
 > and I do not see why it should starve), maybe its a crash (will try to
 > attach a serial console later). Anyway, it's an easy test case (and also
 > a nice tool), so you may want to have a look as well.

A second, better guess: the created thread is not a Xenomai realtime
thread, so never suspends (Xenomai calls return EPERM when not called
from a real-time thread) and hangs. Replacing sched_setscheduler with
pthread_setschedparam should solve this issue.

I would not be surprised if, with NPTL, sched_setscheduler had an effect
on the whole process, i.e. set the priority of all the threads in the
process.

-- 


					    Gilles Chanteperdrix.

