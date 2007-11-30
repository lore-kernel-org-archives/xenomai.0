Message-ID: <47503D54.3030005@domain.hid>
Date: Fri, 30 Nov 2007 17:41:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <18252.31008.17258.994903@domain.hid>	<BF58A8AFB316514587D61EADBFBF4C410165FD36@domain.hid>
	<18252.34775.863059.743025@domain.hid>
In-Reply-To: <18252.34775.863059.743025@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Interrupts lost during sleep / unblock cycles
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

Gilles Chanteperdrix wrote:
> Kyle Howell wrote:
>  > >  > >  > I have been debugging a stall problem for a couple of 
>  > >  > > days, and I think  > I've put together enough info to check 
>  > >  > > with the pros. Everything below  > was experienced on a P4 
>  > >  > > (Celeron) running 2.6.20 / Xenomai 2.3.4. I've  > also 
>  > >  > > reproduced it on 2.6.19.7 / 2.3.1. A quick test *did not* 
>  > >  > > reproduce  > this problem on a Core2 running x86_64 2.6.22.9 
>  > >  > > / 2.4RC3. 
>  > >  > >  >
>  > >  > >  > I've reduced the problem to a fairly simple example below:
>  > >  > >  >
>  > >  > >  > The Overview:
>  > >  > >  > - Running a single real-time process with one standard 
>  > >  > > thread and one RT  > task  > - The RT task loops on a 1sec 
>  > >  > > rt_task_sleep  > - The standard thread loops on 
>  > >  > > nanosleep(10msec) and rt_task_unblock of  > the RT task.
>  > >  > >  > - When an unrelated interrupt arrives at the wrong time, 
>  > >  > > the entire  > system will hang until the 1sec task_sleep expires.
>  > >  > >  > - After resuming, everything runs normally until another 
>  > >  > > interrupt lands  > at the wrong moment.
>  > >  > > 
>  > >  > > Do you observe the same behaviour without the interrupt shield ?
>  > >  > 
>  > >  > It doesn't appear so. I'll have to let it run longer to be 
>  > > 100% sure,
>  > >  > but the usual stressing isn't causing the problem. That's 
>  > > not expected
>  > >  > behavior with the interrupt shield, is it?
>  > > 
>  > > No, it is not an expected behavior.
>  > 
>  > Well, that's good news. Still no stalls without the IShield, so that's
>  > certainly narrowed it down.
>  > 
>  > Another note: I'm currently using the IPipe 1.8-08 that is packaged with
>  > Xenomai 2.3.4. Do you expect a change if I grab 1.10-12 or 1.11-00? Are
>  > the Xenomai releases tightly coupled to a particular I-Pipe version (had
>  > problems with this in the past)?
> 
> Usually, a Xenomai version is compatible with past I-pipe releases. But
> you should expect problems using a new I-pipe release with an older
> version of Xenomai.
> 

To be more specific about this: we try really, really, really, awfully
and painfully hard to keep recent I-pipe patches compatible with
(reasonably) older Xenomai releases. No kidding. You may have noticed
that the I-pipe API has been quite stable over time for that particular
reason, and when we have to break it, there is most often some built-in
compat code.

The rule of thumb is: if the fully patched kernel compiles properly
(I-pipe + Xenomai), then this should work, for two reasons: first,
externally visible changes in some I-pipe release usually come with
wrappers to please older code, and second, we are careful in not
changing the semantics of existing calls even in subtle ways without
also forcing a syntactical change to make sure the issue is noticed
downstream, or at least provide a sane wrapper. In the former case, a
compilation error should warn you, at least.

Sometimes the generic part of the interrupt pipelining engine has to be
changed (e.g. recent "flat log" update), and this may have consequences
on the arch-dep I-pipe core interfaced with it, but in such a case,
problems have to be solved at I-pipe level, and should not leak to the
Xenomai space anyway.

In the x86 case, we have a particular situation due to mainline being
largely in a state of flux wrt some of its core layers since ages. As a
result of this:

- post-2.6.20 kernels won't work with Xenomai 2.3.x, because the Linux
clock/timer infrastructure has changed dramatically since then, in a way
that required a significant refactoring of the core Xenomai code for
x86, i.e. no wrapping possible. For this reason, there has been no
I-pipe support for 2.6.21/x86, and we directly jumped to 2.6.22/x86.
Said differently, supporting the new generic clock event layer required
significant surgery in both the I-pipe and Xenomai code.

- the latest I-pipe patch for 2.6.23/x86 broke the Adeos API,
specifically regarding the very recent ipipe_request_tickdev() service -
which depends on the above mainline change - but since you can't use
2.6.23 with Xenomai 2.3.x, this should not be a big deal for existing
production setups. OTOH, v2.4-rc7 and on will still accept older
kernels, even if you may want to run them preferably over 2.6.23 and
beyond. Other archs were not impacted since this service is only defined
for x86 for now.

- Because some people may not want to upgrade to 2.6.22+, most
improvements and fixes available with the latest I-pipe releases for
recent kernels have been backported to 2.6.20/x86. This patch will work
with both 2.3.x and 2.4 Xenomai releases. The same goes for powerpc32.

Sometimes, backward compatibility is not a sane option though. For
instance, the ipipe_tune_timer() service has been removed months
ago from newer patches with no replacement, because it put the burden of
managing periodic timing on the shoulders of the I-pipe, albeit this
should be the client code's business only. This caused hairy code to be
needed in order to port the I-pipe to other archs, with no actual
upside, since managing periodic timing is way more efficient when done
from the upper layers, e.g. Xenomai.

HTH,

-- 
Philippe.


