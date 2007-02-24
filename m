Subject: Re: [Xenomai-core] x86_64 - Initial results.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702241526.22786.paul_c@domain.hid>
References: <200702241526.22786.paul_c@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 16:56:11 +0100
Message-Id: <1172332571.2161.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2007-02-24 at 15:26 +0000, Paul wrote:
> Hi Philippe
> 
>  First off, thanks for all your hard work and late nights (and the rest of the 
> team) for the x86_64.
> 
>  Initial results look promising with the latency test reporting figures in the 
> 0.5 to 4 uSec range under light load. A kernel compile bumps the wost up to 
> 9-14uSec.

Not bad. Is this a UP or SMP config, and which kind of box did run the
tests precisely?

>  Firing up X,KDE, and a gamut of desktop apps really kills the 
> numbers though - ~267uSec being the worst recorded so far,

Ok, the latter looks clearly pathological. The trace should tell us
more.

>  however, once 
> X/KDE has started up, latencies are generally <30uSec.
> 
> One small problem to report from the compile... With 
> CONFIG_XENO_OPT_NUCLEUS=m, the build fails with:
> 
> WARNING: "cpu_gdt_descr" [kernel/xenomai/nucleus/xeno_nucleus.ko] undefined!
> make[1]: *** [__modpost] Error 1
> 
> What would the preferred solution be - Export cpu_gdt_descr as it is with 
> i386, or force xeno_nucleus to be built in ?
> 

We can export it, it's already a global symbol anyway. I've now added
the proper EXPORT_SYMBOL_GPL in my local repo. Thanks for pointing this
out.

> 
> Regards, Paul.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



