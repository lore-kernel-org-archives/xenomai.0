Message-ID: <43786C64.1050404@domain.hid>
Date: Mon, 14 Nov 2005 11:52:20 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] printk
References: <OF1D0CCC98.82E4D674-ONC12570B6.003B9ABD-C12570B6.003D16B7@domain.hid>
In-Reply-To: <OF1D0CCC98.82E4D674-ONC12570B6.003B9ABD-C12570B6.003D16B7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:

>
> xenomai-help-bounces@domain.hid wrote on 11.11.2005 10:30:26:
>
> > Hi,
> >
> > I'm porting an app from RTAI to Xenomai, and when it came to the
> > rt_printk function, I had to replace it with plain printk (the
> > xnarch_log* functions all use printk).
> >
> > What I want to know if:
> >
> > 1- Is totally safe to call the standard kernel printk function from a
> > real time task?
>
> Actually, the adeos/ipipe patches make some changes to the vanilla
> kernel's printk() mechanism.
>
> There are 2 possible modes of printk() being issued from the primary
> domain.
>
> 1) asynchronous:
>
> all data is written into the protected buffer and the
> __ipipe_printk_virq virq is risen for the secondary domain. So the
> data will be printed out when the linux gets control next time.
>
> Although, here is, well, a tiny race because of the fact that the virq
> handler doesn't lock a buffer-related data (like __ipipe_printk_fill)
> so a loss of data may occur under some circumstances.
>
> 2) synchronous (IPIPE_SPRINTK_FLAG)
>
> in this case, a normal linux vprintk() call is issued. Oops, this one,
> in turn, calls spin_lock_irqsave(&logbuf_lock, flags); in real-time
> context and that lock may be already held by a preempted non-rt task
> on the same CPU.
>
> Houston? :o)
>
(2) is unacceptable. Losing some data would be acceptable if it is
caused by too much printk output, but not because of a race condition.
This should be fixed. I guess a simple FIFO with proper locking should
be in place. printk would discard data only if there is no space left.

>
> >
> > 2- Even if it's safe, can it affect the performance of a real time task?
> > (or can it block under *any* conceivable condition?)
>
> It gives some overhead since data must be copied to the buffer and at
> that time the interrupts are off.
> Blocked? No, if not taking into account a possible "hang up" with the
> synchronous mode (ok, as always there is still a hope that I can be
> wrong ):)
>
If you are right, then it's unacceptable. An RT task would be blocked by
a non-RT task.

>
> >
> > Thanks.
> >
> > Nacho.
> >
>
> ---
> Best regards,
> Dmitry
>
>------------------------------------------------------------------------
>
>No virus found in this incoming message.
>Checked by AVG Free Edition.
>Version: 7.1.362 / Virus Database: 267.13.0/167 - Release Date: 11/11/2005
>  
>


