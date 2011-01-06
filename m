Message-ID: <4D26286F.1060309@domain.hid>
Date: Thu, 06 Jan 2011 21:39:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <12d5cebd852.gprizzi@domain.hid>
In-Reply-To: <12d5cebd852.gprizzi@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error in executing xenomai tests
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "gprizzi@domain.hid" <gprizzi@domain.hid>
Cc: xenomai@xenomai.org

gprizzi@domain.hid wrote:
> Looking at the worst case of a latency of about 20 us with a task at 2 KHz
> I can estimate 2*10^-3 * 20 * 10 ^-6 = 40 * 10^-3 sec lost for latency in 1 sec..
> In the average case I will have 5*10^-3 sec. lost for latency in 1 sec. 
> 
> I think that these percentage can be accepted in a robotic position control,
> what do you think about these assumption?
> 
> Can you suggest me a better way to evaluate the latency with respect of robotic 
> position control system or can you suggest me some useful articles to read about this topic?

There is this piece of meat between your ears called a brain. Do not you
think, that, at some point, you will have to do what you are paid for
and use it?

Suppose that you have one acquisition, one one actuation, and some
real-time task between the two. If you know that the maximum allowed
time between the two is R, the worst case execution time of the
real-time task is W. Then the maximum wake up latency your system should
be able to provide is around R - W, or (R - W) / 2 if you want to play
it safe.

Of course, that was just a very sample example. And the problem you are
trying to solve may define other constraints. But that is the spirit.

In other words, I can not tell you whether 20us or 40us, or 80us is
enough for the system you are trying to build. I do not know.

Your problem is not about tuning Xenomai or preempt_rt. As far as
Xenomai is concerned, once it is installed, there are only a few things
you need to tune, and you will know when you need it. For instance, you
could start by tuning /proc/xenomai/latency so that the latency test
does not return negative values. But this is not your priority IMO.

> and I had a look at 
> 
> https://rt.wiki.kernel.org/index.php/Frequently_Asked_Questions
> 
> Do you think that setting CONFIG_PREEMT=y instead of 
> CONFIG_PREEMPT_VOLUNTARY=y
> will significantly reduce latency?

No, I was suggesting using the preempt_rt patch instead of Xenomai,
which is another way of having a deterministic operating system. With
this patch, there is no point in using CONFIG_PREEMPT or
CONFIG_PREEMPT_VOLUNTARY. The point is to use CONFIG_PREEMPT_RT.

Since you do not strike me as a co-kernel programming expert, chances
are that if preempt_rt is sufficient for the requirements of your system
and stable enough on your system, developing the application you have to
develop will be much less painful.

-- 
					    Gilles.

