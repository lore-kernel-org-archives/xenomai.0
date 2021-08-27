References: <87r1efj8mq.fsf@xenomai.org> <10a0-6128f200-125-29fb8780@204573282>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Doing DMA from peripheral to userland memory
In-reply-to: <10a0-6128f200-125-29fb8780@204573282>
Date: Fri, 27 Aug 2021 16:36:28 +0200
Message-ID: <87o89jj6oj.fsf@xenomai.org>
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

> Le Vendredi, Ao=C3=BBt 27, 2021 15:54 CEST, Philippe Gerum <rpm@xenomai.o=
rg> a =C3=A9crit:=20
>=20=20
>>=20
>> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>>=20
>> > Le Vendredi, Ao=C3=BBt 27, 2021 15:01 CEST, Philippe Gerum <rpm@xenoma=
i.org> a =C3=A9crit:=20
>> >=20=20
>> >>=20
>> >> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:
>> >>=20
>> >> > Hello,
>> >> >
>> >> > working on a zynq7000 target (arm cortex a9), we have a peripheral =
that generates loads of data (many kbytes per ms).
>> >> >
>> >> > We would like to move that data, directly from the peripheral memor=
y (the OCM of the SoC) directly to our RT application user memory using DMA.
>> >> >
>> >> > For one part of the data, we would like the DMA to de interlace tha=
t data while moving it. We figured out, the PL330 peripheral on the SoC sho=
uld be able to do it, however, we would like, as much as possible, to retai=
n the use of one or two channels of the PL330 to plain linux non RT use (vi=
a dmaengine).
>> >> >
>> >> > My first attempt would be to enhance the dmaengine API to add RT AP=
I, then implement the RT API calls in the PL330 driver.
>> >> >
>> >> > What do you think of this approach, and is it achievable at all (DM=
A directly to user land memory and/or having DMA channels exploited by xeno=
mai and other by linux) ?
>> >> >
>> >> > Thanks in advance
>> >> >
>> >> > Fran=C3=A7ois
>> >>=20
>> >> As a starting point, you may want to have a look at this document:
>> >> https://evlproject.org/core/oob-drivers/dma/
>> >>=20
>> >> This is part of the EVL core documentation, but this is actually a
>> >> Dovetail feature.
>> >>=20
>> >
>> > Well, that's quite what I want to do, so this is very good news that i=
t is already available in the future. However, I need it through the ipipe =
right now, but I guess the process stays the same (through patching the dma=
engine API and the DMA engine driver).
>> >
>> > I would guess the modifications to the DMA engine driver would be then=
 easily ported to dovetail ?
>> >
>>=20
>> Since they should follow the same pattern used for the controllers
>> Dovetail currently supports, I think so. You should be able to simplify
>> the code when porting it Dovetail actually.
>>=20
>
> That's what I thought. Thanks a lot.
>
> So now, regarding the "to userland memory" aspect. I guess I will somehow=
 have to, in order to make this happen, change the PTE flags to make these =
pages non cacheable (using dma_map_page maybe), but I wonder if I have to m=
ap the userland pages to kernel space and whether or not I have to pin the =
userland pages in memory (I believe mlockall in the userland process does t=
hat already) ?
>

The out-of-band SPI support available from EVL illustrates a possible
implementation. This code [2] implements what is described in this page
[1].

[1] https://evlproject.org/core/oob-drivers/spi/
[2] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/blob/0969ccef9a5318=
244e484e847dab52999f6fec5c/drivers/spi/spi.c#L4259

--=20
Philippe.

