Date: Tue, 28 Feb 2006 07:13:30 -0800
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C029A89A.2576%steve@domain.hid>
In-Reply-To: <440467F3.7020903@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

It seems to me that the RTOS should just stop accruing overruns for any
suspended thread. What's the point of even allowing it to stay on the old
timeline? This algorithm, albeit implemented in kernel modules with classic
RTAI, never had an issue.

Well, everything works now with new set_periodic calls, so I guess we can
all be happy now.

Steven

On 2/28/06 7:10 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> Steven Seeger wrote:
>> Every other RTOS I've ever used would disagree with you. However, I can wrap
> 
> set_periodic/wait_period are used to define a timeline, with a base period
> dedicated to process a bounded work cycle. If your application decides to kill
> the 
> timeline by skipping work cycles voluntarily in order to process e.g. error
> states 
> or interactive break, it needs to reset the timeline by calling set_periodic
> anew, 
> which seems quite reasonable to do, since the old timeline is now dead in the
> water. If this is not some error recovery work or break state, but regular
> processing, then it should fit in the normal work cycle, otherwise there is no
> point in using set_periodic/wait_period to time it in the first place.
> 
> Beyond that, comparing with other RTOS behaviours does not fly that well,
> because 
> some which actually implement this kind of construct might well raise an
> exception 
> to some health manager entity for signaling the overrun (e.g. arinc653), in
> which 
> case, one would end up having to hack the error handler so that it swallows
> those 
> exceptions silently, for the interesting purpose of making a valid case out of
> an 
> error case...
> 
> We could pass rt_task_wait_period() a pointer to an integer that would collect
> the 
> count of overruns, and reset this count after the first overrun has been
> signaled. 
> But this would not fix the initial problem in the application, though.
> 


