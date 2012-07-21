Message-ID: <500A9681.8040904@xenomai.org>
Date: Sat, 21 Jul 2012 13:46:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdjPVbTmUMRgXYuH_9y0Gjrcqa-KvLQWPzo2EA+x0t13Q@mail.gmail.com>	<5009A63A.3090100@xenomai.org>
	<CAKKWdteQafmdxO0=GKnJQJog3YibNxo5_Uequ7VVL3b3cK6Scw@mail.gmail.com>
In-Reply-To: <CAKKWdteQafmdxO0=GKnJQJog3YibNxo5_Uequ7VVL3b3cK6Scw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: periodic system timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: Xenomai@xenomai.org

On 07/21/2012 01:01 PM, ali hagigat wrote:
> 1) Can i use native-skin functions and POSIX-skin functions together
> in one user space program?

Yes. You should be able to mix all skins together. There may be some
services reserved to threads created by one skin, for instance
"rt_task_inquire" only makes sense for a task created by the native
skin. But the service will return an error in the case where you try to
call it for a posix skin thread or a vxworks skin thread.

> 
> 2) I had a questions about skin timers and you answered it:
> 
> "and if a skin request periodic mode, a software
> timer is started to provide the skin timebase. So, if each skin has a
> different period, each skin will get a tick at the period it
> requested."
> 
> What does it mean when you say each skin will get a tick? Getting a
> tick means that a hardware timer interrupt happens?

Getting a tick means that the skin "tick handler" gets called
periodically, indeed in the context of a hardware interrupt.

> Each skin gets a tick means when a function of that skin is called?
> So when that function returns it will not get that tick?

No, the tick handler gets called periodically, whether or not a function
of that skin is called.

> As far as i understood the effect of these soft timers are seen for
> some functions of a skin and the effect is based on that function. Is
> a soft timer able to effect and change the next shot time of the
> underlying hardware timer?( I think the answer is yes!)

A "soft timer" is what you get when using for instance the posix
services timer_create, timer_settime. The operating system manages to
trigger this soft timer handler at the time you asked. How the OS
manages to do that is really irrelevant to you, you program the soft
timer, and the OS manages the hardware timer.

What happens in the case of xenomai when you use a skin in periodic mode
is that you get two layers.

The first layer is a set of timers one of which is the skin tick timer.
The system manages to program the hardware timer to expire at the date
of the earliest timer expiration date in the set, and of course
reprograms the hardware timer every time the set changes, which means
when a timer is added and when a timer is removed. When the (periodic)
skin tick timer expires, it is removed from the list, so the hardware
timer needs to be reprogrammed to the next timer expiration date, its
handler is called, its expiration date is incremented, and it is
re-added to the list, the hardware timer is reprogrammed if this
periodic timer is now the next which should expire. (the implementation
avoids the useless first timer programming, but this is irrelevant).

Now, the second layer is a second set of timers: the skin timers. These
timers are either created directly by the application using timer
services such as timer_create/timer_settime or indirectly by using timed
services such as nanosleep or pthread_cond_timedwait. This second layer
works much like the first layer: the timers are handled in a set ordered
by expiration date, the difference is however, that the expiration dates
are aligned on ticks dates.

This means a much worse resolution, so, as I already said, you probably
have no reason to use the skins periodic mode, unless you are using the
skin to port an application which was written for an OS originally with
a periodic timer.

Please no top-posting.

-- 
                                                                Gilles.

