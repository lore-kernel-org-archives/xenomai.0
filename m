Date: Mon, 26 Nov 2018 15:30:29 +0100
From: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
Subject: Re: Testing of 4.4/Ipipe + Xenomai 3.0.X on ARM32
Message-ID: <20181126143029.6jts36bo267l776s@jholzmayr.localdomain>
References: <20181123122716.tgg3utytwyrkzyid@jholzmayr.localdomain>
 <d1808069-d213-7e9f-010f-abd2c88b0480@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1808069-d213-7e9f-010f-abd2c88b0480@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Hi Jan,

On Fri, Nov 23, 2018 at 01:48:27PM +0100, Jan Kiszka wrote:
> Hi Sepp,
> 
> On 23.11.18 13:27, Josef Holzmayr via Xenomai wrote:
> > Hello!
> > 
> > To improve the testing situation for the 4.4 Kernel family on ARM32, I
> > created a set of layers [1] for OpenEmbedded. Currently the features are
> > rather limited:
> > 
> > - only the Morty branch exists, as this one natively includes Linux 4.4
> >    and therefore the GCC version etc. matches.
> 
> To my best knowledge, there is no dependency (yet) between a too new
> compiler and kernel 4.4. We are building 4.4-cip with pyro, e.g.

Yes, I agree that pyro and rocko should probably not give any major
trouble. Yet, something in the back of my head tells me that thud and
maybe sumo will be problematic. Will investigate and report!

> > - only one BSP layer so far, namely the Beaglebone. This was chosen for
> >    two major reasons: a) it is supported well enough in 4.4. to not need
> >    additional patches which might introduce new issues, and b) it is
> >    hardware that I have here ready for testing.
> 
> I was thinking about which ARMv7 board to add to xenomai-images (enabling
> qemu will be first, though), and that is a good candidate there as well.
> 
> Another half-done topic here: CI builds. For that, the BB defconfig could be
> useful too.

My local tinkering of xenoami-images to create a qemu-armhf build is
still in progress. But yes, we should have a build there too. But I
don't think the BB defconfig I'm using at the moment is really suited
for xenomai testing. I'll certainly need to tinker with it some more.

> 
> > - no higher automation like a kas cofiguration so far. Yet this probably
> >    will be the first limitation to be gotten rid of.
> > 
> > My current planning is to add a set of testing scripts based of
> > Philippe's suggestion, and run that suite on each new release for a
> > couple of days and post the results to the ML.
> 
> That sounds very helpful! We should try to keep common parts (anything
> unrelated to the image build system) in the core so that we can reuse that
> in xenomai-images as well.

In the end, it would probably just be something like "xeno-test-long"

> 
> > 
> > Preliminary results to kick off things:
> > - xeno-test completes successfully
> > - latency -t0 under load maxes at ~58µs
> > - latency -t2 under load maxes at ~18µs
> > 
> 
> Great! According to [1], we could then tag 63637800 also for ARM? Or do you
> want to run more of the tests you have in mind first?

Given my current testing experience, I would like to not say yes or no,
as I'm not knowledgeable enough to judge. So please decide yourself upon
the given information, with those additional "hints":
- xeno-test "only" runs for 15minutes by default.
- the latency tests I did were not really more long-lived, I don't think
  any one exceeded 30minutes.
- it will be at least two more weeks until I have the long-run results.
  Could also be three. So if you want to tag rather soon, I can't rally
  help more.

Greetz
-- 
———————————————
Josef Holzmayr
Software Developer Embedded Systems

Tel: +49 8444 9204-48
Fax: +49 8444 9204-50

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de
———————————————
Amtsgericht Ingolstadt – GmbH: HRB 191328 – KG: HRA 170393
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
Ust-IdNr: DE 128592548 

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


