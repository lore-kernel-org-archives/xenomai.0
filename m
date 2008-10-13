Message-ID: <48F33AEC.9080608@domain.hid>
Date: Mon, 13 Oct 2008 14:11:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F33543.6070303@domain.hid> <48F3380B.6040503@domain.hid>
In-Reply-To: <48F3380B.6040503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fast mutexes vs. automatic mode switch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> while preparing my reworked fast mutex patches for submission, reviewing
>> them once again, I realized a conception problem that the fast path can
>> introduce: So far every pthread_mutex_lock or rt_mutex_acquire forced
>> the caller into primary mode in case it was in secondary before. Now
>> this will only happen if the mutex is contended!
> 
> Yes, I had already thought about that, and even mentioned it on the
> mailing list I believe.

Sorry, /me probably missed it.

> 
>> Let's consider the fairly typical use case of a two threads
>> synchronizing a critical section with the help of a mutex. One thread is
>> high-prio, always in primary mode, the other is low-prio, constantly
>> transiting between primary (while holding the lock) and secondary (while
>> interacting with Linux). If the low-prio acquires the uncontended lock,
>> it will now remain in secondary mode thanks to the new mutex fast path.
>> That means if the high-prio requests the lock as well, prio-inheritance
>> will no longer work as the owner is not in the right mode!
>>
>> I guess what we need is mode detection for the caller in the mutex fast
>> path. If the possible new owner is in secondary mode, the syscall path
>> needs to be taken to trigger a migration reliably. That in turn means we
>> need a syscall-less detection of the current execution mode. Any
>> spontaneous ideas on this?
> 
> Is not it even simpler for the oscillating thread to switch to primary
> mode when it accesses such a mutex? Otherwise we have kernel/user shared
>  maps, so allocating a few bytes there should be enough.

As we are already fighting hard to avoid new explicit mode-switch use
cases, rather get rid of old ones, I thought it would be better to keep
existing semantic across the fast mutex changes.

Regarding those shared maps: they are per process, aren't they? But here
we need per thread memory. I'm currently thinking of a memory piece that
the caller of xeno_set_current provides (or some service that is called
together with the latter one, or some extended services - to keep APIs
clean). Then, on mode switches, the kernel will carefully
(xn_copy_to_user) update it.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

