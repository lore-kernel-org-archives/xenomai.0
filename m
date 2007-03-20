Message-ID: <460013C8.3050003@domain.hid>
Date: Tue, 20 Mar 2007 12:03:04 -0500
From: Bill Gatliff <bgat@domain.hid>
MIME-Version: 1.0
References: <1174379951.5068.5.camel@domain.hid> <46000AFE.9070504@domain.hid>
	<4600125A.6000304@domain.hid>
In-Reply-To: <4600125A.6000304@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------080905010507000103040203"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080905010507000103040203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
>> Probably OT, but someone was complaining to me the other day that 
>> pthreads running on SCHED_FIFO/SCHED_RR that are blocked on mutexes 
>> don't release in priority order.  This was on a stock 2.6.18 kernel, 
>> "recent glibc" (I didn't catch which version or config), ARM9 platform.
>>
>> First question: Is this actually true?
>>
>> Second question: Does Xenomai fix this?  Do more recent kernel 
>> developments fix this?
>>
>> Point me at the appropriate RTFM or code if that's the appropriate 
>> answer.  :)
>>     
>
> The appropriate RTFM is the POSIX spec [1]
>
> In short, it says: "If there are threads blocked on the mutex object
> referenced by 'mutex' when pthread_mutex_unlock() is called, resulting
> in the mutex becoming available, the scheduling policy shall determine
> which thread shall acquire the mutex."
>
> So, the correct implementation is to release a mutex in priority order.
>   

Right, I'm fully aware of that (I teach a class on POSIX.1b from time to 
time).

But this person insisted that things didn't work that way in a stock 
2.6.18--- which was a complete surprise to me.  Just wondering if anyone 
here had noticed or not.

I suppose another possibility is that the "mutex" they were referring to 
was a kernel mutex used to implement blocking i/o in a driver, and not a 
userspace POSIX mutex.  But I would expect that one to behave itself too...

> I think the glibc implements this correctly (at least NPTL), on the
> other hand, I believe it is not true for threads running with the
> SCHED_OTHER policy, in order to prevent starvation.
>   

Right.  All bets are off with SCHED_OTHER, which is the way things are 
supposed to be.


b.g.

-- 
Bill Gatliff
bgat@domain.hid


--------------080905010507000103040203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Gilles Chanteperdrix wrote:
<blockquote cite="mid4600125A.6000304@domain.hid" type="cite">
  <blockquote type="cite">
    <pre wrap="">
Probably OT, but someone was complaining to me the other day that 
pthreads running on SCHED_FIFO/SCHED_RR that are blocked on mutexes 
don't release in priority order.  This was on a stock 2.6.18 kernel, 
"recent glibc" (I didn't catch which version or config), ARM9 platform.

First question: Is this actually true?

Second question: Does Xenomai fix this?  Do more recent kernel 
developments fix this?

Point me at the appropriate RTFM or code if that's the appropriate 
answer.  :)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The appropriate RTFM is the POSIX spec [1]

In short, it says: "If there are threads blocked on the mutex object
referenced by 'mutex' when pthread_mutex_unlock() is called, resulting
in the mutex becoming available, the scheduling policy shall determine
which thread shall acquire the mutex."

So, the correct implementation is to release a mutex in priority order.
  </pre>
</blockquote>
<br>
Right, I'm fully aware of that (I teach a class on POSIX.1b from time
to time).<br>
<br>
But this person insisted that things didn't work that way in a stock
2.6.18--- which was a complete surprise to me.&nbsp; Just wondering if
anyone here had noticed or not.<br>
<br>
I suppose another possibility is that the "mutex" they were referring
to was a kernel mutex used to implement blocking i/o in a driver, and
not a userspace POSIX mutex.&nbsp; But I would expect that one to behave
itself too...<br>
<br>
<blockquote cite="mid4600125A.6000304@domain.hid" type="cite">
  <pre wrap="">I think the glibc implements this correctly (at least NPTL), on the
other hand, I believe it is not true for threads running with the
SCHED_OTHER policy, in order to prevent starvation.
  </pre>
</blockquote>
<br>
Right.&nbsp; All bets are off with SCHED_OTHER, which is the way things are
supposed to be.<br>
<br>
<br>
b.g.<br>
<pre class="moz-signature" cols="72">-- 
Bill Gatliff
<a class="moz-txt-link-abbreviated" href="mailto:bgat@domain.hid">bgat@domain.hid</a>
</pre>
</body>
</html>

--------------080905010507000103040203--

