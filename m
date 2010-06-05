Message-ID: <4C0A49C4.8000509@domain.hid>
Date: Sat, 05 Jun 2010 14:57:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid> <4C095876.3060605@domain.hid>
	<4C099329.6000303@domain.hid>
In-Reply-To: <4C099329.6000303@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
> Gilles Chanteperdrix wrote:
>> GIT version control wrote:
>>> Module: xenomai-jki
>>> Branch: for-upstream
>>> Commit: 0352b068600bd4ef3172c8a42416badbcdad32ca
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=0352b068600bd4ef3172c8a42416badbcdad32ca
>>>
>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>> Date:   Wed Apr 28 15:08:11 2010 +0200
>>>
>>> native: Rework handling of pthread carrier thread
>>>
>>> This patch improves two pitfalls of libnative's interaction with
>>> underlying pthreads:
>>>
>>> First, it tries to detect double deletions (cancellations or joinings)
>>> of pthreads and report them via an error code. This reduces the risk to
>>> trigger a SIGSEGV accessing meanwhile released pthread objects. And
>>> second, it properly detaches joinable pthreads when they are deleted
>>> instead. This properly releases the pthread resources.
>> I really do not understand that. What is the point of creating a
>> joinable thread if you do not want to join it once it has been canceled?
>>
> 
> Keep in mind that there is no pthread_cancel equivalent in the native
> API. Moreover, even POSIX has pthread_detach so that you are not forced
> to join every joinable thread. I could imagine that one may want to use
> this fot error cleanups. But first of all this is about improving the
> API consistency and fault tolerance.

I have no strong opinion on that matter, but it looks to me like the
"joinable" stuff in the native API is made to look like the posix
equivalent, following the principle of least surprise. So, since posix
requires joining a thread after canceling, it should be necessary to
join a thread after deleting it.

As for pthread_detach, its main justification is a corner case: being
able to avoid leaks when canceling a thread which was blocked in a call
to pthread_join by calling pthread_detach in the cancelation cleanup
handler.

The reason for the way the native API is, is that you may delete a
thread which is in fact running in another process. And I am not sure
the patch you sent addresses this issue.

> 
> Jan
> 


-- 
					    Gilles.

