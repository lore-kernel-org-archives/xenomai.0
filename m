Message-ID: <4A688232.6040403@domain.hid>
Date: Thu, 23 Jul 2009 17:30:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.62.0907231644270.9450@domain.hid>
In-Reply-To: <Pine.LNX.4.62.0907231644270.9450@domain.hid>
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
Cc: xenomai@xenomai.org

Kolja Waschk wrote:
> Hi,
> 
> As a newcomer to Xenomai, I was until now successfully experimenting
> with the native skin. Now that it comes to run an existing application
> that is written for POSIX threads, a few problems show up. The
> pthread_mutex_lock() _always_ returns 1 (EPERM) to me, although there
> are no forks involved and policy should have been to SCHED_FIFO.

Setting the policy to SCHED_FIFO is not necessary. However, your thread 
initialization has several defects:
- it does not check the return values of the function it calls, so you 
do not see the errors which follow
- setinheritsched(1) does not mean anything (and actually, it would seem 
it means the contrary of what you would like, but I can not say for 
sure), you should use the constants PTHREAD_EXPLICIT_SCHED or 
PTHREAD_INHERIT_SCHED
- setting the priority to anything else than 0 in the thread creation 
attributes only works once you have set the scheduling policy (at least 
it did a long time ago with linuxthreads, and I guess you are using 
linuxthreads).

> 
> If that's of interest, I'm developing for a Blackfin uClinux (NOMMU)
> target with newest uClinux-dist snapshot (Kernel
> 2.6.30.2-ADI-2010R1-pre, Xenomai 2.4.91, Nucleus v2.5-rc2) with FDPIC
> userland. For building,  I simply used

Yes, that is of interest, because I do not think we experience this 
issue on other platforms.

> 
>> bfin-linux-uclibc-gcc `/usr/xenomai/bin/xeno-config --posix-cflags`
>>   `/usr/xenomai/bin/xeno-config --posix-ldflags`  try.c -o try
> 
> Writing an explicit command line including the -Wl,@(wrapper) etc.
> doesn't change anything.  The output of the attached code, compiled,
> shows the return value from mutex_lock, first called from the NRT
> main(), then from a thread that IMHO should run as a realtime thread:

main is a real-time thread. All threads are real-time threads, whatever 
the scheduling policy you use. The only way to create a non real-time 
thread is to call __real_pthread_create.

So, in short, your example should work, everyone should return 0. There 
is a bug somewhere.

-- 
                                           Gilles


