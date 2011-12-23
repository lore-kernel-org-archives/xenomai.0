Date: Fri, 23 Dec 2011 12:33:09 -0500
Message-ID: <20111223173309.GM27742@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: lsorense@domain.hid (Lennart Sorensen)
Subject: [Xenomai-core] CONFIG_XENO_HW_UNLOCKED_SWITCH=y causes random
 process corruption in xenomai 2.6.0 on powerpc.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

After spending quite a while trying to explain how things like /bin/echo
could possibly segfault, I finally discovered that the new feature in
xenomai 2.6.0 (new when moving from 2.4.10 that is) of having preemptible
context switches is what is corrupting the state of random linux processes
once in a while.

After turning the option off, I haven't seen a single crash just like 2.4.10.

So something subtle is wrong with this option.

It appears to be most likely to occour (possibly only likely) when
xenomai is handling interrupts.

It seems that getting an interrupt in the middle of a context switch at
the wrong time corrupts the process that is being switched to or from
(no idea which it is).

Unless someone can think of a way to track down and fix this I would
certainly suggest making the option off by default instead of on.

With CONFIG_XENO_HW_UNLOCKED_SWITCH=n I don't have any problems anymore.

-- 
Len Sorensen

