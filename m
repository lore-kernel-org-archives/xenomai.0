Subject: Re: [Xenomai-help] fata: removing non-linked element...
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D200C3.1030001@domain.hid>
References: <45CC651C.6060402@domain.hid> <45CC68F3.1000003@domain.hid>
	<45D1C033.9010002@domain.hid>  <45D1C61B.7030503@domain.hid>
	<1171376742.885.3.camel@domain.hid>  <45D1CAFA.6050408@domain.hid>
	<1171385716.885.17.camel@domain.hid>  <45D200C3.1030001@domain.hid>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 19:58:08 +0100
Message-Id: <1171393088.885.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
Cc: xenomai@xenomai.org

On Tue, 2007-02-13 at 19:17 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2007-02-13 at 15:28 +0100, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Tue, 2007-02-13 at 15:07 +0100, Jan Kiszka wrote:
> >>>> Stephan Zimmermann wrote:
> >>>>> I wasn't able to isolate the section of my code that causes the crash by
> >>>>> now. The only thing I figured out by now is that the particular crash
> >>>>> does not happen with 2.3.x rev 2077.
> >>>>> So I guess some change from 2077 to the 2139 revision did break something.
> >>>> Could you track the issue a bit more down? There are not to many
> >>>> "interesting" changes to 2.3.x. A few milestones I found in the ChangeLog:
> >>>>
> >>>> - 2092: Allow sleeping scheduler locks
> >>>> - 2108: Before RPI rework
> >>>>
> >>>> Anything after 2108 only makes sense to dissect when you switch on
> >>> s,on,off,
> >> Nope. If this switch is off, RPI is enabled while known to be buggy, right?
> >>
> > 
> > Btw, RPI was not buggy so so that it could cause crashes; it was failing
> > to _always_ keep a thread's priority consistent across domain migration,
> > which is quite different. IOW, do not start switching on RPIDISABLE
> > blindly when your box goes south, it's most likely unrelated to what has
> > been fixed recently.
> 
> Well, I recalled some temporary locking changes on RPI somewhere in this
> period. My feeling was to better exclude their potential side-effects
> from the testing rounds.
> 

This temporary issue that was introduced by #2109 while rewriting the
RPI support has been fixed by #2139, and caused a debug assertion to
trigger (btw, Stephan, make sure to enable CONFIG_XENO_OPT_DEBUG when
testing). So if the tested revisions did include #2139, then we have the
same crash happening, regardless of whether we use the old or (totally)
new RPI implementation anyway.

My point is that we need to be extra careful about not leading people to
disable RPI blindly (at least in its recent and more complete
incarnation) while it's actually _that_ feature which happens to prevent
priority inversions when secondary mode is involved, e.g:
https://mail.gna.org/public/xenomai-core/2007-01/msg00081.html

-- 
Philippe.



