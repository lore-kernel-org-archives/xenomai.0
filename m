From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Proposal to use buildbot for Xenomai
Date: Sat, 8 Apr 2006 12:23:11 +0200
References: <200604072337.48181.niklaus.giger@domain.hid>
	<443777D4.3030002@domain.hid>
In-Reply-To: <443777D4.3030002@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604081223.11896.niklaus.giger@domain.hid>
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

Am Samstag, 8. April 2006 10:44 schrieb Jan Kiszka:
> Niklaus Giger wrote:
> > Hi everybody
<..>
> This is a really great idea! Of course, I already have another test
> candidate in mind: RTnet 8). Specifically the PPC environment would be
> interesting, as our "buildbot" (sorry, Wolfgang G. ;) ) is typically
> very busy so that build regressions are sometimes only detected with
> delay on that platform. Is it also possible to explicitly trigger an
> update and rebuild?
Yes of course. Just select a buildslave (e.g. ppc or hcu3 -> 
http://ngiger.dyndns.org/buildbot/hcu3) and you may manually trigger it. I 
intentionally left this facility open for everybody to test it. But it would 
of course be possible to restrict it only to a few selected developers. 

If you want, I can help you to setup the master.cfg for a rtnet buildbot.

> But also for Xenomai I would see this as a very useful tool, e.g. for
> 2.4 build tests (I must confess I only test sporadically against this
> kernel).
I will add one. Could you please e-mail me (privately if you want) a working 
config (ppc, no cross compiling if possible). Or do you want to add a build 
slave under your control?
<..>
> Is there no reset button you could control via a master station, e.g. by
> attaching some cheap electronic to a parallel or serial port?
There is a reset button, but then you have it running and consuming 
electricity all the times.
> I just remember that DENX once had or still have a remote PPC test-lab
> running. I CC'ed Wolfgang, maybe he could comment on this if and how it
> could be used.
I would be willing to setup a buildbot for the u-boot, too, as my board boots 
with a very outdated version of u-boot.

Best regards

-- 
Niklaus Giger

