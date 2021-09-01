From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <877dg1ms60.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 01 Sep 2021 10:24:30 +0200
MIME-Version: 1.0
Message-ID: <10a0-612f3880-12d-29fb8780@204573414>
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

Le Mardi, Ao=C3=BBt 31, 2021 19:37 CEST, Philippe Gerum <rpm@xenomai.or=
g> a =C3=A9crit: 
 
> 
> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> 
> > Le Vendredi, Ao=C3=BBt 27, 2021 16:36 CEST, Philippe Gerum <rpm@xen=
omai.org> a =C3=A9crit: 
> >  
> >> 
> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >> 
> >> > Le Vendredi, Ao=C3=BBt 27, 2021 15:54 CEST, Philippe Gerum <rpm@=
xenomai.org> a =C3=A9crit: 
> >> >  
> >> >> 
> >> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> >> >> 
> >> >> > Le Vendredi, Ao=C3=BBt 27, 2021 15:01 CEST, Philippe Gerum <r=
pm@xenomai.org> a =C3=A9crit: 
> >> >> >  
> >> >> >> 
> >> >> >> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes=
:
> >> >> >> 
> >> >> >> > Hello,
> >> >> >> >
> >> >> >> > working on a zynq7000 target (arm cortex a9), we have a pe=
ripheral that generates loads of data (many kbytes per ms).
> >> >> >> >
> >> >> >> > We would like to move that data, directly from the periphe=
ral memory (the OCM of the SoC) directly to our RT application user mem=
ory using DMA.
> >> >> >> >
> >> >> >> > For one part of the data, we would like the DMA to de inte=
rlace that data while moving it. We figured out, the PL330 peripheral o=
n the SoC should be able to do it, however, we would like, as much as p=
ossible, to retain the use of one or two channels of the PL330 to plain=
 linux non RT use (via dmaengine).
> >> >> >> >
> >> >> >> > My first attempt would be to enhance the dmaengine API to =
add RT API, then implement the RT API calls in the PL330 driver.
> >> >> >> >
> >> >> >> > What do you think of this approach, and is it achievable a=
t all (DMA directly to user land memory and/or having DMA channels expl=
oited by xenomai and other by linux) ?
> >> >> >> >
> >> >> >> > Thanks in advance
> >> >> >> >
> >> >> >> > Fran=C3=A7ois
> >> >> >> 
> >> >> >> As a starting point, you may want to have a look at this doc=
ument:
> >> >> >> https://evlproject.org/core/oob-drivers/dma/
> >> >> >> 
> >> >> >> This is part of the EVL core documentation, but this is actu=
ally a
> >> >> >> Dovetail feature.
> >> >> >> 
> >> >> >
> >> >> > Well, that's quite what I want to do, so this is very good ne=
ws that it is already available in the future. However, I need it throu=
gh the ipipe right now, but I guess the process stays the same (through=
 patching the dmaengine API and the DMA engine driver).
> >> >> >
> >> >> > I would guess the modifications to the DMA engine driver woul=
d be then easily ported to dovetail ?
> >> >> >
> >> >> 
> >> >> Since they should follow the same pattern used for the controll=
ers
> >> >> Dovetail currently supports, I think so. You should be able to =
simplify
> >> >> the code when porting it Dovetail actually.
> >> >> 
> >> >
> >> > That's what I thought. Thanks a lot.
> >> >
> >> > So now, regarding the "to userland memory" aspect. I guess I wil=
l somehow have to, in order to make this happen, change the PTE flags t=
o make these pages non cacheable (using dma=5Fmap=5Fpage maybe), but I =
wonder if I have to map the userland pages to kernel space and whether =
or not I have to pin the userland pages in memory (I believe mlockall i=
n the userland process does that already) ?
> >> >
> >> 
> >> The out-of-band SPI support available from EVL illustrates a possi=
ble
> >> implementation. This code [2] implements what is described in this=
 page
> >> [1].
> >> 
> >
> > Thanks for the example. I think what I'm trying to do is a little d=
ifferent from this however.
> > For the records, this is what I do (and that seems to be working) :=

> > - as soon as user land buffers are allocated, tell the driver to pi=
n the user land buffer pages in memory (with get=5Fuser=5Fpages=5Ffast)=
. I'm not sure if this is required, as I think mlockall in the app woul=
d already take care of that.
> > - whenever I need to transfer data to the user land buffer, instruc=
t the driver to dma remap those user land pages (with dma=5Fmap=5Fpage)=
, then instruct the DMA controller of the physical address of these pag=
es.
> > et voil=C3=A0
> >
> > This seem to work correctly and repeatedly so far.
> >
> 
> Are transfers controlled from the real-time stage, and if so, how do =
you
> deal with cache maintenance between transfers?

That is my next problem to fix. It seems, as long as I run the test pro=
gram in the debugger, displaying the buffer filled by the DMA in GDB, e=
verything is fine. When GDB get's out of the way, I seem to read data t=
hat got in the D cache before the DMA did the transfer.
I tried adding a flush=5Fdcache=5Frange before trigging the DMA, but it=
 did not help.

Any suggestion ?

Thanks

Fran=C3=A7ois

> 
> -- 
> Philippe.


