From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <87o89jj6oj.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 31 Aug 2021 11:36:44 +0200
MIME-Version: 1.0
Message-ID: <10a7-612df800-125-35a6e6c0@10227367>
Subject: =?utf-8?q?Re=3A?= Doing DMA from peripheral to userland memory
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Le Vendredi, Ao=C3=BBt 27, 2021 16:36 CEST, Philippe Gerum <rpm@xenomai=
.org> a =C3=A9crit: 
 
> 
> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> 
> > Le Vendredi, Ao=C3=BBt 27, 2021 15:54 CEST, Philippe Gerum <rpm@xen=
omai.org> a =C3=A9crit: 
> >  
> >> 
> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >> 
> >> > Le Vendredi, Ao=C3=BBt 27, 2021 15:01 CEST, Philippe Gerum <rpm@=
xenomai.org> a =C3=A9crit: 
> >> >  
> >> >> 
> >> >> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:
> >> >> 
> >> >> > Hello,
> >> >> >
> >> >> > working on a zynq7000 target (arm cortex a9), we have a perip=
heral that generates loads of data (many kbytes per ms).
> >> >> >
> >> >> > We would like to move that data, directly from the peripheral=
 memory (the OCM of the SoC) directly to our RT application user memory=
 using DMA.
> >> >> >
> >> >> > For one part of the data, we would like the DMA to de interla=
ce that data while moving it. We figured out, the PL330 peripheral on t=
he SoC should be able to do it, however, we would like, as much as poss=
ible, to retain the use of one or two channels of the PL330 to plain li=
nux non RT use (via dmaengine).
> >> >> >
> >> >> > My first attempt would be to enhance the dmaengine API to add=
 RT API, then implement the RT API calls in the PL330 driver.
> >> >> >
> >> >> > What do you think of this approach, and is it achievable at a=
ll (DMA directly to user land memory and/or having DMA channels exploit=
ed by xenomai and other by linux) ?
> >> >> >
> >> >> > Thanks in advance
> >> >> >
> >> >> > Fran=C3=A7ois
> >> >> 
> >> >> As a starting point, you may want to have a look at this docume=
nt:
> >> >> https://evlproject.org/core/oob-drivers/dma/
> >> >> 
> >> >> This is part of the EVL core documentation, but this is actuall=
y a
> >> >> Dovetail feature.
> >> >> 
> >> >
> >> > Well, that's quite what I want to do, so this is very good news =
that it is already available in the future. However, I need it through =
the ipipe right now, but I guess the process stays the same (through pa=
tching the dmaengine API and the DMA engine driver).
> >> >
> >> > I would guess the modifications to the DMA engine driver would b=
e then easily ported to dovetail ?
> >> >
> >> 
> >> Since they should follow the same pattern used for the controllers=

> >> Dovetail currently supports, I think so. You should be able to sim=
plify
> >> the code when porting it Dovetail actually.
> >> 
> >
> > That's what I thought. Thanks a lot.
> >
> > So now, regarding the "to userland memory" aspect. I guess I will s=
omehow have to, in order to make this happen, change the PTE flags to m=
ake these pages non cacheable (using dma=5Fmap=5Fpage maybe), but I won=
der if I have to map the userland pages to kernel space and whether or =
not I have to pin the userland pages in memory (I believe mlockall in t=
he userland process does that already) ?
> >
> 
> The out-of-band SPI support available from EVL illustrates a possible=

> implementation. This code [2] implements what is described in this pa=
ge
> [1].
> 

Thanks for the example. I think what I'm trying to do is a little diffe=
rent from this however.
For the records, this is what I do (and that seems to be working) :
- as soon as user land buffers are allocated, tell the driver to pin th=
e user land buffer pages in memory (with get=5Fuser=5Fpages=5Ffast). I'=
m not sure if this is required, as I think mlockall in the app would al=
ready take care of that.
- whenever I need to transfer data to the user land buffer, instruct th=
e driver to dma remap those user land pages (with dma=5Fmap=5Fpage), th=
en instruct the DMA controller of the physical address of these pages.
et voil=C3=A0

This seem to work correctly and repeatedly so far.

Fran=C3=A7ois

> [1] https://evlproject.org/core/oob-drivers/spi/
> [2] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/blob/0969ccef=
9a5318244e484e847dab52999f6fec5c/drivers/spi/spi.c#L4259
> 
> -- 
> Philippe.


