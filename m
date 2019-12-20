MIME-Version: 1.0
In-Reply-To: <5836c823-997e-8783-ace6-738e35963b2d@siemens.com>
References: <CAPm8-H43BUuTjCxqHf-NAK8M69eFrRz7j=ctPqX1OxNCMygRSQ@mail.gmail.com>
 <5836c823-997e-8783-ace6-738e35963b2d@siemens.com>
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Fri, 20 Dec 2019 13:27:20 +0200
Message-ID: <CAPm8-H5581tft0yQ9eSUFQ9KUq8vgAE+E4pc1DKUo-3065t5ug@mail.gmail.com>
Subject: Re: am335x omap4 beaglebone black spi rt driver
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

It is a fix for:
- spi_master_read_rt(): if master->ops->read() returns > 0,
then copy data to userspace;
and two contributions:
- add a user option in ioctl to be able to transfer a part of mmaped area
(and not all mmaped area every time)
tested with a personal test
this needs an official test (I did not study the source of spitest.c in detail)
- bbb spi rt driver - tested with spitest and the personal test

On 12/19/19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Thanks for the contribution!
>
> Some quick requests: First, please split up the changes to the SPI core
> and the addition of the new driver. Should give 2, if not 3 pieces in
> the end.
>
> Then is there a chance to extend testsuite/spitest/spitest.c in order to
> cover also the new interface (ioctl)?
>
> Last: There is the kernel's scripts/checkpatch.pl tool which can help
> with identifying small glitches in the patch format. Please apply this
> to keep our code (widely) consistent.
>
> Thanks,
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

