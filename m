Message-ID: <48BBD8E4.6010702@domain.hid>
Date: Mon, 01 Sep 2008 13:58:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid> <48BBAB67.90707@domain.hid>
In-Reply-To: <48BBAB67.90707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/9] Switch to handle-based fast mutex
 owners
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
> kernel/user-shared mutex. Finally it ensures that all skins (except for
> RTDM which must not mess around with foreign skins anyway) add their
> threads to the registry so that at least anonymous handles are
> available.
> 
> As the value stored in the mutex variable is now an integer, we can
> switch over to xnarch_atomic_t, removing all atomic_intptr users.

The current implementation allows RTDM threads to use POSIX skin
mutexes. I do not see why this should change.

-- 
                                                 Gilles.

