Subject: Re: [Xenomai-help] Xenomai & Elinos
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D35F15.6060600@domain.hid>
References: <1299EF3181B10F479D85C3280132852422DAE1@domain.hid>
	<44D35F15.6060600@domain.hid>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 17:31:42 +0200
Message-Id: <1154705502.4326.29.camel@domain.hid>
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
Cc: xenomai@xenomai.org, GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>

On Fri, 2006-08-04 at 16:52 +0200, Jan Kiszka wrote:
> GUARDIOLA-FALCO Sebastien 204282 wrote:
> > Hello,
> > 
> > I believe some people wanted to know which version of Xenomai is currently supported by ElinOS (Sysgo).
> > This is the 2.0.4, patched to a 2.6.15 kernel, but I'm only talking about PowerPC archs (don't know others).
> 
> Thanks for the info. Yeah, I meanwhile read this as well in some
> publicly available data sheet. Just the precise patch level remained
> unclear.
> 
> What did they patched, only I-pipe? What I-pipe version is the patch
> based on?
> 
> > What can I expect of this Xenomai version? what has been mostly improved since then?
> 
> See the ChangeLog of a recent Xenomai version... :)
> 
> A lot of stuff has improved since then, e.g. the performance
> enhancements due to pipeline head optimisation or the shared IRQ
> support. And I bet that a few recent bug fixes are missing in the 2.0
> series as well (one may correct me, it's a subjective impression). The
> same may be true for the I-pipe patch.
> 

2.0.x is in deep maintenance mode, which means that only real
showstoppers are fixed when there is no work-around, and only for
subsystems which were complete and not work-in-progress at the time of
the initial 2.0 release. IOW, no optimization, no ahead of bug report
fixes, no new architecture support, no new interfaces, no documentation
update, just plain brown paper-bag bug fixes if any.

2.0.x can use any of the recent I-pipe patches, but won't benefit from
the recent optimizations they bring, like wired interrupt support,
though.

> It would be really a pity if they have patches of common interest for
> Xenomai/I-pipe, even if only for 2.0.x, and did not posted them yet...
> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



