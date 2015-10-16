Date: Fri, 16 Oct 2015 17:34:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151016153424.GQ16010@hermes.click-hack.org>
References: <56210E7E.1050606@siemens.com> <5621102C.4030902@siemens.com>
 <56211645.9090503@xenomai.org> <56211787.8090107@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56211787.8090107@siemens.com>
Subject: Re: [Xenomai] Xenomai 3: kill() to non-Xenomai PIDs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Oct 16, 2015 at 05:28:07PM +0200, Jan Kiszka wrote:
> On 2015-10-16 17:22, Philippe Gerum wrote:
> > On 10/16/2015 04:56 PM, Jan Kiszka wrote:
> >> On 2015-10-16 16:49, Jan Kiszka wrote:
> >>> Hi,
> >>>
> >>> kill() is currently handled by libcobalt such that PIDs <= 0 are
> >>> forwarded to Linux and PIDs > 0 are considered to target only Xenomai
> >>> threads. But what if the user wants to address a regular Linux task from
> >>> within a Xenomai application? Shouldn't we retry kill via the Linux path
> >>> if Xenomai's syscall reports ESRCH?
> >>>
> >>
> >> IOW:
> >>
> >> diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
> >> index aac4059..7e03301 100644
> >> --- a/lib/cobalt/signal.c
> >> +++ b/lib/cobalt/signal.c
> >> @@ -99,6 +99,10 @@ COBALT_IMPL(int, kill, (pid_t pid, int sig))
> >>  
> >>  	ret = XENOMAI_SYSCALL2(sc_cobalt_kill, pid, sig);
> >>  	if (ret) {
> >> +		/* Retry with regular kill is no RT target was found. */
> >> +		if (ret == -ESRCH)
> >> +			return __STD(kill(pid, sig));
> >> +
> >>  		errno = -ret;
> >>  		return -1;
> >>  	}
> >>
> >> Jan
> >>
> > 
> > This may break code that sends signal 0 to detect whether a rt thread
> > exists (like copperplate does), which is the reason for the lack of
> > forwarding IIRC. (ret == -ESRCH && sig) would be required to forward
> > without breaking such assumption.
> 
> That still breaks POSIX (what if the user wants to test for a non-rt
> thread, like this is possible under regular Linux?). Can't copperplate
> be changed to bypass the wrapper?

If I have understood the "xenomai 3" philosophy, is not an
application which wants to use the standard call supposed to use the
__STD prefix, or not use the wrapping at all ?

-- 
					    Gilles.
https://click-hack.org

