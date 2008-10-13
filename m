Message-ID: <48F33543.6070303@domain.hid>
Date: Mon, 13 Oct 2008 13:47:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Fast mutexes vs. automatic mode switch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

while preparing my reworked fast mutex patches for submission, reviewing
them once again, I realized a conception problem that the fast path can
introduce: So far every pthread_mutex_lock or rt_mutex_acquire forced
the caller into primary mode in case it was in secondary before. Now
this will only happen if the mutex is contended!

Let's consider the fairly typical use case of a two threads
synchronizing a critical section with the help of a mutex. One thread is
high-prio, always in primary mode, the other is low-prio, constantly
transiting between primary (while holding the lock) and secondary (while
interacting with Linux). If the low-prio acquires the uncontended lock,
it will now remain in secondary mode thanks to the new mutex fast path.
That means if the high-prio requests the lock as well, prio-inheritance
will no longer work as the owner is not in the right mode!

I guess what we need is mode detection for the caller in the mutex fast
path. If the possible new owner is in secondary mode, the syscall path
needs to be taken to trigger a migration reliably. That in turn means we
need a syscall-less detection of the current execution mode. Any
spontaneous ideas on this?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

