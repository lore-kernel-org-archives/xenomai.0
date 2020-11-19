MIME-Version: 1.0
References: <CAFZ-hKizgaCMi5=P-WifrfiBSLNdrOs_TAke++MVCi2j=xYfiQ@mail.gmail.com>
 <0b9b2349-1a10-db7d-5c4a-1f58add978b3@siemens.com>
 <CAFZ-hKjf2Bha=doOBcup+tAzCHmF1SYq6LT2mC3bkZ1hYu97+g@mail.gmail.com>
 <6ae59753-ac6a-2960-e76c-977226ece20e@siemens.com>
In-Reply-To: <6ae59753-ac6a-2960-e76c-977226ece20e@siemens.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Thu, 19 Nov 2020 09:47:31 +0100
Message-ID: <CAFZ-hKjYAmYYrmvCrFr-Vf=gmcn8n6hfAn1L6QygYC8sJp=87w@mail.gmail.com>
Subject: Re: socket: Address family not supported by protocol
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

I understand so you advise me to forget the Raspberry  and try on a normal
PC?

Il gio 19 nov 2020, 09:41 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:

> On 19.11.20 09:24, Leandro Bucci wrote:
> > I don't know, because I used a guide that did everything automatically
> > (it was a script).  is this:
> >  https://github.com/thanhtam-h/rpi4-xeno3/tree/master/prebuilt
> > <https://github.com/thanhtam-h/rpi4-xeno3/tree/master/prebuilt>
> > in case how should I load those modules?
>
> E.g. "modprobe xeno_rtipc-xddp". If that fails, you should talk to the
> folks doing that pre-integration.
>
> Eventually, we may provide RPi4 preintegration via xenomai-images as
> well, but that requires the RPi mess to be upstream first. For
> Jailhouse, I'm maintaining an extra kernel for the RPi4, but those
> patches are much less invasive than I-pipe/Dovetail are, and that is
> already quite some effort.
>
> Jan
>
> >
> > Il gio 19 nov 2020, 08:08 Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> ha scritto:
> >
> >     On 18.11.20 22:51, Leandro Bucci via Xenomai wrote:
> >     > Hello to all. I have installed xenomai 3.1 on the raspberry pi4.
> >     > The latency and cyclictest examples work great. But examples like
> >     > iddp-label and xddp-echo don't work.
> >     > I get this error:
> >     > socket: Address family not supported by protocol
> >     > how can i solve this problem? maybe i need to load the related
> kernel
> >     > modules? If yes, how do you do it? sorry but I'm a beginner.
> >     >
> >
> >     Did you configure these features into your kernel
> >     (CONFIG_XENO_DRIVERS_RTIPC_IDDP, CONFIG_XENO_DRIVERS_RTIPC_XDDP)? Did
> >     you load the related modules if they were configured as modules
> >     (xeno_rtipc-{xddp,iddp}.ko)?
> >
> >     Jan
> >
> >     --
> >     Siemens AG, T RDA IOT
> >     Corporate Competence Center Embedded Linux
> >
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
