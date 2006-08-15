From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot cannot compile xenoma: rtcanconfig
	refences pthread_kill
Date: Tue, 15 Aug 2006 20:56:50 +0200
References: <200608150949.30029.niklaus.giger@domain.hid>
	<44E20EEF.7000705@domain.hid>
In-Reply-To: <44E20EEF.7000705@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608152056.51541.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Am Dienstag, 15. August 2006 20:14 schrieb Jan Kiszka:
> Niklaus Giger wrote:
> > Hi
> >
> > All my PPC based compilation fail with something like
> > ...
>
> Things start to work again, but other issues pop up now.
>
> o The installation step of xenomai on the tqm860 is broken. For that
>   reason RTnet fails to configure. Please have a look, Niklaus.
I had noticed this just before the compile issues popped up. I will have a 
look, but the whole buildbot system is quite complex and confuses sometimes 
even its creator.
> o The simulator fails in both the posix and vxworks part:
>   http://ngiger.dyndns.org/buildbot/sim/builds/258/step-check_sim/0
I reported the error "vxworks->t010823-2:t010823-2.c:163: Expected sequence: 
SEQ("Test2",2009); got SEQ("Test2",2003)" some time ago. Looks like a minor 
issue to me, as the simulator has its own internal timing. But I always 
prefer that Gilles fixes these kind of errors.

>   Could anyone have a look?
The other errors in the POSIX skin are new and need to be looked at.

>
> o The run test on the hcu_vx seems to cause a hang after the nucleus
>   being loaded:
>   http://ngiger.dyndns.org/buildbot/hcu_vx/builds/128/step-xeno-test/0
This is a long standing problem, where Philippe needs to get hand on a PPC40x 
system to find the error. I tried to give it a look
> hcu3 is fine, a rebuild of "ppc" is currently pending.
hcu3 is the most important target (at least for me), as it is the only target 
which runs xeno-test.
>
> A few remarks and wishes:
>
> o Some list of the characteristics of those systems would be nice, just
>   to gain overview what the differences are.

I will try to fix my documentation. But from the beginning I wanted to 
introduce as much variance as possible in the different buildings, therefore 
I intentionally used different gcc versions, cross-compiling vs native, only 
xenomai vs xenomai+RTnet, POSIX vs VXWORKS, everything built-in vs everything 
as a module. Looking at all the different log files (I know that this is time 
consuming) usually gives me quite a few of the answers.

>
> o Maybe it's useful to strip the kernel configs of some systems
>   (non-related drivers etc.) to reduce the turn-around time.
I was thinking about it, but it is only the ppc build which takes a long time 
to build and I am running usually a specific build of this kernel to assure 
me that Xenomai is working all right in a real environment.

Roundtrip time could also be improved if more buildbot slave were added. 
Though if anybody has a spare machine running all the time which could 
support the load of Xenomai builds, I would be glad to help integrate another 
slaves into my buildbot system. It would be also possible to add specific 
slave for anybody who wants to be assured that the Xenomai trunk continues to 
work for his specific board and build environment.

>
> o Some kind of allyesconfig for Xenomai would be nice. 2.4 doesn't seem
>   to have this, but maybe one can derive that from a 2.6 .config, grab
>   all XENO-related switches, and append them to the 2.4 .config. This
>   way new stuff like the CAN stack now would get included faster.
A allyesconfig is not possible as e.g. VXWORKS and the POSIX-skin have 
mutually exclusive requirements for the timing system (periodic vs 
aperiodic).

If you want some specific CONFIG set please drop me a note.

>
> On final remark I can only repeat over and over again:
>
> Your buildbot is really great stuff! It significantly reduces the
> round-trip time for detecting and fixing (often trivial) build issues as
> long as there are not yet millions of Xenomai users updating their SVN
> checkout every day ;)
Thanks for the compliment. As long as everybody on the mailing list responds 
so well to my complaints that something is broken, I will remain motivated to 
invest my time.

Best regards
-- 
Niklaus Giger

