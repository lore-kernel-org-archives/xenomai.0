Subject: Re: [Xenomai-core] My work on Xenomai integration to LTTng / LTTV
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45478914.4030309@domain.hid>
References: <1162302832.3687.12.camel@domain.hid>
	<45478914.4030309@domain.hid>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 07:07:03 +0100
Message-Id: <1162361224.4983.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: jean-olivier.villemure@domain.hid, xenomai@xenomai.org

On Tue, 2006-10-31 at 18:34 +0100, Jan Kiszka wrote:
> Jean-Olivier Villemure wrote:
> > 
> > The next step will be to generate some statistics, for this step I will
> > need your help. As Xenomai users, which kind of stats would you want to
> > compute?
> 
>  - CPU usage (see /proc/xenomai/stat for average numbers, but we should
>    now be able to precisely calculate them for a specific period)
>  - Waiting times after activation (maybe one can define deadlines later
>    and verify them)
>  - Number of preemptions per second or whatever while a task is runnable
>  - Number of blockades a task faces due to unavailable resources
>    (mutexes, semaphores, etc.)

- Average number of elements linked to the readyq per second (some kind
of loadavg for us, i.e. answers the question "should the user switch to
the scalable scheduler?")
- Average number of outstanding timers per second (i.e. answers the
question "should the user switch to the binary heap-based timer
management?").
- Total number of timers missing their wakeup date from more than a
given threshold.
- Pressure on the system heap (average and max, probably).
- Transfer rate on message pipes (i.e. nucleus/pipe.c); at some point,
it would be interesting to extend this to skins exposing data channels
(e.g. native API's queues, POSIX mqueues).

-- 
Philippe.



