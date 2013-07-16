MIME-Version: 1.0
In-Reply-To: <51E43DA3.3090800@xenomai.org>
References: <CANKLDmty3tu1DMtObXnQ5oNkJOJoOyprOp5BQJ5YZtoiYaYqWA@mail.gmail.com>
	<51E43DA3.3090800@xenomai.org>
Date: Tue, 16 Jul 2013 09:01:00 +0200
Message-ID: <CANKLDms-pK7aKYGgbL9g0RYi1PoE90+5vwx5VovoqEMwTr_gxw@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] i.MX Timer Tick stall on iMX6Solo
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

On Mon, Jul 15, 2013 at 8:21 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 07/15/2013 05:48 PM, Henri Roosen wrote:
>
>  Hi all,
>>
>> I'm running on a iMX6Solo (singlecore) chip. The problem we are seeing is
>> that a couple of times during the day, the i.MX Timer Tick irq doesn't
>> trigger and after some time starts running again. So the reprogramming of
>> the timer is suspect ;-)
>>
>
>
> That is a documented issue with timers of the type "free-running + match
> register", it means yes, that the timer was programmed for a too short
> delay, and that you had wait for it to wrap to finally tick.
>
>
>
>> I'm using ipipe-3.0-imx6q and Xenomai 2.6.2.1.
>>
>> Can anyone help me to make the timer reprogramming robust? Is there a
>> robust way to do that (instead of adding a factor to the mxc_min_delay
>> like
>> commit-e1c0a1461512f does)? All help or pointers are highly appreciated!
>>
>
>
> The robust solution is the solution used by the commit you cite: use the
> "next_event" callback return value to manually trigger a timer irq.
> Unfortunately, this increases the number of timer registers access, and so
> the timer programming latency. But I agree that it is a better solution.
>
>
Gilles, thanks for your reply! I think there is a misunderstanding about my
referral to commit-e1c0a1461512f: this commit is already in the code I use
(ipipe-3.0-imx6q). So the robust way should be implemented already, however
it still fails to program the timer in time every once in a while.

Actually I was referring to the commit because it added a factor of 2 to
the mxc_min_delay. I don't know why this factor of 2, Was it added 'just to
be sure'?

I'm trying to find a solution that solves the reprogramming of the timer so
that it always is programmed in time. Do you have a suggestion for
calculating the correct mxc_min_delay?

Or would you know a way around this mxc_min_delay?

Thanks!



> Regards.
>
> --
>                                                                 Gilles.
>
