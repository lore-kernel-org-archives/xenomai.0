From: "Daniel Merrill" <daniel.merrill@psware.com>
References: <a61ffb56.00001e48.00000008@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
	<52337BA2.4080106@xenomai.org>
	<fcac2f91.00001e70.00000001@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
	<86e45894.00001e70.0000000c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
	<52338808.4060404@xenomai.org>
In-Reply-To: <52338808.4060404@xenomai.org>
Date: Fri, 13 Sep 2013 16:23:05 -0700 (MST)
Message-ID: <024b1d5a.00001e70.00000015@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai] psos t_delete causing a SIGSEGV in suspended task.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Friday, September 13, 2013 2:48 PM
To: Daniel Merrill
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] psos t_delete causing a SIGSEGV in suspended task.

On 09/13/2013 11:45 PM, Daniel Merrill wrote:
> Ok, good catch :) that was a stupid mistake I made while trying to
> condense the problem down to a more manageable size. Which apparently
> when I do it works, so I'm obviously not understanding the real issue
> here. So much for trying to look smart. How about a stack trace from the 
> real issue.
>
> #0  0xb7d474f6 in __gnat_is_handled_by_others ()
>    from /usr/lib/i386-linux-gnu/libgnat-4.6.so.1
> #1  0xb7ec4822 in __gnat_personality_v0 () from
> /usr/lib/i386-linux-gnu/libgnat-4.6.so.1
> #2  0xb7c65056 in ?? () from /lib/i386-linux-gnu/libgcc_s.so.1
> #3  0xb7c65448 in _Unwind_ForcedUnwind () from
> /lib/i386-linux-gnu/libgcc_s.so.1
> #4  0xb7f788c2 in _Unwind_ForcedUnwind () from
> /lib/i386-linux-gnu/libpthread.so.0
> #5  0xb7f76381 in __pthread_unwind () from
> /lib/i386-linux-gnu/libpthread.so.0
> #6  0xb7f6e5eb in sigcancel_handler () from
> /lib/i386-linux-gnu/libpthread.so.0
> #7  <signal handler called>
> #8  0xb7fdd424 in __kernel_vsyscall ()
> #9  0xb7fd7541 in t_suspend () from /usr/lib/libpsos.so.0
>
> As soon as we call t_delete on the suspended task, we see this issue
> popping up. Any ideas?

Well, the program goes south when trying to unwind after pthread_cancel.
Maybe C++ code compiled with -fno-exceptions ?


-- 
                                                                Gilles.
Alright I think you solved it! We are actually calling the t_suspend from 
Ada, which had an exception block around the call. For some reason that is 
trying to catch the cancel signal and causes the SIGSEGV. When I remove that 
exception handling block the delete appears to work. Thanks for pointing me 
in the right direction.

Dan Merrill

