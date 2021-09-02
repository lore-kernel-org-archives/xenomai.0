From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <10a0-612f3880-12d-29fb8780@204573414>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 02 Sep 2021 18:41:48 +0200
MIME-Version: 1.0
Message-ID: <10a7-6130ff00-12b-35a6e6c0@10227466>
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
To: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Le Mercredi, Septembre 01, 2021 10:24 CEST, Fran=C3=A7ois Legal via Xen=
omai <xenomai@xenomai.org> a =C3=A9crit: 
 
> Le Mardi, Ao=C3=BBt 31, 2021 19:37 CEST, Philippe Gerum <rpm@xenomai.=
org> a =C3=A9crit: 
>  
> > 
> > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > 
> > > Le Vendredi, Ao=C3=BBt 27, 2021 16:36 CEST, Philippe Gerum <rpm@x=
enomai.org> a =C3=A9crit: 
> > >  
> > >> 
> > >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > >> 
> > >> > Le Vendredi, Ao=C3=BBt 27, 2021 15:54 CEST, Philippe Gerum <rp=
m@xenomai.org> a =C3=A9crit: 
> > >> >  
> > >> >> 
> > >> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> > >> >> 
> > >> >> > Le Vendredi, Ao=C3=BBt 27, 2021 15:01 CEST, Philippe Gerum =
<rpm@xenomai.org> a =C3=A9crit: 
> > >> >> >  
> > >> >> >> 
> > >> >> >> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writ=
es:
> > >> >> >> 
> > >> >> >> > Hello,
> > >> >> >> >
> > >> >> >> > working on a zynq7000 target (arm cortex a9), we have a =
peripheral that generates loads of data (many kbytes per ms).
> > >> >> >> >
> > >> >> >> > We would like to move that data, directly from the perip=
heral memory (the OCM of the SoC) directly to our RT application user m=
emory using DMA.
> > >> >> >> >
> > >> >> >> > For one part of the data, we would like the DMA to de in=
terlace that data while moving it. We figured out, the PL330 peripheral=
 on the SoC should be able to do it, however, we would like, as much as=
 possible, to retain the use of one or two channels of the PL330 to pla=
in linux non RT use (via dmaengine).
> > >> >> >> >
> > >> >> >> > My first attempt would be to enhance the dmaengine API t=
o add RT API, then implement the RT API calls in the PL330 driver.
> > >> >> >> >
> > >> >> >> > What do you think of this approach, and is it achievable=
 at all (DMA directly to user land memory and/or having DMA channels ex=
ploited by xenomai and other by linux) ?
> > >> >> >> >
> > >> >> >> > Thanks in advance
> > >> >> >> >
> > >> >> >> > Fran=C3=A7ois
> > >> >> >> 
> > >> >> >> As a starting point, you may want to have a look at this d=
ocument:
> > >> >> >> https://evlproject.org/core/oob-drivers/dma/
> > >> >> >> 
> > >> >> >> This is part of the EVL core documentation, but this is ac=
tually a
> > >> >> >> Dovetail feature.
> > >> >> >> 
> > >> >> >
> > >> >> > Well, that's quite what I want to do, so this is very good =
news that it is already available in the future. However, I need it thr=
ough the ipipe right now, but I guess the process stays the same (throu=
gh patching the dmaengine API and the DMA engine driver).
> > >> >> >
> > >> >> > I would guess the modifications to the DMA engine driver wo=
uld be then easily ported to dovetail ?
> > >> >> >
> > >> >> 
> > >> >> Since they should follow the same pattern used for the contro=
llers
> > >> >> Dovetail currently supports, I think so. You should be able t=
o simplify
> > >> >> the code when porting it Dovetail actually.
> > >> >> 
> > >> >
> > >> > That's what I thought. Thanks a lot.
> > >> >
> > >> > So now, regarding the "to userland memory" aspect. I guess I w=
ill somehow have to, in order to make this happen, change the PTE flags=
 to make these pages non cacheable (using dma=5Fmap=5Fpage maybe), but =
I wonder if I have to map the userland pages to kernel space and whethe=
r or not I have to pin the userland pages in memory (I believe mlockall=
 in the userland process does that already) ?
> > >> >
> > >> 
> > >> The out-of-band SPI support available from EVL illustrates a pos=
sible
> > >> implementation. This code [2] implements what is described in th=
is page
> > >> [1].
> > >> 
> > >
> > > Thanks for the example. I think what I'm trying to do is a little=
 different from this however.
> > > For the records, this is what I do (and that seems to be working)=
 :> > - as soon as user land buffers are allocated, tell the driver to =
pin the user land buffer pages in memory (with get=5Fuser=5Fpages=5Ffas=
t). I'm not sure if this is required, as I think mlockall in the app wo=
uld already take care of that.
> > > - whenever I need to transfer data to the user land buffer, instr=
uct the driver to dma remap those user land pages (with dma=5Fmap=5Fpag=
e), then instruct the DMA controller of the physical address of these p=
ages.
> > > et voil=C3=A0
> > >
> > > This seem to work correctly and repeatedly so far.
> > >
> > 
> > Are transfers controlled from the real-time stage, and if so, how d=
o you
> > deal with cache maintenance between transfers?
> 
> That is my next problem to fix. It seems, as long as I run the test p=
rogram in the debugger, displaying the buffer filled by the DMA in GDB,=
 everything is fine. When GDB get's out of the way, I seem to read data=
 that got in the D cache before the DMA did the transfer.
> I tried adding a flush=5Fdcache=5Frange before trigging the DMA, but =
it did not help.
> 
> Any suggestion ?
> 
> Thanks
> 
> Fran=C3=A7ois
> 

So I dug deep into the kernel cache management code for my (arm v7) arc=
h, but could not find an answer nor a solution.
I now wonder whether or not this (DMA to user land memory) is possible =
on this arch at all because of what is suggested in [1] even if that's =
a bit old.

I saw that flush=5Fdcache=5Frange on armv7 is quite a noop, I tried wit=
h dmac=5Fflush=5Frange (which does the real thing with CP15), passing e=
ither the user land virtual address directly or first getting a kernel =
mapping with kmap=5Fatomic but that did not change anything. I still, m=
ost of the time, get the first 2 cache line of data in the user land ap=
plication wrong after the DMA transfer is done.

I'm not sure where to look at next.

Fran=C3=A7ois

> > 
> > -- 
> > Philippe.
> 
> 
 
 [1] https://groups.google.com/g/linux.kernel/c/QONWGX6WJaE


