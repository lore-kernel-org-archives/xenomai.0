Message-ID: <49363D9C.7010201@domain.hid>
Date: Wed, 03 Dec 2008 09:04:44 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid> <49330CD3.4090700@domain.hid>
	<4933BAE2.3000502@domain.hid> <4933F1A4.8060209@domain.hid>
	<4933F18F.7080103@domain.hid>
In-Reply-To: <4933F18F.7080103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
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
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> Gilles Chanteperdrix wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Wolfgang Grandegger wrote:
>>>>> Hello,
>>>>>
>>>>> I have written the attached test program to cancel Xenomai POSIX
>>>>> threads. The "calc_task" does some busy work, which the higher priority
>>>>> task "ctrl_task" interrupts and aborts after some time. The program does
>>>>> not behave like I expect and it also behaves differently on my PowerPC
>>>>> and ARM test system. The "calc_task" continues after calling
>>>>> pthread_cancel() in "ctrl_task". On ARM, the behaviour is even more
>>>>> wired. Is there anything wrong in my test program or anything else I
>>>>> should care of?
>>>> First, you should know that PTHREAD_CANCEL_ASYNCHRONOUS is evil, it will
>>>> almost inevitably leave things in an unknown state when canceling a
>>>> thread, you would better use PTHREAD_CANCEL_DEFERRED and ensure that
>>>> your thread has some cancellation point, if it has not, use
>>>> pthread_testcancel.
>>>>
>>>> Second, your program will only work if root thread priority coupling is
>>>> enabled. Is it enabled in your case?
>>> Actually, even with priority coupling I am not sure it can not work. The
>>> problem is the way do_sigwake_event signal threads: it make them switch
>>> to secondary mode only if they pass through a syscall. Since the
>>> "calc_task" thread does not issue any syscall, it will never check see
>>> that it should relax to handle the cancelation signal.
>> calc_task() calls clock_gettime() permanently, which does a syscall as
>> long as vDSO is not used, which might be the case on PowerPC. This would
>> explain why cancelation of "calc_task" works on ARM.
> 
> For architectures with a high-resolution counter,
> clock_gettime(CLOCK_MONOTONIC) is a xenomai service which uses the
> counter and does not issue any syscall, this includes arm unless you
> configured xenomai with --enable-arm-arch=generic or with
> --disable-arm-tsc, and this probably includes powerpc.
> 

clock_gettime() is wrapped to __wrap_clock_gettime(), which does a syscall:

http://www.rts.uni-hannover.de/xenomai/lxr/source/src/skins/posix/clock.c?v=SVN-trunk#058

Have I missed something?

Wolfgang.

