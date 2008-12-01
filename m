Message-ID: <4933E726.3090906@domain.hid>
Date: Mon, 01 Dec 2008 14:31:18 +0100
From: Wolfgang Grandegger <wg@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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

Actually I want to do a defined exit in case on a fatal error condition.
Normally I just would printf an error message and call exit to abort the
whole application. Things are more tricky with Xenomai. For error
logging and debugging, I'm using rt_printk() (RTDK) and I want to see
all messages till the fatal error occurred, which requires stopping all
activity/tasks of the scheduler. My idea was to cancel all non-active
tasks, wait for a few hundredth milliseconds before calling finally
exit. Maybe there is a simpler method to achieve such a defined abort.

> Second, your program will only work if root thread priority coupling is
> enabled. Is it enabled in your case?

Where can I read more about this thread priority coupling? I see
different ROOT priorities when using USE_EXPLICIT_SCHED.

Wolfgang,


