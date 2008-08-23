Message-ID: <48AFF369.2080208@domain.hid>
Date: Sat, 23 Aug 2008 13:24:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AFCB3F.6070902@domain.hid>
	<48AFE9E9.3050509@domain.hid>	<48AFEBB9.9080108@domain.hid>
	<48AFED54.6040608@domain.hid> <48AFEE5B.3050200@domain.hid>
	<48AFEF1B.8040508@domain.hid>
In-Reply-To: <48AFEF1B.8040508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Racy pse51_mutex_check_init?
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi Gilles,
>>>>>>
>>>>>> trying to understand the cb_read/write lock usage, some question came up
>>>>>> here: What prevents that the mutexq iteration in pse51_mutex_check_init
>>>>>> races against pse51_mutex_destroy_internal?
>>>>>>
>>>>>> If nothing, then I wonder if we actually have to iterate over the whole
>>>>>> queue to find out whether a given object has been initialized and
>>>>>> registered already or not. Can't this be encoded differently?
>>>>> We actually iterate over the queue only if the magic happens to be
>>>>> correct, which is not the common case.
>>>> However, there remains a race window with other threads removing other
>>>> mutex objects in parallel, changing the queue - risking a kernel oops.
>>>> And that is what worries me. It's unlikely. but possible. It's unclean.
>>> Ok. This used to be protected by the nklock. We should add the nklock again.
>> Well I do not think that anyone is rescheduling, so we could probably
>> replace the nklock with a per-kqueue xnlock.
> 
> If nklock or per queue - both will introduce O(n) at least local
> preemption blocking. That's why I was asking for an alternative
> algorithm than iterating over the whole list.

I insist:
- the loop does almost nothing, so n will have to become very large for
it to take a long time, and n is the number of mutexes allocated so far
in one application, or the number of shared mutexes, which is probably
even less.
- the loop happens if the magic happens to be good, so probably only if
you are calling pthread_mutex_init twice for the same mutex, the normal
use-case is to use memory from BSS to allocate mutex, so the magic of a
normal application calling pthread_mutex_init is always 0, and you do
not enter the loop.

Today, I consider it much more a problem that I can not call fork in a
xenomai application with opened descriptors and exit the parent
application without the file descriptors being closed in the child too.
And this will be the thing I will spend time to fix first. Using the
registry in the posix skin will only come next.

-- 
					    Gilles.

