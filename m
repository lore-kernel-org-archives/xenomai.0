From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D74B93.9070905@domain.hid>
References: <44CF6EB1.1010808@domain.hid> <44D36389.3030706@domain.hid>
	<44D4A0E4.5070703@domain.hid> <44D4CAE9.9000800@domain.hid>
	<44D4E38D.9060007@domain.hid> <44D4FF53.8000904@domain.hid>
	<44D74B93.9070905@domain.hid>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 16:32:55 +0200
Message-Id: <1154961175.4322.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] [ANNOUNCE] RTDM driver for CAN
	devices
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Mon, 2006-08-07 at 16:17 +0200, Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
> > Wolfgang Grandegger wrote:
> >>>>> - Well known issue: the RTCAN name. This should definitely get resolved
> >>>>> before we merge. Any feedback already?
> >>>> I contacted the author. If I will not get an answer soon, I tend
> >>>> changing the global name to RT-Socket-CAN (rtsocketcan).
> >>> I would really hate to have a drivers/rtsocketcan or a
> >>> rtdm/rtsocketcan.h. The short name is so much nicer.
> >> He did not say, that we cannot use the name RTCAN but he prefers that we
> >> use a different name to avoid confusion. Therefore I suggest to use the
> >> offical name "RT-Socket-CAN" for the project, but leave almost all
> >> internal rtcan prefixes as they are apart from:
> >>
> >>   drivers/rtsocketcan
> >>   rtdm/rtsocketcan.h
> >>
> >> Note that the API does use the Linux naming in most cases (with the
> >> prefix can).
> >>
> >> Another possibility would be to use rtscan as short form for rtsocketcan
> >> as prefix.
> >>
> >> What do you think? Well, it's just a name.
> > 
> > Never underestimate naming. Ok, I have this proposal now:
> > 
> >  o drivers/can/ - That's consistent with the existing subdir naming
> >    anyway.
> > 
> >  o rtdm/rtcan.h - The "rtdm/" prefix clearly defines the context: It's
> >    THE standard real-time CAN profile for RTDM.
> > 
> >  o All references to "RTCAN" in comments, READMEs, headers, etc. must be
> >    changed to RT-Socket-CAN. So it should be clear that this has nothing
> >    to do with the existing "rtcan" project.
> > 
> >  o Variable, type, and function names remain as they are.
> > 
> > Jan
> > 
> > 
> > PS: Another point for the long-term to-do list :-> : The nested locking
> > and the global scope of certain locks. It's safe, it's harmless for
> > current primary target platforms (UP), but it's not really beautiful
> > when considering SMP setups. A bit tricky, for sure.
> 
> I just realized another issue. Where to put README and CREDITS file? The 
> README should go into doc/txt/can-driver.txt.

Would be nice.

>  Should I add the credits 
> to this file as well?

Why not, but please also add an entry to the central CREDITS file, so
that maintainers are easily identified.

> 
> Wolfgang.
> 
> 
-- 
Philippe.



