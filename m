Message-ID: <4EF1AB03.5030202@domain.hid>
Date: Wed, 21 Dec 2011 10:46:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAJZRki8mr5M2mtZbTD2H3WAGCJDpzjBA-KPxXgoPuufCHKu+qg@domain.hid>
In-Reply-To: <CAJZRki8mr5M2mtZbTD2H3WAGCJDpzjBA-KPxXgoPuufCHKu+qg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] nanosleep not returning
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Phil Mitchell <p.mitch@domain.hid>
Cc: xenomai@xenomai.org

On 12/20/2011 11:07 PM, Phil Mitchell wrote:
> Hello,
> 
> I am having a problem with code never returning from the nanosleep
> function call. I have 3 pthreads running, the threads all
> have nanosleeps before executing their main looping task. The
> program runs fine for hours and I can kill it and start it again
> without issue. However, occasionally I enter a state where my 3
> threads are all waiting on nanosleep.
> 
> Once this nanosleep problem occurs then the only way to fix it is
> to reboot the system. Then everything works ok again.
> 
> The exact sleep times are 1, 1 and 60 seconds. If I look at
> /proc/xenomai/sched when in the failed state I can see that instead
> of counting down from 1 second to zero they are all counting down
> from ~250msec down to ~zero and then back to ~250msec again. I can
> even see that the 60 second delay initially goes down to ~zero and
> then it keeps restarting from ~250msec. It seems like nanosleep
> is correctly counting down to ~zero, never exits and then starts
> again with a ~250msec delay.
> 
> If I debug the code (GDB) when in this strange state nothing seems out
> of place, all the time values passed into nanosleep look correct. The
> function is called once and never returns.
> 
> I am running Xenomai-2.5.5.2 with a 2.6.34.5 Kernel and using
> a dual core Atom processor.
> 
> The latency program works correctly giving ~6usecs results prior to
> encountering this problem and afterwards it stalls at  "warming up".
> 
> root@domain.hid# ./latency
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> ^C---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|   6250.000|      0.000|  -6250.000|       0|     0|    00:00:06/00:00:06
> root@domain.hid#
> 
> Please let me know if anyone has suggestions.

Could you test if you have the same issue with 2.5.6? When this happens,
do you see with the "date" command if the timer is stopped? What about
/proc/xenomai/timer? Is there no message in the kernel logs?

-- 
					    Gilles.

