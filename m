Message-ID: <4933BAE2.3000502@domain.hid>
Date: Mon, 01 Dec 2008 11:22:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid> <49330CD3.4090700@domain.hid>
In-Reply-To: <49330CD3.4090700@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> I have written the attached test program to cancel Xenomai POSIX
>> threads. The "calc_task" does some busy work, which the higher priority
>> task "ctrl_task" interrupts and aborts after some time. The program does
>> not behave like I expect and it also behaves differently on my PowerPC
>> and ARM test system. The "calc_task" continues after calling
>> pthread_cancel() in "ctrl_task". On ARM, the behaviour is even more
>> wired. Is there anything wrong in my test program or anything else I
>> should care of?
> 
> First, you should know that PTHREAD_CANCEL_ASYNCHRONOUS is evil, it will
> almost inevitably leave things in an unknown state when canceling a
> thread, you would better use PTHREAD_CANCEL_DEFERRED and ensure that
> your thread has some cancellation point, if it has not, use
> pthread_testcancel.
> 
> Second, your program will only work if root thread priority coupling is
> enabled. Is it enabled in your case?

Actually, even with priority coupling I am not sure it can not work. The
problem is the way do_sigwake_event signal threads: it make them switch
to secondary mode only if they pass through a syscall. Since the
"calc_task" thread does not issue any syscall, it will never check see
that it should relax to handle the cancelation signal.

Now, the question is, do you realistically plan to write an application
which makes no syscall in its real-time loop?

-- 
                                                 Gilles.

