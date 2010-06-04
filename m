From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <B72938E0E9A84DE3A8F66E90AF8D3BE4@domain.hid>
References: <B72938E0E9A84DE3A8F66E90AF8D3BE4@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Jun 2010 09:54:48 +0200
Message-ID: <1275638088.18250.124.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] "arm: fix mm switching" patch effective also for
 2.4.10 ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: k-isono@domain.hid
Cc: xenomai@xenomai.org


Isono-san,

On Fri, 2010-06-04 at 13:11 +0900, Katsuhiko Isono wrote:
> > -----Original Message-----
> > Katsuhiko Isono wrote:
> > > I use linux-2.6.26 + xenomai-2.4.10 with custom arm(i.mx31) board.
> > > 
> > > When realtime application was executed on my environment,
> > > application caused the SIGSEGV fault about once every several hours.
> > > 
> > > However, when I applied "arm: fix mm switching" patch of 
> > xenomai-2.5 to 
> > > my environment, SIGSEGV fault did not happen.
> > > 
> > > There is a following question.
> > >  - Is this patch effective also for 2.4.10 ?
> > >  - What trouble is corrected with this patch ?
> > 
> > The version of the I-pipe patch you are using has another 
> > known bug than
> > the one fixed by the "arm: fix mm switching" patch (by the way, to be
> > sure that we are talking about the same patch, I would prefer an URL
> > pointing to xenomai's gitweb), the bug mentioned here:
> > 
> > https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
> > 
> > And the fix for this bug in the I-pipe patches which comes 
> > with Xenomai
> > 2.4.10 should fix both bugs.
> > 
> > So, in short, do you oberve the segmentation faults when using the
> > I-pipe patches which ship with Xenomai 2.4.10 rather than 
> > whatever patch
> > you are using for linux 2.6.26?
> > 
> 
> Thank you for your reply.
> 
> I use linux-2.6.26 of Freescale BSP because I develop custom board. 
> Therefore, because it is not possible to apply IPIPE patch of Xenomai-2.4.10, I applied 
> "adeos-ipipe-2.6.26-arm-1.12-00.patch" included in Xenomai-2.4.8 to my kernel, and
> backported most of the changes up to xenomai-2.5.3.

You could have used the latest Xenomai release directly over your custom
2.6.26 kernel, even with a legacy pipeline patch for 2.6.26 in. We do
try hard to maintain backward compat, see:
http://xenomai.org/index.php/FAQs#Which_I-pipe_patch_should_I_use_with_Xenomai_version_X_on_platform_Y.3F

We should probably stress this fact in a more visible way, so that
nobody assumes that a given Xenomai release can only run on the pipeline
patches it ships. In fact, most patches released in the past five years
or so would do, with a varying degree of stability, though. Getting the
most recent one is certainly the safest bet.

> 
> To fix other trouble, I had already applied similar patch to which you presented .
> So that, both patches were applied to my kernel, and I could solve trouble.
> 
> Here is the URL of "arm: fix mm switching".
> http://git.xenomai.org/?p=xenomai-2.5.git;a=commitdiff;h=443c2c93ca822088fcf9de65cff128858affa0b8
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



