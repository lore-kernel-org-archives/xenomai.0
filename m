Message-ID: <51E43DA3.3090800@xenomai.org>
Date: Mon, 15 Jul 2013 20:21:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmty3tu1DMtObXnQ5oNkJOJoOyprOp5BQJ5YZtoiYaYqWA@mail.gmail.com>
In-Reply-To: <CANKLDmty3tu1DMtObXnQ5oNkJOJoOyprOp5BQJ5YZtoiYaYqWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i.MX Timer Tick stall on iMX6Solo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: xenomai@xenomai.org

On 07/15/2013 05:48 PM, Henri Roosen wrote:

> Hi all,
>
> I'm running on a iMX6Solo (singlecore) chip. The problem we are seeing is
> that a couple of times during the day, the i.MX Timer Tick irq doesn't
> trigger and after some time starts running again. So the reprogramming of
> the timer is suspect ;-)


That is a documented issue with timers of the type "free-running + match 
register", it means yes, that the timer was programmed for a too short 
delay, and that you had wait for it to wrap to finally tick.

>
> I'm using ipipe-3.0-imx6q and Xenomai 2.6.2.1.
>
> Can anyone help me to make the timer reprogramming robust? Is there a
> robust way to do that (instead of adding a factor to the mxc_min_delay like
> commit-e1c0a1461512f does)? All help or pointers are highly appreciated!


The robust solution is the solution used by the commit you cite: use the 
"next_event" callback return value to manually trigger a timer irq.
Unfortunately, this increases the number of timer registers access, and 
so the timer programming latency. But I agree that it is a better solution.

Regards.

-- 
                                                                 Gilles.

