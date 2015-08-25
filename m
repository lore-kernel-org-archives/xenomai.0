Date: Tue, 25 Aug 2015 20:52:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150825185229.GA2319@hermes.click-hack.org>
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DC76C7.5040606@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55DC76C7.5040606@xenomai.org>
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Aug 25, 2015 at 04:08:07PM +0200, Philippe Gerum wrote:
> On 08/25/2015 02:13 AM, Don Mahurin wrote:
> > Hi all,
> > 
> > We would like to submit our current work on the arm64 port of
> > ipipe/xenomai. We hope that this contribution will encourage further
> > development of arm64 support in ipipe/xenomai.
> >
> 
> arm64 support is definitely a high priority item. Thanks for tackling this.
> 
> > This port was largely developed on ipipe-3.10 as a base, so it is likely to
> > be the most well tested there. Though recently, we have also ported these
> > changes to ipipe-3.14.44. ( We noticed that 3.10 is missing from rc7. Is
> > this intended, or will 3.10 support return? )
> 
> ipipe-core-3.10.32-arm-10.patch is still part of the distribution in
> -rc7. This said, the absence of a patch targeting a particular kernel
> release in a given Xenomai version does not mean the latter can't run
> over the former. This rather means that we did not check for it. Xenomai
> 3 over Cobalt requires a kernel release >= 3.10 though.
> 
> > 
> > At the end of this message are the relevant git repos and branches for the
> > arm64 port. Also included is a build script to build a minimal busybox
> > linux system which may be ran using qemu (arm64 virt).
> > 
> > 
> > Development status:
> > 
> > The 3.14 port is missing the fast-syscall changes (in entry.S) from armv7,
> > and instead contains the 3.10 entry.S changes forward ported to 3.14.
> > 
> > FPU support is incomplete.
> > 
> > Smokey tests:
> > 
> > 3.10/rc6 smokey tests all pass
> > 3.14/rc6 smokey tests all pass
> > 3.14/rc7 smokey tests sched-quota and sched-tp fail
> > 
> 
> This is likely because -rc7 has added checks to sched-* tests which have
> time-dependent results, so they may not match the expected value in a
> qemu-based execution.
> 
> > 
> > git repos:
> > 
> > https://gitlab.mperpetuo.com/it/xenomai-3.git
> > https://gitlab.mperpetuo.com/it/ipipe.git
> > https://gitlab.mperpetuo.com/it/build-scripts.git
> >
> 
> It looks like curl does not like the cypher used by this server. http is
> fine though.

I do not know if any configuration was changed, but git clone did
not complai here for the first URL.

-- 
					    Gilles.
https://click-hack.org

