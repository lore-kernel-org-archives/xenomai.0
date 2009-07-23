Message-ID: <4A68A3F5.1000705@domain.hid>
Date: Thu, 23 Jul 2009 19:55:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.62.0907231644270.9450@domain.hid>
	<4A688232.6040403@domain.hid>
	<Pine.LNX.4.62.0907231741280.9450@domain.hid>
In-Reply-To: <Pine.LNX.4.62.0907231741280.9450@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] POSIX skin,
	simple example with mutex not working...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

Kolja Waschk wrote:
> Gilles,
> 
> thanks for the prompt answer. Yes, the code is not certainly not useful as a
> skeleton for building anything else...
> 
>> initialization has several defects:
>> - setinheritsched(1) does not mean anything (and actually, it would seem it
> 
> I copied it literally from the examples/posix/satch.c after I tried the
> PTHREAD_* macros, hoping that it might workaround a definition mismatch.
> 
>> main is a real-time thread. All threads are real-time threads, whatever the 
>> scheduling policy you use. The only way to create a non real-time thread is 
>> to call __real_pthread_create.
> 
> Ah, I took that guess about main() not being realtime from some old
> conversation in Xenomai-help. Thanks for clarification.
> 
> https://mail.gna.org/public/xenomai-help/2006-06/msg00001.html
> 
>> So, in short, your example should work, everyone should return 0. There is a 
>> bug somewhere.
> 
> Fortunately, there's already an OS abstraction layer in the application,
> so it doesn't take long to replace POSIX mutex/sem/thread code with
> Xenomai native API calls, and this way it seems to work. Hm, I assume
> that mixing POSIX and native API calls is no good idea, or - for testing
> - is it safe to (e.g.) use POSIX calls for thread management and native
> API for mutexes? What about using POSIX clock_*() and native rt_mutex*
> side by side?

There is no real problem mixing the two APIs. For clock functions, 
rt_timer_tsc has less overhead than clock_*. Of course, if you use 
timeouts with rt_mutex, these can not be struct timespecs, you must 
recompose the 64 bits value.

However, I really think we whould fix this issue. Not having access to a 
blackfin, I will check if the error happens on my boxes, I think it does 
not happen, but there could be a recent regression. Also, do you observe 
the issue with a stable release of xenomai such as xenomai 2.4.8 ?

-- 
                                           Gilles


