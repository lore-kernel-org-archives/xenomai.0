From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTimE5K2Hy=UH+TVN6MEfvtVn=n=bh_AMkPakTf+K@mail.gmail.com>
References: <AANLkTinWHLk2fc0qMygBOmgYpAAh88FbUAUFDq2DPRKL@mail.gmail.com>
	<4C7232E6.8070709@domain.hid>
	<AANLkTi=sOUgazTM-OxCsC6Za0y=ZkRoM1PC61ADx54+c@domain.hid>
	<1282555835.1961.55.camel@domain.hid>
	<AANLkTimE5K2Hy=UH+TVN6MEfvtVn=n=bh_AMkPakTf+K@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Aug 2010 23:46:56 +0200
Message-ID: <1282600016.1961.114.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai patch for AT91ARM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prakash A S <asprakash83@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-08-23 at 15:58 +0530, Prakash A S wrote:
> 
> 
> On Mon, Aug 23, 2010 at 3:00 PM, Philippe Gerum <rpm@xenomai.org>
> wrote:
>         
>         On Mon, 2010-08-23 at 14:43 +0530, Prakash A S wrote:
>         >
>         >
>         > On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix
>         > <gilles.chanteperdrix@xenomai.org> wrote:
>         >
>         >         Prakash A S wrote:
>         >         > Dear All,
>         >         >          Now I am working on AT91RM9200 based
>         processor ARM
>         >         board with Linux
>         >         > 2.6.20 kernel and also planing to port Xenomai on
>         this
>         >         board. I preferred
>         >         > xenomai-2.4.0. Because it has adeos-ipipe patch
>         for 2.6.20
>         >         kernel. However I
>         >         > found that there is an separate ipipe patch
>         available for
>         >         AT91 processor in
>         >         > xenomai-2.3.2. Do I need any similar patch for
>         xenomai-2.4.0
>         >         or
>         >         > adeos-ipipe-2.6.20-arm-1.802.patch is enough?.
>         >         >
>         >         > I beleive the steps will be like,
>         >         > linux-2.6.20+2.6.20-at91.patch.gz
>         >         +adeos-ipipe-2.6.20-arm-1.802.patch
>         >
>         >
>         >         You did it again: as documented in
>         >         ksrc/arch/arm/patches/README,
>         >         what Xenomai version you pick is largely irrelevant
>         to what
>         >         I-pipe patch
>         >         you want to use, so, you can probably use the I-pipe
>         patch for
>         >         2.6.20
>         >         with Xenomai 2.5.4.
>         >
>         >
>         > Agreed. The intention is to clarify few doubts. Otherwise I
>         will
>         > missed to get such an specific info mentioned below.
>         > Thanks for the info.
>         >
>         >         All releases of a Xenomai branch are backward
>         compatible, so,
>         >         if you
>         >         want to pick something in the any branch, pick the
>         latest
>         >         (2.4.10 for
>         >         2.4 branch, 2.5.4 for 2.5 branch). Also note that
>         all I-pipe
>         >         patches up
>         >         to, but not including, 2.6.28-1.12-05, are buggy,
>         so, if you
>         >         want to use
>         >         2.6.20, you will have to apply the patch attached to
>         this
>         >         mail:
>         >
>         >
>         https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
>         >
>         >         As for the initial question, I do not remember that
>         far in the
>         >         past.
>         >         But, at some point in the past, the I-pipe patch
>         started being
>         >         able to
>         >         be applied with and without the AT91 patch, I do not
>         remember
>         >         if
>         >         2.6.20-1.8-02 was in this case.
>         >
>         >
>         > At this moment my board only supports linux-2.6.20. So I
>         just like to
>         > port xenomai and test the board with the same kernel
>         version. Later I
>         > will upgrade the linux kernel and move to the latest
>         xenomai.
>         
>         
>         What Gilles told you, is that Xenomai is backward-compatible
>         with older
>         Adeos releases. Therefore, unless you really want to hit
>         Xenomai bugs
>         which have been solved since 2007, you should consider using
>         the
>         _latest_ Xenomai release, which does support 2.6.20 kernels,
>         with your
>         legacy kernel. Could you somehow trust us when we recommend
>         what we
>         think is the best way for your project to succeed?
>         
>         The other incentive for you to do that, is to get answers to
>         your
>         questions if any issue happens during this process. Because
>         likely
>         nobody will ever bother or have any clue for problems
>         regarding Xenomai
>         2.4.0 on this list.
> 
> 
> Dear Philippe,
>         Thanks for pointing out the right way towards my target. I got
> his point and I trust the community work and open source rather than
> the closed one. Moreover, that is the only reason I am using xenomai
> now. So there is no doubt about the xenomai; But it is about the BSP.
> 
> Obviously no one will bother about the old version if something new is
> already exist with the best. But my current worry is, BSP. I believe,
> adopting with latest xenomai is easy compare with BSP preparation for
> new kernel.  So my idea is to test the board with 2.6.20 xenoami (not
> care about the bug/performance)and then move to the latest version. At
> the same time not interested to mess the community with older version
> of xenomai.

I'm unsure that we are on the same page yet. So, to close this
discussion which seems to deadlock badly, here is a summary:

- a board support package is the glue between your hardware and the
kernel software. Your bsp issue is solved by the Linux code,
supplemented in some ways by the Adeos patch, not by the Xenomai code.
In other words, the glue for connecting your board to Linux is fully
present in Linux, Xenomai provides nothing in this respect. The Xenomai
code merely depends on the Linux infrastructure to talk to your
hardware, through the Adeos layer for the real-time dependent part.

The layers are: Linux => Adeos => Xenomai

- A given Xenomai release can run over most of the Adeos patches issued
before that release date, including those that were shipped with earlier
Xenomai releases; e.g. for the powerpc architecture, the latest Xenomai
2.5.4 can run over any Adeos patch fitted for Linux 2.4.25 up to Linux
2.6.34. It is not recommended to run antiquated Adeos patches for Ice
Age kernels, but if you have to, this is clearly possible. Again, this
is all explained here:
http://www.xenomai.org/index.php/FAQs#Which_I-pipe_patch_should_I_use_with_Xenomai_version_X_on_platform_Y.3F
In other words again, a strong coupling exists between a given Linux
kernel release and some Adeos patch release that fits that kernel. But,
the coupling is much weaker between a given Xenomai release, and a Linux
kernel release, precisely because the Adeos layer exposes a
version-independent, stable interface since ages, and most of the
binding between Xenomai and Linux goes through this interface.

- Therefore, sticking to Xenomai 2.4.0 only because this release
includes Adeos patch files for Linux 2.6.20 does not make sense, even
remotely. Reading carefully the FAQ at the URL I just mentioned,  should
ring _that_ bell for you: "whatever Adeos patches I find in
ksrc/arm/patches, I should be able to pick the Adeos patch I need for
the kernel I want to base Xenomai on, directly from the Adeos project".
As mentioned in this FAQ, the patches shipped with that Xenomai release
have been used to validate it, but this does preclude earlier patches
from working just as well in this context. Just try it.

- To sum up the summary, the recommended combo for you is:

* an Adeos patch for 2.6.20/arm, and you don't even have to stick with
those found in ksrc/arm/patches in Xenomai 2.4.0. Those patches are
vanilla Adeos patches, unmodified, plain ones. And all older Adeos
patches for arm which should work with the most recent Xenomai releases
are available there:
http://download.gna.org/adeos/patches/v2.6/arm/older/
As Gilles mentioned, you may have to fix this patch with recent updates
which made their way in more recent Adeos patches, to remove very
annoying issues (read: freaking critical horror code).
* Xenomai 2.5.4, which you should build over your 2.6.20 kernel + Adeos
patch you picked.

A final note: Adeos patches for 2.6.20 do not include the FCSE support;
so don't expect latencies on your at91 that would match those you would
get with more recent Linux+Adeos combos.

> 
> -Prakash
> 

-- 
Philippe.



