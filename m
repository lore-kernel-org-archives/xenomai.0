From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <464331CF.3090505@domain.hid>
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>
	<4641CD8B.8050309@domain.hid>
	<7289437c0705090643gc9f0ddax6fa6cff44895c9ed@domain.hid>
	<7289437c0705090735n58b4a0fbm7e31c8571efb7514@domain.hid>
	<17986.12574.488256.997900@domain.hid>
	<17986.15326.243315.427529@domain.hid>
	<1178748178.11688.45.camel@domain.hid>
	<17986.20728.617772.991566@domain.hid>
	<1178784303.11688.108.camel@domain.hid>  <4642D901.9050304@domain.hid>
	<1178789171.11688.142.camel@domain.hid>  <4642E706.7000500@domain.hid>
	<1178808027.11688.150.camel@domain.hid>  <464331CF.3090505@domain.hid>
Content-Type: text/plain
Date: Thu, 10 May 2007 17:21:34 +0200
Message-Id: <1178810494.11688.188.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
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
Cc: xenomai@xenomai.org

On Thu, 2007-05-10 at 16:53 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Thu, 2007-05-10 at 11:33 +0200, Gilles Chanteperdrix wrote:
> > 
> >>Philippe Gerum wrote:
> >>>xnfreesafe was meant to prevent the caller from releasing some memory it
> >>>could still rely on, e.g. stack space, by postponing the actual release
> >>>until the idle thread is resumed. In your case, the problem is that it
> >>>does not account for the primary/secondary mode of a shadow thread.
> >>
> >>I am not so sure. I mean, even if the thread was deleted from the
> >>context of another thread, the two hooks would be invoked and we would
> >>need the free operation to be deferred until after the execution of the
> >>second hook.
> >>
> > 
> > 
> > The point is that deletion hooks are always called on behalf of the
> > exiting thread in secondary mode, so if xnfreesafe properly identifies
> > the caller as the current thread - regardless of its exec mode - then
> > the deferral should always take place. But I agree on the fact that we
> > should always end up running the deferred call in this context anyway,
> > so we would be better off calling xnheap_schedule_free() directly.
> 
> That is why, since xnfreesafe was only called in this precise context, I
> redefined it to call xnheap_schedule_free directly.
> 

Well, ok. But we may need the xnfreesafe() interface in the future, the
way it was designed initially, I mean. So let's call
xnheap_schedule_free directly when needed.

-- 
Philippe.



