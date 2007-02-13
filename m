Subject: Re: [Xenomai-help] fata: removing non-linked element...
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D1CAFA.6050408@domain.hid>
References: <45CC651C.6060402@domain.hid> <45CC68F3.1000003@domain.hid>
	<45D1C033.9010002@domain.hid>  <45D1C61B.7030503@domain.hid>
	<1171376742.885.3.camel@domain.hid>  <45D1CAFA.6050408@domain.hid>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 15:47:22 +0100
Message-Id: <1171378042.885.6.camel@domain.hid>
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

On Tue, 2007-02-13 at 15:28 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2007-02-13 at 15:07 +0100, Jan Kiszka wrote:
> >> Stephan Zimmermann wrote:
> >>> I wasn't able to isolate the section of my code that causes the crash by
> >>> now. The only thing I figured out by now is that the particular crash
> >>> does not happen with 2.3.x rev 2077.
> >>> So I guess some change from 2077 to the 2139 revision did break something.
> >> Could you track the issue a bit more down? There are not to many
> >> "interesting" changes to 2.3.x. A few milestones I found in the ChangeLog:
> >>
> >> - 2092: Allow sleeping scheduler locks
> >> - 2108: Before RPI rework
> >>
> >> Anything after 2108 only makes sense to dissect when you switch on
> > 
> > s,on,off,
> 
> Nope. If this switch is off, RPI is enabled while known to be buggy, right?
> 

So, if you want to check whether RPI causes some trouble or not, so as
to "dissect" what it does, you need to keep this switch off.

> [That's why I voted for positive logic in trunk -- it twists your brain. ;)]
> 
> > 
> >> XENO_OPT_RPIDISABLE (RPI was buggy until 2139).
> >>
> >>> I'll go on trying to make it reproducible in a small demo program.
> >>>
> >>> By the way, I see a Pentium M crash reliable when I do the following,
> >>> don't know if it's related:
> >>>
> >>> - load nucleus and native module
> >>> - start / stop my app
> >>> - reload the modules
> >>> - start my app --> crash
> >>>
> >>> I attached 'screenshots' of a total freeze with backtrace and some
> >>> messages I extracted  from syslog (both on Pentium M).
> >> Looks like some memory corruption. Your application is not messing
> >> around on raw (kernel) memory and/or hardware? Keep in mind that changes
> >> to the kernel code also moves offsets, potentially unrevealing a
> >> pre-existing corruption that so far just hit harmless regions.
> >>
> >> Jan
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> 
> 
-- 
Philippe.



