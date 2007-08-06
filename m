From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <18103.24835.247952.219162@domain.hid>
References: <a18a592b0708060815s4a1d30c0w906ff61d9acb0fab@domain.hid>
	<18103.24835.247952.219162@domain.hid>
Content-Type: text/plain
Date: Mon, 06 Aug 2007 21:27:13 +0200
Message-Id: <1186428434.5963.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] newbie question
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

On Mon, 2007-08-06 at 19:57 +0200, Gilles Chanteperdrix wrote:
> rolfetas bambolas wrote:
>  > Hi to all,
>  > I'm trying to understand how Xenomai handles priorities, and found a paper
>  > called "Life with Adeos" from 2005 which explains that tasks in secondary
>  > mode force the linux kernel to inherit the RT-Tasks priority.
>  > I also read that User-Space RT Tasks migrate to secondary mode when they
>  > make a system call to the linux-kernel, and migrate back when they use some
>  > Xenomai API.
>  > 
>  > Does this mean, that the Linux-Kernel will keep the inherited priority until
>  > the RT-Task calls again Xenomai?? what happens is a RT-Task doesn't call
>  > Xenomai for a while??
>  > I hope you understand what I mean,
>  > Thank you,
> 
> What you are referring to is the priority coupling between Xenomai and
> Linux schedulers, and can be disabled in Xenomai configuration.
> 
> The linux kernel will keep the inherited priority until the RT-task
> calls xenomai again, or until it is suspended by Linux scheduler. If the
> RT-task does not call xenomai for a while (and is not suspended by Linux
> scheduler), then, well, it is an RT-task after all and should be able to
> run until it reaches a suspension point or wakes up another RT-task.
> 
> Note however that during this time, Linux interruptions will be allowed
> to preempt the RT-task.
> 

(unless the interrupt shield is in effect).

-- 
Philippe.



