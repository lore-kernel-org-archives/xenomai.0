MIME-Version: 1.0
References: <CAEmXcAwXBxZp9KcRyMs9J08nLKnwkYn13BuWPKTZ-pb6m95chg@mail.gmail.com>
 <b88d839c-eb9f-8712-eb47-5a5fc12cbf17@siemens.com>
 <CAEmXcAxMWcK1wsTQFJ2uQpJ1yjQiyfhoB5C-O=-bh-FTinNMjg@mail.gmail.com>
 <0fd69e88-c0db-f9ef-c8a1-b5d25afe917f@siemens.com>
 <CAEmXcAw+c-nBfMWRpU4yT_GbczRwwGCk=MFKh-g1F_tzwRytLQ@mail.gmail.com>
 <80b77618-4a1f-5554-1dfd-aa2369b3252f@siemens.com>
 <CAEmXcAzd3P9DkRHVbtvzgB_J52gUtaVd19h8=r-VL4frp0Gm3Q@mail.gmail.com>
 <CAEmXcAyPAnDa2OhQn-JoZo3cY6HN9BtBdtNAr5i0hpQ0UPvpZg@mail.gmail.com>
 <64f13545-b3a8-3c5d-1b0e-b953515f0f12@siemens.com>
 <CAEmXcAw_Qek1jEguriG51MKoosN2QOVuAOHSjkW0j43rinryHA@mail.gmail.com>
 <d74187a6-761f-4fd8-bf5a-bf72f58b6fd9@siemens.com>
 <CAEmXcAypMd=+XLd7iiy0vgFZmB2hYzPp4VpvTV24w+SSY_OSxQ@mail.gmail.com>
 <a63f3370-fa4d-32e8-33c3-8fb6da24841d@siemens.com>
 <CAEmXcAzO0+OfMM2UuvXWr5K=KHwrTz1UQa7-YEF85g48VGmbdQ@mail.gmail.com>
 <6846d8f8-3d03-58e2-40c8-73ac3d1da964@siemens.com>
In-Reply-To: <6846d8f8-3d03-58e2-40c8-73ac3d1da964@siemens.com>
From: danwe <daniel.wenninger92@gmail.com>
Date: Wed, 24 Jul 2019 12:27:31 +0200
Message-ID: <CAEmXcAw-9rpc7C+4VeJxQM5dxhYgPAhw=j+_xvmuSqAdtKaTgg@mail.gmail.com>
Subject: Re: TDMA with RTnet on Xenomai
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

One more question if it's okay.
I heard that you were one of the original author of that driver :D.
But nonetheless: One question about Xenomai with RTnet. You do need a
driver for RTnet working on Xenomai, right? And if you are using a
microcomputer like BealgeBone Black you do need a driver for RTnet working
on Xenomai on that BeagleBone Black. So if you change microcomputer or
Xenomai version to Xenomai 3, then that driver will be useless. Is that
correct?

Do those drivers need to be specially for BeagleBone Black or for the
AM225x processor on the BeagleBone Black. As many microcomputers use the
same processor, would nee driver work for all of them or does each
microcomputer need to have a specially driver?

And as I see on my distribution I do only have bbb_xeno_rtnet configuration
files. Do you know if those configurations files are the driver.. or? I
have files like bbb_xeno_rtnet_devconfig, bbb_xeno_rtnet_light_defconfig,
bbb_rtnet_defconfig. Or should the driver be one c-code?

Thanks again.

Daniel

Am Mi., 24. Juli 2019 um 11:22 Uhr schrieb Jan Kiszka <
jan.kiszka@siemens.com>:

> On 24.07.19 11:08, danwe wrote:
> >
> >
> > Am Mi., 24. Juli 2019 um 10:57 Uhr schrieb Jan Kiszka <
> jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>>:
> >
> >     On 24.07.19 10:45, danwe wrote:
> >     > RTnet starts at each boot with script "S51rtnet". I can also stop
> and start
> >     > rtnet by myself. See the output: I have to start rtnet with the
> script
> >     S51rtnet.
> >     >
> >     > # /usr/sbin/rtnet -cf /etc/rtnet.conf stop
> >     > [  328.192316] RTmac/TDMA: unloaded
> >     > [  328.200527] RTmac: unloaded
> >     > [  328.205608] RTcfg: unloaded
> >     > # /usr/sbin/rtnet -cf /etc/rtnet.conf -v start
> >     > Turning on verbose mode
> >     > insmod: can't insert '/lib/modules/3.8.13-xeno/kernel/rtnet.ko':
> File exists
> >
> >     Ah, you are on legacy, out-of-tree RTnet! I forgot that RTnet only
> moved into
> >     Xenomai for version 3.0. For 2.x, you are with the old repo that
> wasn't touched
> >     since 2013. In this particular case, the script fails early because
> of "insmod
> >     <existing-module>", rather than using "modprobe" like in Xenomai
> upstream.
> >
> >     You may run in many more such issues that have been fixed since
> then, and you
> >     will be on your own there now. You really need to update to Xenomai
> 3.
> >
> > Oh okay. I am using Xenomai 2.x because of drivers for network adapter
> for
> > BeagleBone Black. I heard that RTnet is only working on Xenomai 2.x with
> these
> > drivers for network adapters. Do you know if there are any drivers for
> network
> > adapter for BeagleBone Black with Xenomai 3 and RTnet?
>
> Nope, there is nothing in-tree. If you have a driver already, you can try
> to
> port it to the newer version. When lucky, it's only about resolving some
> smaller
> build issues. Or reach out to the original author of that driver and ask
> for
> support.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
