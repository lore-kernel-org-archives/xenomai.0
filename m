Message-ID: <4FF415AB.2030503@xenomai.org>
Date: Wed, 04 Jul 2012 12:06:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>	<4FF369E5.5040007@xenomai.org>
	<CAL7_A_WYVjFhh9RuxAm1jtVp7HqakB5gEzkSt8i7XsWJNJrh=Q@mail.gmail.com>
	<4FF402AD.3020601@xenomai.org>
In-Reply-To: <4FF402AD.3020601@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai and normal linux application - Wait time with
 select() not reliable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 07/04/2012 10:45 AM, Gilles Chanteperdrix wrote:
> On 07/04/2012 10:36 AM, Jens Köhler wrote:
>> Thank you for your response Gilles. I set thread to SCHED_FIFO policy
>> with chrt command, Prio 99. But there is no improvement. Also
>> nanosleep do not help. The kernel is 2.6.26. What could be reason that
>> kernel is not restart thread when time is over?
>
> It could be that the xenomai activity, if any, is running for long
> periods of time and causing linux ticks to be delayed. As usual, it
> would help if you could provide a self-contained test-case allowing us
> to reproduce the issue.
>

/proc/xenomai/stat as well, in case the rt activity changes mode a lot.

-- 
Philippe.



