Date: Wed, 25 Jun 2014 19:14:23 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Message-ID: <20140625171423.GD19569@lukather>
References: <5396D780.4020704@xenomai.org> <20140611092532.GE4254@lukather>
 <53989CEF.3080205@xenomai.org> <20140612075401.GH4254@lukather>
 <539966B7.3080900@xenomai.org> <20140612150313.GA3448@lukather>
 <539B4A85.7030302@xenomai.org> <20140623140559.GE19730@lukather>
 <53A8BBD6.3020701@xenomai.org> <53A91727.9040208@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53A91727.9040208@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Atmel SAMA5D3 with a 3.14 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Michael Opdenacker <michael@free-electrons.com>, Thomas Petazzoni <thomas@free-electrons.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine@free-electrons.com>

On Tue, Jun 24, 2014 at 08:13:59AM +0200, Gilles Chanteperdrix wrote:
> >> After fixing the irq controller to work on the AIC5, and
> >> disabling the pic muting, I get almost 100% of the time a system
> >> freeze when running: 
> >> http://git.free-electrons.com/training-materials/tree/lab-data/realtime/rttest/data/rttest.c
> >
> >>  The TCB timer is still ticking, at a rate around 1Hz, while,
> >> when the system hangs, the PIT interrupt isn't firing anymore
> >> (which explains the freeze). So there's probably something wrong
> >> related to the ipipe I guess, or the interrupt being masked and
> >> not unmasked at some point.
> > 
> > Well: - the existing at91 I test also use a PIT and they do not
> > hang - if you disabled the pic muting, noone is disabling the PIT
> > interrupt.
> > 
> > So, I would suggest looking carefully at the sama5 code.
> 
> You could also post this code for review, BTW. Unless I am mistaken
> about your company, you do not want to keep it secret anyway ;-)

Yeah, I was willing to first make it work, but the final plan was of
course to submit it.

I'll clean that up and post it then.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140625/57e21e1c/attachment.sig>
