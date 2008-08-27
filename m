Message-ID: <48B5615C.6050704@domain.hid>
Date: Wed, 27 Aug 2008 16:14:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
In-Reply-To: <48B55F7C.5030901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based fast
	mutex owners
Reply-To: gilles.chanteperdrix@xenomai.org
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
> To improve robustness of the fast mutex implementation in POSIX (and
> later on in native), it is better to track the mutex owner by handle
> instead of kernel object pointer. Therefore, this patch changes
> __xn_sys_current (xeno_set_current) so that it returns
> xnthread_handle(current_thread). It furthermore converts the POSIX mutex
> implementation to pick up and store the lock owner as handle in the
> kernel/user-shared mutex. Finally it ensures that at least POSIX threads
> always have an (anonymous) handle assigned.
> 
> As the value stored in the mutex variable is now an integer, we can
> switch over to xnarch_atomic_t, removing all atomic_intptr users.

Ok. I do not know if this should be part of this patch, or in another
one, but we should call xeno_set_current in the trampolines of all
skins, so that they can use the native and posix mutexes.

This is another thing that I have left in a state of flux...

-- 
                                                 Gilles.

