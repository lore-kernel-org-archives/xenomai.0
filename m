From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17465.8101.106079.634470@domain.hid>
Date: Sun, 9 Apr 2006 16:52:21 +0200
Subject: [Xenomai-core] latency -t 1 crashes on SMP.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


I tried latency -t 1 on an SMP machines, and observed a very
reproducible crash. Most of the time, the machine locks up
completely. The rest of the time, I get :

Xenomai: suspending kernel thread e7559044 ('timerbench') at 0xb01051f2 after ex
ception #14

And the system remains runnable, but 0xb01051f2 is not a valid kernel
module text address.

The lock up does not seem to be detected by any Xenomai or Linux
debug or watchdog. Only enabling the NMI watchdog seems to
systematically produce the exception 14 instead of the lockup.

I ve tried to put a printk at the beginning of timer_task_proc outer
loop. It get printed once when getting the exception 14, and twice when
getting the lock up.

Any idea where to look ?

-- 


					    Gilles Chanteperdrix.

