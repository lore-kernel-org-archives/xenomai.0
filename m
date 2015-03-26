MIME-Version: 1.0
In-Reply-To: <20150326143151.GM15125@hermes.click-hack.org>
References: <CAJT0owGYuZ8L47AKM0FdjOw5x3g0cjXcXAFPaL91TaxMun6WBw@mail.gmail.com>
 <20150323220935.GA19836@hermes.click-hack.org>
 <CAJT0owGFHg9cuqWQWYY1y93=Dff9pHUyE+Gct_1=RM2gOwNK_w@mail.gmail.com>
 <20150324160153.GB15125@hermes.click-hack.org>
 <20150324161347.GC15125@hermes.click-hack.org>
 <CAJT0owE5VFmOfH05BZTZ4xZ_8=Co6Anu7VWa3qcW-MLMJK8GTQ@mail.gmail.com>
 <CAJT0owE7vtJDWM289=4cNR_LuUqPWAO60nvg9D0NiTQWeN9Xbg@mail.gmail.com>
 <20150326143151.GM15125@hermes.click-hack.org>
Date: Thu, 26 Mar 2015 15:52:06 +0100
Message-ID: <CAJT0owEumqaqe+Kd2cRN+cqxx1ZzA905MYE_wbeGv2t61OkNkQ@mail.gmail.com>
From: Tianchi Huang <gz.eddie.htc@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Yes, I downloaded the vanilla kernel from kernel.org and then I patched it
directly with ipipe. What kinds of patches I need to patch?
I've looked into the /arch/arm/mach-at91/irq.c
and /arch/arm/mach-at91/gipo.c, but i can't find any generic_handle_irq but
ipipe_handle_multi_irq and ipipe_handle_demuxed_irq.

Best regards,

*Eddie HUANG*



2015-03-26 15:31 GMT+01:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On Thu, Mar 26, 2015 at 03:21:31PM +0100, Tianchi Huang wrote:
> > Hello Gilles,
> >
> > Did you find something about that bug?
>
> No. I did not have a look yet. Very much likely there is a piece of
> code in the gpio code that calls generic_handle_irq instead of
> ipipe_handle_demuxed_irq, however from what I can tell the at91 gpio
> driver does not have this issue. You are using a vanilla kernel,
> right, not a patched one ?
>
> --
>                                             Gilles.
>
