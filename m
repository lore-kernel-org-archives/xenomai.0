References: <87o89jj6oj.fsf@xenomai.org> <10a7-612df800-125-35a6e6c0@10227367>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Doing DMA from peripheral to userland memory
In-reply-to: <10a7-612df800-125-35a6e6c0@10227367>
Date: Tue, 31 Aug 2021 19:37:43 +0200
Message-ID: <877dg1ms60.fsf@xenomai.org>
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

> Le Vendredi, Ao=C3=BBt 27, 2021 16:36 CEST, Philippe Gerum <rpm@xenomai.o=
rg> a =C3=A9crit:=20
>=20=20
>>=20
>> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>>=20
>> > Le Vendredi, Ao=C3=BBt 27, 2021 15:54 CEST, Philippe Gerum <rpm@xenoma=
i.org> a =C3=A9crit:=20
>> >=20=20
>> >>=20
>> >> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>> >>=20
>> >> > Le Vendredi, Ao=C3=BBt 27, 2021 15:01 CEST, Philippe Gerum <rpm@xen=
omai.org> a =C3=A9crit:=20
>> >> >=20=20
>> >> >>=20
>> >> >> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:
>> >> >>=20
>> >> >> > Hello,
>> >> >> >
>> >> >> > working on a zynq7000 target (arm cortex a9), we have a peripher=
al that generates loads of data (many kbytes per ms).
>> >> >> >
>> >> >> > We would like to move that data, directly from the peripheral me=
mory (the OCM of the SoC) directly to our RT application user memory using =
DMA.
>> >> >> >
>> >> >> > For one part of the data, we would like the DMA to de interlace =
that data while moving it. We figured out, the PL330 peripheral on the SoC =
should be able to do it, however, we would like, as much as possible, to re=
tain the use of one or two channels of the PL330 to plain linux non RT use =
(via dmaengine).
>> >> >> >
>> >> >> > My first attempt would be to enhance the dmaengine API to add RT=
 API, then implement the RT API calls in the PL330 driver.
>> >> >> >
>> >> >> > What do you think of this approach, and is it achievable at all =
(DMA directly to user land memory and/or having DMA channels exploited by x=
enomai and other by linux) ?
>> >> >> >
>> >> >> > Thanks in advance
>> >> >> >
>> >> >> > Fran=C3=A7ois
>> >> >>=20
>> >> >> As a starting point, you may want to have a look at this document:
>> >> >> https://evlproject.org/core/oob-drivers/dma/
>> >> >>=20
>> >> >> This is part of the EVL core documentation, but this is actually a
>> >> >> Dovetail feature.
>> >> >>=20
>> >> >
>> >> > Well, that's quite what I want to do, so this is very good news tha=
t it is already available in the future. However, I need it through the ipi=
pe right now, but I guess the process stays the same (through patching the =
dmaengine API and the DMA engine driver).
>> >> >
>> >> > I would guess the modifications to the DMA engine driver would be t=
hen easily ported to dovetail ?
>> >> >
>> >>=20
>> >> Since they should follow the same pattern used for the controllers
>> >> Dovetail currently supports, I think so. You should be able to simpli=
fy
>> >> the code when porting it Dovetail actually.
>> >>=20
>> >
>> > That's what I thought. Thanks a lot.
>> >
>> > So now, regarding the "to userland memory" aspect. I guess I will some=
how have to, in order to make this happen, change the PTE flags to make the=
se pages non cacheable (using dma_map_page maybe), but I wonder if I have t=
o map the userland pages to kernel space and whether or not I have to pin t=
he userland pages in memory (I believe mlockall in the userland process doe=
s that already) ?
>> >
>>=20
>> The out-of-band SPI support available from EVL illustrates a possible
>> implementation. This code [2] implements what is described in this page
>> [1].
>>=20
>
> Thanks for the example. I think what I'm trying to do is a little differe=
nt from this however.
> For the records, this is what I do (and that seems to be working) :
> - as soon as user land buffers are allocated, tell the driver to pin the =
user land buffer pages in memory (with get_user_pages_fast). I'm not sure i=
f this is required, as I think mlockall in the app would already take care =
of that.
> - whenever I need to transfer data to the user land buffer, instruct the =
driver to dma remap those user land pages (with dma_map_page), then instruc=
t the DMA controller of the physical address of these pages.
> et voil=C3=A0
>
> This seem to work correctly and repeatedly so far.
>

Are transfers controlled from the real-time stage, and if so, how do you
deal with cache maintenance between transfers?

--=20
Philippe.

