From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E1HcIdR-0005wd-IK@snail.fsffrance.org>
References: <E1HcIdR-0005wd-IK@snail.fsffrance.org>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 15:03:27 +0200
Message-Id: <1176469408.19688.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai suspends my kernel thread
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
To: Branko <branko.kolasinovic@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-04-13 at 12:02 +0200, Branko wrote:
> Hi Philippe!
> 
> Thanks for the reply.
> 
> >> Which kernel version, which Adeos patch revision are you using?
> 
> Kernel -> MPC8xx 2.4.25 (Denx based on Yellow Dog) 
> Patch -> adeos-ipipe-2.4.25-ppc-CVS-20060707-1.2-01.patch
> 

I'm afraid you are out of luck with 2.4/ppc kernels if PTE misses are
suspected to occur. IIRC, they have only been fixed by recent Adeos
patches for the Adeos 2.6/arm and 2.6/x86[_64] series. There would be no
straightforward solution to your problem then, fixing the issue for
2.6/ppc too would be required.

> Best regards,
> Branko
> 
> -----Original Message-----
> From: Philippe Gerum [mailto:philippe.gerum@domain.hid] On Behalf Of Philippe
> Gerum
> Sent: Friday, April 13, 2007 11:43
> To: Gilles Chanteperdrix
> Cc: Branko; xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Xenomai suspends my kernel thread
> 
> On Fri, 2007-04-13 at 11:29 +0200, Gilles Chanteperdrix wrote:
> > Branko wrote:
> > >> -----Original Message-----
> > >> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
> > >> Sent: Thursday, April 12, 2007 11:16
> > >> To: Branko
> > >> Cc: xenomai@xenomai.org
> > >> Subject: Re: [Xenomai-help] Xenomai suspends my kernel thread
> > >> 
> > >> Branko wrote:
> > >> 
> > >>>Hello all!
> > >>>
> > >>> 
> > >>>
> > >>>I would be most grateful for your help.
> > >>>
> > >>> 
> > >>>
> > >>>I ported my PowerPC GNU/Linux C/C++ application to Xenomai.
> > >>>
> > >>>When I ran the application everything looked fine.
> > >>>
> > >>>However, with more intense data exchange, one of my interrupt handler
> > >>>threads did not react any longer.
> > >>>
> > >>>I looked at the /var/log/messages file and I saw that Xenomai suspended
> > >>>my thread due to the exception 768.
> > >>>
> > >>> 
> > >>>
> > >>>According to
> > >>>https://mail.gna.org/public/xenomai-help/2006-11/msg00233.html I
> > >>>disabled CONFIG_XENO_OPT_DEBUG
> > >>>
> > >>>from my kernel configuration, but the behaviour of my application did
> > >>>not change.
> > >> 
> > >> What version of Xenomai do you use ? Does your application use fork ?
> If
> > >> yes, then you should switch to Xenomai 2.3.1.
> > >> 
> > > I use Xenomai 2.3.1. I don't use fork in my application.
> > 
> > Philippe, Wolfgang, any idea ?
> > 
> 
> A lot of different situations may lead to a 0x300 exception code
> (including application errors), not necessarily related to the PTE
> misses issue we recently fixed for 2.6.
> 
> Which kernel version, which Adeos patch revision are you using?
> 
-- 
Philippe.



