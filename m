Subject: Re: [Xenomai-help] enable/disable all interrupts from user space
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45427AA3.1030607@domain.hid>
References: <200610261639.36013.jweber@domain.hid>
	<45420A72.8000700@domain.hid> <1161983506.4983.48.camel@domain.hid>
	<45427AA3.1030607@domain.hid>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 00:03:20 +0200
Message-Id: <1161986601.4983.82.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>, Jeff Weber <jweber@domain.hid>

On Fri, 2006-10-27 at 23:31 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2006-10-27 at 15:32 +0200, Jan Kiszka wrote:
> >> Jeff Weber wrote:
> >>> How do I enable/disable all interrupts (Linux and Xenomai) from user space?  
> >>> (native skin preferred)
> >> For x86:
> >>
> >> iopl(3);
> >> __asm__ __volatile__("cli/sti");
> >>
> > 
> > Gasp...
> > 
> >> Ugly hack, typical a sign that something should be moved somewhere
> >> else... (there are a few exceptions, though)
> >>
> >> We once had some discussion if we shouldn't export domain stalling
> >> features to user-space in order to support things like X-servers that
> >> currently come with such code, toasting any RT kernel. May come one day,
> >> but this will be primarily for legacy non-RT code.
> > 
> > Providing "cli" emulation to X-Servers would only make sense in order to
> > stall the Linux domain; controlling the interrupt shield dynamically
> > using the T_SHIELD bit would allow that already.
> 
> As far as I understood, the I-shield doesn't come for free. So, having
> at least an API to stall the root domain from user-space should be cheaper.
> 

The I-shield can be operated on a per-task basis, which reduces the
performance impact. Additionally, tweaking the Linux domain bit by hand
won't work: there are places in the kernel where it's purely reset. The
only way to do this sanely is to have an intermediate domain between
Xenomai and Linux that regulates the interrupt flow through it's own
stall control. IOW, like the interrupt shield does.

> > If I understand
> > correctly, we are talking about stalling the Xenomai domain too, and
> > this is a completely different story. The day we would provide such
> > "feature" as an official API, we would trigger tons of misuses of this
> > hack, a bit like we have now with the T_PRIMARY bit, a number of people
> > sprinkle over their code to control the task exec mode, which is most of
> > the time utterly sub-optimal, and automatically handled by the nucleus
> > already. IOW, I'm not convinced at all that adding such API would be the
> > right thing to do.
> 
> When it comes to *emulate* hacky RTAI APIs - I would not immediately
> refrain from considering this.

API emulation is done through a skin, in which case, I would have no
objection to see such support implemented there, since well, a skin is
aimed at emulating syntax, semantics and behaviour, including the bad
ones.

>  But I agree that this can open Pandora's
> box, and having it in the native skip could mess up a lot. Unless we
> will see a widely compatible RTAI user-space skin one day, it's probably
> better to keep status quo /wrt to non-root domain stalling.
> 

Indeed, this is my point, especially since there are other ways to
implement those operations for the purpose of porting RTAI code, without
polluting the native skin uselessly.

> > 
> > For the time being, it should be possible to write a simple kernel
> > module using either the native or RTDM API from kernel space, which
> > would handle such requests from user-space. For instance, one could use
> > rt_task_notify() from user-space to signal a helper task in a kernel
> > module that carries out the job, depending on the signal received. The
> > same goes for a trivial RTDM driver only implementing the ioctl()
> > support for the same purpose.
> 
> That still remains a hack, though now platform independent :). I would
> simply use the assembly + a big fat warning sign saying "This code needs
> serious refactoring!"

The difference is that such hack would work on any platform, and other
people having the same issue to solve could be suggested to use this
approach. Not all architectures allow to fiddle with the processor's
interrupt flag from non-privileged mode; actually, x86 is rather the
exception than the rule here.

> 
> Jan
> 
-- 
Philippe.



