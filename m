MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17571.51019.423857.591502@domain.hid>
Date: Thu, 29 Jun 2006 14:27:55 +0200
Subject: Re: [Xenomai-core] Prio-inversion on cleanup?
In-Reply-To: <44A39C3C.1080508@domain.hid>
References: <44A1608B.3090605@domain.hid> <44A295ED.2080306@domain.hid>
	<44A39C3C.1080508@domain.hid>
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
 > (..)
 > Now I wonder how to resolve this, how to make pthread_setschedparam (a
 > rather central RT-service) really real-time safe? I would say we need
 > something like a lazy schedparam propagation to Linux which only takes
 > place when the thread enters secondary mode intentionally or no other RT
 > thread is ready. But I do not have a design for this at hand. Nasty.

A simple solution is to wrap pthread_getschedparam as well. It would
fallback to __real_pthread_getschedparam when the xenomai posix skin
syscall returns -ESRCH. This would allow to remove the offending call to
__real_pthread_setschedparam in __wrap_pthread_setschedparam.

 > 
 > [My preferred way for every setup != CONFIG_PREEMPT_RT + CONFIG_XENOMAI
 > would still be to switch this prio-inheritance off for the root thread.
 > But this was nack'ed by Philippe several times before... ;)]
 > 
 > Side note: the native skin does not seem to suffer from this effect as
 > it only tracks the current prio at Xenomai level.
 > 
 > Jan
 > 
 > 
 > PS: Gilles, what about marking those services of the POSIX in the doc
 > that may issue a linux syscall (and under which conditions)?

Actually, syscalls that may be called only from a particular context or
that cause migration of their caller have a paragraph entitled "Valid
contexts", if pthread_setschedparam lack this paragraph, it is probably
because its implementation changed without its documentation.

-- 


					    Gilles Chanteperdrix.

