Message-ID: <4600125A.6000304@domain.hid>
Date: Tue, 20 Mar 2007 17:56:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1174379951.5068.5.camel@domain.hid> <46000AFE.9070504@domain.hid>
In-Reply-To: <46000AFE.9070504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Xenomai v2.3.1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bill Gatliff <bgat@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Bill Gatliff wrote:
> Guys:
> 
> Philippe Gerum wrote:
> 
>>	[posix]
>>	* Fix pthread_cond_wait() upon signal receipt (grab mutex anew).
>>  
> 
> 
> Probably OT, but someone was complaining to me the other day that 
> pthreads running on SCHED_FIFO/SCHED_RR that are blocked on mutexes 
> don't release in priority order.  This was on a stock 2.6.18 kernel, 
> "recent glibc" (I didn't catch which version or config), ARM9 platform.
> 
> First question: Is this actually true?
> 
> Second question: Does Xenomai fix this?  Do more recent kernel 
> developments fix this?
> 
> Point me at the appropriate RTFM or code if that's the appropriate 
> answer.  :)

The appropriate RTFM is the POSIX spec [1]

In short, it says: "If there are threads blocked on the mutex object
referenced by 'mutex' when pthread_mutex_unlock() is called, resulting
in the mutex becoming available, the scheduling policy shall determine
which thread shall acquire the mutex."

So, the correct implementation is to release a mutex in priority order.

I think the glibc implements this correctly (at least NPTL), on the
other hand, I believe it is not true for threads running with the
SCHED_OTHER policy, in order to prevent starvation.

Xenomai POSIX skin implements this correctly as well. To be more
specific about this, Xenomai mutexes, like mutexes of all other skins,
are built using the "xnsynch_t" objects [2] which has two possible ways
of implementing its internal wait queue: either in FIFO order if
xnsynch_init is passed the XNSYNCH_FIFO flag, or in priority order if
xnsynch_init is passed the XNSYNCH_PRIO flag. pthread_mutex_init passes
the XNSYNCH_PRIO flag to xnsynch_init.

[1]:http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_lock.html
[2]:http://www.xenomai.org/documentation/trunk/html/api/group__synch.html
-- 
                                                 Gilles Chanteperdrix

