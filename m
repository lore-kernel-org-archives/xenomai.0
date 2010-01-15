Message-ID: <4B50BAF4.9070604@domain.hid>
Date: Fri, 15 Jan 2010 19:59:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <245373446233674495BCA5CA2FC1EB1733A1170AF7@domain.hid>
	<4B50B2C4.1020904@domain.hid>
In-Reply-To: <4B50B2C4.1020904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Calling native API in user-space signal handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Andreas Glatz <AndreasGlatz@domain.hid>

Gilles Chanteperdrix wrote:
> Andreas Glatz wrote:
>> Hi,
>>
>> I wrote my on SIGSEGV signal handler which gathers information about
>> the fault and passes that info to a separate process for
>> post-processing.
>>
>> I'm wondering if it's always save to call native API functions in a
>> signal handler?
>>
>> (As according to man 7 signal', it's just save to call a subset of
>> Glibc functions from within a signal handler.)
> 
> It is definitely not safe to assume that you may call any function in a
> signal handler.
> 
> Calling pthread_mutex_lock in a signal handler can cause a multithreaded
> application to deadlock for instance (if the preempted code was also in
> the middle of a pthread_mutex_lock), so that calling the apparently
> inocuous printf might deadlock.
> 
> Now, for the Xenomai services. You can in fact call any function whose
> implementation is in fact a simple syscall. If a function does more than
> simply emitting a syscall, then all bets are off. And of course, we can
> not guarantee you that a function which is emitting a syscall now will
> not get more complicated in later releases.
> 
> Another safe solution is to use the "ptrace" syscall, the one used by
> gdb, instead of installing a handler for SIGSEGV. Granted, this will
> become a bit more completely, but should be more safe.
> 
> Or enable generation of core files.
> 

While it is true that one should be very careful with invoking services
from signal handler, for the debugging case SIGSEGV, printing, writing
to files, or even some diagnostic Xenomai native services will work in
(almost) all practical cases.

We have such handlers in the (test) field, and they did not cause
troubles so far though they call tons of unsafe services. Of course they
would lock up if the crash happened while holding some of the locks
acquired during print-out as well. But normally things crash elsewhere...

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

