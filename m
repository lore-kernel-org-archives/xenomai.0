From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Message-ID: <17644.18211.766628.941569@domain.hid>
Date: Wed, 23 Aug 2006 14:16:35 +0200
Subject: Re: [Xenomai-help] how to port to xenomai
In-Reply-To: <1299EF3181B10F479D85C3280132852422DAF5@domain.hid>
References: <44DC3C82.3060704@domain.hid>
	<1299EF3181B10F479D85C3280132852422DAF5@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>
Cc: xenomai@xenomai.org

GUARDIOLA-FALCO Sebastien 204282 wrote:
 > Hi,
 > 
 > I'm trying to understand the better way to port my linux program to xenomai.
 > It has only one linux syscall : mmap(). To emulate this call, can I use native or posix skin? and how can I do (xxx_mmap()?)?

You already asked this question for the posix skin, and I already
answered: when compiling for Xenomai, you need to use 
xeno-config --posix-cflags 
to get the compilation flags, and 
xeno-config --posix-ldflags 
to get the link-stage flags. All functions listed in
src/skins/posix/posix.wrappers are wrapped, but you may still access the
real ones by prefixing their name with __real. For example, in order to
access the real pthread_mutex_lock call instead of the Xenomai one, use
__real_pthread_mutex_lock in your code. About the mmap call, use mmap in
your code and it should work.

Now about the design of your applications, I already mentioned
it, but I think using polling with Xenomai is broken by design. The
reason is that Xenomai only works correctly if Linux works correctly,
which only happens if you let Linux run from time to time. So, if your
application is designed to use polling, you will have to forcibly
suspend the polling thread from time to time (for example by a call to
nanosleep), so your worst case latency will be the suspension time,
because the worst case will happen when the event for which you are
polling happens just at the time when you suspend the polling
thread. So, using interrupts to start polling for some time is a design
that will give lower latencies. Now the next question is: how do I use
interrupts with Xenomai ?

Xenomai posix and native skin allow you to use interrupts in
user-space. This is good for getting rapidly an application that works,
but if you are writing an application that you will have to maintain, it
is a better idea to use interrupts in kernel-space with the RTDM skin.

 > Do I have to set task mode to primary after this call?



 > 
 > The second issue of my code is to handle/modify task priority. In fact, I want to set maximum priority for the task. How do you do this with Xenomai?

If you go the posix way, then the call that will set the priority of a
task is pthread_setschedparam().

Doc here:
http://www.xenomai.org/documentation/trunk/html/api/group__posix__sched.html#ga4

 > 
 > Thanks a lot,
 > 
 > S~bastien Guardiola Falco.
 > 
 > _______________________________________________
 > Xenomai-help mailing list
 > Xenomai-help@domain.hid
 > https://mail.gna.org/listinfo/xenomai-help


-- 


					    Gilles Chanteperdrix.

