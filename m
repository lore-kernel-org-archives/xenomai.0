Subject: Re: [Xenomai-help] primary mode versus secondary mode
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <75975c320608231300t30cf5e69u7a629887d9163e40@domain.hid>
References: <75975c320608211235l79dfb17ft54df1018e7f597ff@domain.hid>
	<75975c320608211321u5b2d9e45nfb078e9ed4d8b617@domain.hid>
	<1156192960.4321.70.camel@domain.hid>
	<75975c320608231300t30cf5e69u7a629887d9163e40@domain.hid>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 22:17:34 +0200
Message-Id: <1156364255.4401.71.camel@domain.hid>
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
To: Paul Ianna <paulianna2002@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-23 at 16:00 -0400, Paul Ianna wrote:
> On 8/21/06, Philippe Gerum <rpm@xenomai.org> wrote:
> > Also have a look at /proc/xenomai/stats when your application runs, the
> > MSW field (i.e. Mode SWitches) counts the number of transitions for each
> > Xenomai thread. This value should not increase over time, at least for
> > latency critical threads.
> 
> Thanks Philippe, very useful.
> 
> Could you also explain the CSW, PF, and STAT fields?

CSW: # of context-switches (seen by the Xenomai scheduler, not the Linux
one)
PF: # of page faults (should stop increasing as soon as mlockall is in
effect)
STAT: a bitfield describing the internal state of the thread. Bit values
are defined in include/nucleus/thread.h (See status and mode bits). The
STAT field from /proc/xenomai/sched gives a 1-letter-per-bit symbolic
translation of a the most significant subset of those bits (from a user
POV, that is). See "Status symbols" in the same source file. 

> 
> Thanks,
> Paul
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



