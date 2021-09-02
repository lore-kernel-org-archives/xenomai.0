References: <10a0-612f3880-12d-29fb8780@204573414>
 <10a7-6130ff00-12b-35a6e6c0@10227466>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Doing DMA from peripheral to userland memory
In-reply-to: <10a7-6130ff00-12b-35a6e6c0@10227466>
Date: Thu, 02 Sep 2021 19:12:50 +0200
Message-ID: <871r669a0d.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org


Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:

> Le Mercredi, Septembre 01, 2021 10:24 CEST, Fran=C3=A7ois Legal via Xenom=
ai <xenomai@xenomai.org> a =C3=A9crit:=20
>=20=20
>> Le Mardi, Ao=C3=BBt 31, 2021 19:37 CEST, Philippe Gerum <rpm@xenomai.org=
> a =C3=A9crit:=20
>>=20=20
>> >=20
>> > Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> >=20
>> > > Le Vendredi, Ao=C3=BBt 27, 2021 16:36 CEST, Philippe Gerum <rpm@xeno=
mai.org> a =C3=A9crit:=20
>> > >=20=20
>> > >>=20
>> > >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> > >>=20
>> > >> > Le Vendredi, Ao=C3=BBt 27, 2021 15:54 CEST, Philippe Gerum <rpm@x=
enomai.org> a =C3=A9crit:=20
>> > >> >=20=20
>> > >> >>=20
>> > >> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> > >> >>=20
>> > >> >> > Le Vendredi, Ao=C3=BBt 27, 2021 15:01 CEST, Philippe Gerum <rp=
m@xenomai.org> a =C3=A9crit:=20
>> > >> >> >=20=20
>> > >> >> >>=20
>> > >> >> >> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:
>> > >> >> >>=20
>> > >> >> >> > Hello,
>> > >> >> >> >
>> > >> >> >> > working on a zynq7000 target (arm cortex a9), we have a per=
ipheral that generates loads of data (many kbytes per ms).
>> > >> >> >> >
>> > >> >> >> > We would like to move that data, directly from the peripher=
al memory (the OCM of the SoC) directly to our RT application user memory u=
sing DMA.
>> > >> >> >> >
>> > >> >> >> > For one part of the data, we would like the DMA to de inter=
lace that data while moving it. We figured out, the PL330 peripheral on the=
 SoC should be able to do it, however, we would like, as much as possible, =
to retain the use of one or two channels of the PL330 to plain linux non RT=
 use (via dmaengine).
>> > >> >> >> >
>> > >> >> >> > My first attempt would be to enhance the dmaengine API to a=
dd RT API, then implement the RT API calls in the PL330 driver.
>> > >> >> >> >
>> > >> >> >> > What do you think of this approach, and is it achievable at=
 all (DMA directly to user land memory and/or having DMA channels exploited=
 by xenomai and other by linux) ?
>> > >> >> >> >
>> > >> >> >> > Thanks in advance
>> > >> >> >> >
>> > >> >> >> > Fran=C3=A7ois
>> > >> >> >>=20
>> > >> >> >> As a starting point, you may want to have a look at this docu=
ment:
>> > >> >> >> https://evlproject.org/core/oob-drivers/dma/
>> > >> >> >>=20
>> > >> >> >> This is part of the EVL core documentation, but this is actua=
lly a
>> > >> >> >> Dovetail feature.
>> > >> >> >>=20
>> > >> >> >
>> > >> >> > Well, that's quite what I want to do, so this is very good new=
s that it is already available in the future. However, I need it through th=
e ipipe right now, but I guess the process stays the same (through patching=
 the dmaengine API and the DMA engine driver).
>> > >> >> >
>> > >> >> > I would guess the modifications to the DMA engine driver would=
 be then easily ported to dovetail ?
>> > >> >> >
>> > >> >>=20
>> > >> >> Since they should follow the same pattern used for the controlle=
rs
>> > >> >> Dovetail currently supports, I think so. You should be able to s=
implify
>> > >> >> the code when porting it Dovetail actually.
>> > >> >>=20
>> > >> >
>> > >> > That's what I thought. Thanks a lot.
>> > >> >
>> > >> > So now, regarding the "to userland memory" aspect. I guess I will=
 somehow have to, in order to make this happen, change the PTE flags to mak=
e these pages non cacheable (using dma_map_page maybe), but I wonder if I h=
ave to map the userland pages to kernel space and whether or not I have to =
pin the userland pages in memory (I believe mlockall in the userland proces=
s does that already) ?
>> > >> >
>> > >>=20
>> > >> The out-of-band SPI support available from EVL illustrates a possib=
le
>> > >> implementation. This code [2] implements what is described in this =
page
>> > >> [1].
>> > >>=20
>> > >
>> > > Thanks for the example. I think what I'm trying to do is a little di=
fferent from this however.
>> > > For the records, this is what I do (and that seems to be working) :>=
 > - as soon as user land buffers are allocated, tell the driver to pin the=
 user land buffer pages in memory (with get_user_pages_fast). I'm not sure =
if this is required, as I think mlockall in the app would already take care=
 of that.
>> > > - whenever I need to transfer data to the user land buffer, instruct=
 the driver to dma remap those user land pages (with dma_map_page), then in=
struct the DMA controller of the physical address of these pages.
>> > > et voil=C3=A0
>> > >
>> > > This seem to work correctly and repeatedly so far.
>> > >
>> >=20
>> > Are transfers controlled from the real-time stage, and if so, how do y=
ou
>> > deal with cache maintenance between transfers?
>>=20
>> That is my next problem to fix. It seems, as long as I run the test prog=
ram in the debugger, displaying the buffer filled by the DMA in GDB, everyt=
hing is fine. When GDB get's out of the way, I seem to read data that got i=
n the D cache before the DMA did the transfer.
>> I tried adding a flush_dcache_range before trigging the DMA, but it did =
not help.
>>=20
>> Any suggestion ?
>>=20
>> Thanks
>>=20
>> Fran=C3=A7ois
>>=20
>
> So I dug deep into the kernel cache management code for my (arm v7) arch,=
 but could not find an answer nor a solution.
> I now wonder whether or not this (DMA to user land memory) is possible on=
 this arch at all because of what is suggested in [1] even if that's a bit =
old.
>
> I saw that flush_dcache_range on armv7 is quite a noop, I tried with dmac=
_flush_range (which does the real thing with CP15), passing either the user=
 land virtual address directly or first getting a kernel mapping with kmap_=
atomic but that did not change anything. I still, most of the time, get the=
 first 2 cache line of data in the user land application wrong after the DM=
A transfer is done.
>
> I'm not sure where to look at next.
>

DMA to userland memory is a non-issue in the regular in-band
context. The problem starts with cache maintenance when you want to run
these I/O requests from the oob stage, hence my previous question.

The rule of thumb is that a driver should not fiddle with the innards of
cache maintenance directly, and certainly not with flush_dcache_range()
and friends. This includes Xenomai drivers. The DMA API hides these
details in a portable way, typically the DMA streaming API would clean
and/or invalidate the cache(s) layers when mapping, unmapping buffers.

Problem: we may not use the regular DMA API from oob context.  For
instance, if some IOMMU is involved, or bounce buffers of some sort
exist, or complex cache management layers in the kernel are traversed in
general (e.g. some outer L2 caches are ugly), then things might get
pretty nasty if this rule is not followed. For this reason, if using
coherent memory is practical performance-wise for the use case, then
this is a sane option for oob I/O, and you can do that as illustrated by
the example I referred to.

In this case, the kernel should allocate a suitable chunk of coherent
memory for your application to perform I/O, not your application
requesting common cached memory from its address space to be pinned and
used for DMA.

--=20
Philippe.

