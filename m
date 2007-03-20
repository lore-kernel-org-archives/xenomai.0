Message-ID: <46001B0B.5040603@domain.hid>
Date: Tue, 20 Mar 2007 18:34:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1174379951.5068.5.camel@domain.hid> <46000AFE.9070504@domain.hid>
	<4600125A.6000304@domain.hid> <460013C8.3050003@domain.hid>
In-Reply-To: <460013C8.3050003@domain.hid>
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
> Gilles Chanteperdrix wrote:
> 
>>>Probably OT, but someone was complaining to me the other day that 
>>>pthreads running on SCHED_FIFO/SCHED_RR that are blocked on mutexes 
>>>don't release in priority order.  This was on a stock 2.6.18 kernel, 
>>>"recent glibc" (I didn't catch which version or config), ARM9 platform.
>>>
>>>First question: Is this actually true?
>>>
>>>Second question: Does Xenomai fix this?  Do more recent kernel 
>>>developments fix this?
>>>
>>>Point me at the appropriate RTFM or code if that's the appropriate 
>>>answer.  :)
>>>    
>>>
>>
>>The appropriate RTFM is the POSIX spec [1]
>>
>>In short, it says: "If there are threads blocked on the mutex object
>>referenced by 'mutex' when pthread_mutex_unlock() is called, resulting
>>in the mutex becoming available, the scheduling policy shall determine
>>which thread shall acquire the mutex."
>>
>>So, the correct implementation is to release a mutex in priority order.
>>  
>>
> 
> Right, I'm fully aware of that (I teach a class on POSIX.1b from time to
> time).
> 
> But this person insisted that things didn't work that way in a stock
> 2.6.18--- which was a complete surprise to me.  Just wondering if anyone
> here had noticed or not.
> 
> I suppose another possibility is that the "mutex" they were referring to
> was a kernel mutex used to implement blocking i/o in a driver, and not a
> userspace POSIX mutex.  But I would expect that one to behave itself too...

Yet another possibility is that the pthreads that are believed to run in
SCHED_FIFO or SCHED_RR policy are not really running with one of these
policies. There is (or was, maybe it was fixed) a bug in the glibc:
setting scheduling parameters with pthread_attr_setsched* does not work.

Don't laugh, try it an call pthread_getschedparam from the created thread.

-- 
                                                 Gilles Chanteperdrix

