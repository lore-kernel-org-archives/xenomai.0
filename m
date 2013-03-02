Message-ID: <51319119.9020000@xenomai.org>
Date: Sat, 02 Mar 2013 06:41:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAJjOJyZWM-73DoTOAT4Xoiw3dk-yUw7Gu4ZOU9D9_b4qe5N-QQ@mail.gmail.com>
In-Reply-To: <CAJjOJyZWM-73DoTOAT4Xoiw3dk-yUw7Gu4ZOU9D9_b4qe5N-QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem Handling GPIO interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jonathan Wallace <jonmon6691@gmail.com>
Cc: xenomai@xenomai.org

On 03/02/2013 05:47 AM, Jonathan Wallace wrote:

> Hi all,
> 
> I'm trying to get a small variation of the usr_irq.c example working,
> but rt_intr_wait keeps returning -38 without blocking and perror
> prints success. If I don't let it print anything (so it will run


Sorry for the empty reply. The native skin does not use errno, so,
perror will not print anything, rt_intr_wait return value has to be
considered the error itself.

-38 is -ENOSYS, meaning that the kernel does not implement the function.

Indeed, handling interrupts in user-space is deprecated, for this
reason, support is disabled by default in Xenomai kernel.

In order to add support for the rt_intr_* services, you have to enable
CONFIG_XENO_OPT_NATIVE_INTR
in the kernel configuration.


> faster) it seg faults after about 4 or 5 seconds, calling rt_intr_wait
> in an infinite loop during that time.
> 
> I'm also having an issue where if I run the program from an SSH
> session, rt_task_create returns EPERM, but will return a success if I
> run the program from the serial console. I can only assume there's
> some difference in the shell processes at the kernel level, but if
> there's a way to get around this, I would love to know too.


I do not know if this is related, but Xenomai services are by default
only available to the "root" user, so, if you are not loging with ssh as
root user, what you observe is normal. If not, then what you observe is
a new bug. Maybe ssh restrict some capabilities even when logging at root?



> 
> A little background about the IRQ, because I could have this all wrong
> too... I exported a gpio pin and echoed "falling" into the edge file
> in sysfs. This added an entry in /procs/interrupts "205:         42
>   GPIO  gpiolib" The number 42, increments every time I press my
> button to cause an physical interrupt on the pin so I know its at
> least working up to that point. I used this number 205 as the argument
> to rt_intr_create, but I'm not sure that was the right thing to do.


This should probably work. You may have to run rt_intr_enable after
rt_intr_create though.

-- 

                                                                Gilles.

