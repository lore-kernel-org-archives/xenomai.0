References: <87v93rjb2o.fsf@xenomai.org> <1202-6128ec80-1e5-1ab27320@266372968>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Doing DMA from peripheral to userland memory
In-reply-to: <1202-6128ec80-1e5-1ab27320@266372968>
Date: Fri, 27 Aug 2021 15:54:21 +0200
Message-ID: <87r1efj8mq.fsf@xenomai.org>
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

> Le Vendredi, Ao=C3=BBt 27, 2021 15:01 CEST, Philippe Gerum <rpm@xenomai.o=
rg> a =C3=A9crit:=20
>=20=20
>>=20
>> Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:
>>=20
>> > Hello,
>> >
>> > working on a zynq7000 target (arm cortex a9), we have a peripheral tha=
t generates loads of data (many kbytes per ms).
>> >
>> > We would like to move that data, directly from the peripheral memory (=
the OCM of the SoC) directly to our RT application user memory using DMA.
>> >
>> > For one part of the data, we would like the DMA to de interlace that d=
ata while moving it. We figured out, the PL330 peripheral on the SoC should=
 be able to do it, however, we would like, as much as possible, to retain t=
he use of one or two channels of the PL330 to plain linux non RT use (via d=
maengine).
>> >
>> > My first attempt would be to enhance the dmaengine API to add RT API, =
then implement the RT API calls in the PL330 driver.
>> >
>> > What do you think of this approach, and is it achievable at all (DMA d=
irectly to user land memory and/or having DMA channels exploited by xenomai=
 and other by linux) ?
>> >
>> > Thanks in advance
>> >
>> > Fran=C3=A7ois
>>=20
>> As a starting point, you may want to have a look at this document:
>> https://evlproject.org/core/oob-drivers/dma/
>>=20
>> This is part of the EVL core documentation, but this is actually a
>> Dovetail feature.
>>=20
>
> Well, that's quite what I want to do, so this is very good news that it i=
s already available in the future. However, I need it through the ipipe rig=
ht now, but I guess the process stays the same (through patching the dmaeng=
ine API and the DMA engine driver).
>
> I would guess the modifications to the DMA engine driver would be then ea=
sily ported to dovetail ?
>

Since they should follow the same pattern used for the controllers
Dovetail currently supports, I think so. You should be able to simplify
the code when porting it Dovetail actually.

--=20
Philippe.

