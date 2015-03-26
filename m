MIME-Version: 1.0
In-Reply-To: <20150326145437.GR15125@hermes.click-hack.org>
References: <CAJT0owGYuZ8L47AKM0FdjOw5x3g0cjXcXAFPaL91TaxMun6WBw@mail.gmail.com>
 <20150323220935.GA19836@hermes.click-hack.org>
 <CAJT0owGFHg9cuqWQWYY1y93=Dff9pHUyE+Gct_1=RM2gOwNK_w@mail.gmail.com>
 <20150324160153.GB15125@hermes.click-hack.org>
 <20150324161347.GC15125@hermes.click-hack.org>
 <CAJT0owE5VFmOfH05BZTZ4xZ_8=Co6Anu7VWa3qcW-MLMJK8GTQ@mail.gmail.com>
 <CAJT0owE7vtJDWM289=4cNR_LuUqPWAO60nvg9D0NiTQWeN9Xbg@mail.gmail.com>
 <20150326143151.GM15125@hermes.click-hack.org>
 <CAJT0owEumqaqe+Kd2cRN+cqxx1ZzA905MYE_wbeGv2t61OkNkQ@mail.gmail.com>
 <20150326145437.GR15125@hermes.click-hack.org>
Date: Thu, 26 Mar 2015 16:19:32 +0100
Message-ID: <CAJT0owFd8bRmf3w2C-n_Vno038h0XRjBoRHRFnuNdBAZ63zn+g@mail.gmail.com>
From: Tianchi Huang <gz.eddie.htc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 3.0-rc3 Interruption on Arietta G25
 (AT91SAM9G25 chip)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

After kernel compilation, the following .o files have been created:
- at91_ipipe.o
- at91sam9_alt_reset.o
- at91sam9g45.o
- at91sam9g45_reset.o
- at91sam9n12.o
- at91sam9rl.o
- at91sam9x5.o
- at91sam926x_time.o
- at91sam9260.o
- at91sam9261.o
- at91sam9263.o
- board-dt-sam9.o
- sam9_smc.o
- gpio.o
- clock.o
- irq.o
- leds.o
- pm.o
- setup.o
- sysirq_mask.o



*Tianchi HUANG*

Ing=C3=A9nieur Informatique en Apprentissage

eddie.huang@bioserenity.com

Tel : +33(0) 6 52 86 29 86



BioSerenity

ICM-iPEPS

47-85 boulevard de l'H=C3=B4pital

75013 Paris


www.bioserenity.com

2015-03-26 15:54 GMT+01:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On Thu, Mar 26, 2015 at 03:52:06PM +0100, Tianchi Huang wrote:
> > Yes, I downloaded the vanilla kernel from kernel.org and then I patched
> it
> > directly with ipipe. What kinds of patches I need to patch?
> > I've looked into the /arch/arm/mach-at91/irq.c
> > and /arch/arm/mach-at91/gipo.c, but i can't find any generic_handle_irq
> but
> > ipipe_handle_multi_irq and ipipe_handle_demuxed_irq.
>
> Yes, this is what I tell you. Maybe some other code is compiled for
> your board, but I do not find anything called at91 in drivers/gpio
> either. Which is why I asked for your kernel configuration to see
> what GPIO driver is compiled.
>
> --
>                                             Gilles.
>
