Message-ID: <48D69A7A.7090302@domain.hid>
Date: Sun, 21 Sep 2008 21:03:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid> <48D620DB.2070101@domain.hid>
	<48D688EE.7010404@domain.hid> <48D68D6D.9070909@domain.hid>
In-Reply-To: <48D68D6D.9070909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
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

> [1]http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/5412/focus=5405
> 
always-put-xnthread-base-into-registry.patch:
	I understand the need, but I will cowardly let Philippe decide whether
he likes the implementation details.

handle-base-xn_sys_current-1.patch:
	In some places (pse51_mutex_timedlock_inner for instances) you use
XN_NO_HANDLE, in others (pse51_mutex_timedlock for instances) you use
NULL, are the two equivalents ? If yes, should not we always use the
same consistently ? Otherwise looks ok.

remove-xnarch_atomic_intptr.patch:
	Ok.

spread-xeno_set_current.patch:
	Ok. This is even a bug fix.

xnsynch refactoring:
	things have moved too much to see what has really changed in
xnsynch_wakeup_one_sleeper and xnsynch_sleep_on. But is not there a
common behaviour between the old and new services that could be factored
? But otherwise I agree with the general idea of the patch, this is what
we had discussed with Philippe.

-- 
					    Gilles.

