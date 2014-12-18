MIME-Version: 1.0
In-Reply-To: <5492989C.9070106@siemens.com>
References: <CAMJ=MEdh-vBm1S9cHL7Hj0Ky-RaeGCSw_xauMZoEsuegbArM1w@mail.gmail.com>
 <CAMJ=MEfDQm_ymyL8FULhqMvpwzet4aHMbQFoEjL-sVDsCTg2Hg@mail.gmail.com>
 <549072DC.1030901@xenomai.org>
 <CAMJ=MEfzrJQGYKT41F2hSirn8q0MGt-kWuT2GYQE7YTbSCNG5A@mail.gmail.com>
 <549090FA.7000901@xenomai.org>
 <CAMJ=MEc9UXa4P18kNmPeKH-SziXMj9Grbxagj7Wm_MckHcOC7Q@mail.gmail.com>
 <5492989C.9070106@siemens.com>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Thu, 18 Dec 2014 13:28:42 +0100
Message-ID: <CAMJ=MEeWPyBFBbjj7_JLENZQ+xBkxbaKGiZBehKCatVa-1owqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Dec 18, 2014 at 10:04 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2014-12-18 09:00, Ronny Meeus wrote:
>>>
>>> A release of the glibc that fixes this issue. I must admit that I did
>>> not track this problem lately. Jan likely knows better here.
>>>
>>
>> Jan,
>>
>> what version glibc solves the priority inversion issue on conditional variables?
>> I already tried the glibc 2.18 but the issue is still there.
>
> The bug is still not fixed, and discussion stalled again, see
> https://sourceware.org/bugzilla/show_bug.cgi?id=11588
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux

Philippe, Jan

as long as this issue is not fixed in glibc, it is not OK to use
conditional variables
in application space for real-time applications in my opinion.

Since the pSOS skin uses conditional variables to implement events and realtime
priority threads to implement pSOS tasks, it is by definition broken
and not useable
for any real application.

For example the internal-timer server, sending events to lower priority tasks,
will be blocked until all middle prio tasks have completed. We have seen
massive load consumed by the internal-timer server due to this.
What happens is that the timer thread is blocked on the mutex currently owned
by an thread running at normal (lower) priority. Every time a Linux
timer expires,
a signal is sent to the timer-server which will wake-up the task,
return to the c-library
which will re-invoke the futex call. In case a high number of timers
is used, the overhead
of this can be large. Since the timer-server is running at the highest
priority (-100) we
see all kinds of strange crashes.

The same priority inversion is true for our own drivers since they are
running at
high prio as well.

Has the replacement of these conditional variables by some other POSIX mechanism
(like mutexes) ever been considered?

Ronny

