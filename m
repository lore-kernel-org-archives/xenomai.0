References: <10a0-6128b080-11d-29fb8780@204571863>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Doing DMA from peripheral to userland memory
In-reply-to: <10a0-6128b080-11d-29fb8780@204571863>
Date: Fri, 27 Aug 2021 15:01:35 +0200
Message-ID: <87v93rjb2o.fsf@xenomai.org>
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


Fran=C3=A7ois Legal via Xenomai <xenomai@xenomai.org> writes:

> Hello,
>
> working on a zynq7000 target (arm cortex a9), we have a peripheral that g=
enerates loads of data (many kbytes per ms).
>
> We would like to move that data, directly from the peripheral memory (the=
 OCM of the SoC) directly to our RT application user memory using DMA.
>
> For one part of the data, we would like the DMA to de interlace that data=
 while moving it. We figured out, the PL330 peripheral on the SoC should be=
 able to do it, however, we would like, as much as possible, to retain the =
use of one or two channels of the PL330 to plain linux non RT use (via dmae=
ngine).
>
> My first attempt would be to enhance the dmaengine API to add RT API, the=
n implement the RT API calls in the PL330 driver.
>
> What do you think of this approach, and is it achievable at all (DMA dire=
ctly to user land memory and/or having DMA channels exploited by xenomai an=
d other by linux) ?
>
> Thanks in advance
>
> Fran=C3=A7ois

As a starting point, you may want to have a look at this document:
https://evlproject.org/core/oob-drivers/dma/

This is part of the EVL core documentation, but this is actually a
Dovetail feature.

--=20
Philippe.

