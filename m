From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49C95A76.4020802@domain.hid>
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
	<49C7899F.5030306@domain.hid>
	<b131c9f0903240037q446193f5hbfdd3ade40ea2af4@domain.hid>
	<49C91B24.2020304@domain.hid>
	<b131c9f0903241437s661b9bd3v504b14f83b1b9c86@domain.hid>
	<49C95A76.4020802@domain.hid>
Content-Type: text/plain
Date: Wed, 25 Mar 2009 12:17:51 +0100
Message-Id: <1237979871.6815.69.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai LTTng support
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
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, 2009-03-24 at 23:11 +0100, Jan Kiszka wrote:
> vikesh rambaran wrote:
> >>
> >> That's the only advantage of svn over git: If you do not know a precise
> >> command for the moment, you can guess it and it will probably be right.
> >> Don't try this with git (like I did)... :)
> > 
> > 
> > Agreed, that's why i also keep the user manuals close by !
> > 
> >>>>> c) Applying the xenomai instrumentation patch from
> >>>>> [http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009]
> >>>>  to
> >>>>> the xenomai 2.4.7
> >>>>> tree using patch -p1 < "filename",  results in numerous hunks. What am
> >> i
> >>>>> doing wrong ?
> >>>> Hmm, I'm afraid the patch has to be back-ported manually. It was
> >>>> developed against the instrumentation points in trunk, 2.4.x looks a bit
> >>>> different (but you should be able to derive the adoption pattern from
> >>>> that patch).
> >>> Ok , will do so and post the updated diff
> >> Looking forward!
> >>
> > 
> > Attached is the patch created using diff. Please check and confirm if it's
> > what you had in mind.
> > Besides the trace_mark calls in the functions, a minor mod was also required
> > for the trace_mark in
> > MAJOR_FUNCTION_WRAPPER_TH
> 
> Looks consistent. Maybe we can merge it into the stable series.
> Philippe, what do you think?
> 

Looks good and does not break any user-level interface, so this should
be fine for 2.4.x as well.

> > 
> > Would have liked to create the diff using the git format that seems to
> > xenomai's standard. However, the cloned
> > git repository from git://git.kiszka.org/xenomai.git did not have a 2.4.7
> > tag, so i used the released 2.4.7 tar.bz2
> > as the reference.
> > 
> 
> Thanks, fixed. My update script was lacking some magic git svn parameter.
> 
> > 
> > Regarding building of the kernel, LTT function tracer gives a problem if
> > enabled. Build stops with the following error
> > 
> > "  CC      kernel/bounds.s
> > gcc: -pg and -fomit-frame-pointer are incompatible "
> > 
> > I deselected the feature for now.
> 
> Could you provide the corresponding .config that triggered this?
> 
> > 
> > 
> > Besides that, the kernel does boot although X + keyboard + mouse seems to
> > lock up occasionally.
> 
> Is the lockup permanent then, or does the system recover from it later?
> 
> > It does not seem to be LTTng specific, as i've noticed it with a xenomai
> > enabled kernel only as well. Will try
> > isolating the problem with a vanilla kernel soon.
> > 
> > For reference, the other LTT tools used are
> > LTT control  : ltt-control-0.62-23122008
> > LTTV          : lttv-0.12.9-29012009
> > 
> > Both obtained from  http://ltt.polymtl.ca/
> > 
> > The good news is that with the above combination, i did manage to capture a
> > trace with a xenomai application
> > running and view the information using lttv. Understanding what's happening
> > there is another story - feels like
> > information OVERLOAD :)
> 
> That's kind of normal. Maybe you want to start with looking at the
> xn_nucleus.sched_switch events - the Xenomai task switches. Hope we have
> a plugin for some LTT viewer for Xenomai tracepoints one day - but my
> current feeling that it's better to wait for the LTTV "rewrite" as
> Eclipse plugin that is promised for this year.
> 
> > 
> > Will have to spend some time getting used to the environment and features
> > before posting any more questions ...
> > 
> > 
> > Thanx for all the help
> > Vicki
> > 
> 
> Jan
> 
-- 
Philippe.



