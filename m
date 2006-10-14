From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451E378F.5030305@domain.hid>
References: <4516F0D1.3010800@domain.hid>
	<1159135692.4971.68.camel@domain.hid>  <451E378F.5030305@domain.hid>
Content-Type: text/plain
Date: Sat, 14 Oct 2006 23:35:26 +0200
Message-Id: <1160861726.5151.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] Re:
	adeos-ipipe-2.6.18-ppc-1.4-00.patch, first version
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

On Sat, 2006-09-30 at 11:23 +0200, Wolfgang Grandegger wrote:
> Hi Philippe,
> 
> Philippe Gerum wrote:
> > On Sun, 2006-09-24 at 22:55 +0200, Wolfgang Grandegger wrote:
> >> Hi Philippe,
> >>
> >> attached you will find a first version of the PPC ADEOS-IPipe patch for 
> >> Linux 2.6.18 (from kernel.org) for review. I have also included a 
> >> commented log file with more information on the porting of 
> >> adeos-ipipe-2.6.14-ppc-1.4-00 to Linux 2.6.18. It works with a recent 
> >> version of Xenomai.
> >>
> > 
> > Thanks, at first sight, this looks good. I don't see any obvious problem
> > in the tracer code either. Anyway, I will play with it asap.
> > 
> >> The patch currently only supports devices in the "arch/ppc" tree with 
> >> the option "CONFIG_PPC_MERGE" not set. Porting the "arch/powerpc" tree 
> >> requires further effort and I need a test system as well. Puh, let's 
> >> hope that the merge ppc -> powerpc will be completed soon.
> >>
> >> The idle loop is not yet working for 6xx and I have disabled it for
> >> this reason (check arch/powerpc/kernel/idle.c). It needs further
> >> debugging. I hope to find more time beginning of October.
> > 
> > Ok, thanks. Btw, returning from NAP on 6xx is done through an exception,
> > right? If so, maybe we have a problem with this particular
> > exception/interrupt branching directly to transfer_to_handler_full (i.e.
> > the vanilla way) without being known from the Adeos pipeline, albeit it
> > should? (red blinking warning: this is just a wild guess).
> 
> Attached is a revised patch including a fix for remaining problem in the 
> 6xx idle loop mentioned above. The bug was here (diff to old patch):

Merged, thanks.

-- 
Philippe.



