From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45CCEB58.8020103@domain.hid>
References: <45CCEB58.8020103@domain.hid>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 23:55:34 +0100
Message-Id: <1171061734.25642.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: xnpod_suspend_thread and past absolute timeouts
Reply-To: rpm@xenomai.org
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

On Fri, 2007-02-09 at 22:44 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> RTnet revealed a problem of rtdm_task_sleep_until in trunk. When being
> called with a past date, it blocks forever because xnpod_suspend_thread
> considers such timeouts as infinite:
> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c?v=SVN-trunk#1456
> 
> Are there users relying on this property of xnpod_suspend_thread? If
> yes, I would unfortunately have to catch this case in RTDM.

It's recent since this can only happen with absolute timeouts, and I
merged this feature at the beginning of the 2.4 cycle, so nobody should
be relying on this yet. We are in the grey area here, what POSIX would
call "unspecified behaviour"; choosing one option (error and unblock) or
another (infinite wait) is still possible, but once we do it, it has to
be written in stone and documented as such.

Infinite wait is obviously trivial to implement (guess why I choose it),
but unblocking is logically better since there is no way to guarantee
that a test in the caller would still apply in the callee's context,
especially when using the master time base, for which stopping the
interrupt flow won't stop the monotonic time. Ok, ok, will fight against
procrastination and change this.

> 
> Jan
> 
-- 
Philippe.



