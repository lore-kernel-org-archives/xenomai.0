Message-ID: <5075CEBD.7060709@xenomai.org>
Date: Wed, 10 Oct 2012 21:38:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <990B36E792F1A4488D3E2B1C46FD62D6943CBA5BD8@corpmail2>
In-Reply-To: <990B36E792F1A4488D3E2B1C46FD62D6943CBA5BD8@corpmail2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai does not recognize changed system time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Pustylnik <MichaelPustylnik@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/10/2012 09:36 PM, Michael Pustylnik wrote:

> I get system time from Xenomai by calling rt_timer_inquire() and examining the 'date' field of RT_TIMER_INFO.
> After system bootup, Xenomai reports the same system time as Linux (which is expected). However, if I change Linux system time with the 'date' command, Linux starts reporting the new time, while Xenomai keeps reporting the old time, as if the system time was not changed.
> 
> Am I doing something wrong?


No.

> Is this the expected behavior?


Yes.

> How to get updated system time from Xenomai?


You have to update system time with the posix skin service clock_settime.
Or you can use CLOCK_HOST_REALTIME, but you can not use
CLOCK_HOST_REALTIME for anything else than simply getting linux time. It
can not be used as absolute dates for clock_nanosleep, or for creating
timers with timer_create.


-- 
                                                                Gilles.

