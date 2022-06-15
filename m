MIME-Version: 1.0
References: <CAA09Y8RZo_QUN_ncm7UighfkC9imE68FsnZx=M__pQbX9K_j=A@mail.gmail.com>
 <878rq6vyw6.fsf@xenomai.org>
In-Reply-To: <878rq6vyw6.fsf@xenomai.org>
From: Davide Valeri <engineervalide@gmail.com>
Date: Wed, 15 Jun 2022 15:53:19 +0200
Message-ID: <CAA09Y8RUK7_1XkdC1rk1LJ1OziCCk8-JBS6ycexnLjBHKnwNwQ@mail.gmail.com>
Subject: Re: SPI
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Roberto Ferri <ironsnetwork@gmail.com>, xenomai@xenomai.org

Hi!
Many thanks for your response, but unfortunately we're receiving the same error.

I was already using the config file as suggested from the resource you
provided, but still the compilation does not build the device trees
RPi4 needs.
So I compiled the official kernel source [1] (I tried with 5.15.45 [1]
and .44 [2]) to have the correct overlays. Then, I installed the
Xenomai modules and copied the Xenomai kernel. Still, I'm receiving
the same error from my previous email and cannot enable the SPI.

I noticed the same error after compiling [3], thinking it was the
right .44 kernel for RPi4. I don't know if it can be helpful.

Davide

[1] https://github.com/raspberrypi/linux
[2] https://github.com/raspberrypi/linux/tree/ea7fe1b21ea73146b1d49ac5f554fbd0ac5de9de
, "Merge remote-tracking branch 'stable/linux-5.15.y' into rpi-5.15.y"
[3] https://github.com/raspberrypi/linux/tree/4e67be407725b1d8b829ed2075987037abec98ec
, "Linux 5.15.44"

Il giorno gio 9 giu 2022 alle ore 13:50 Philippe Gerum
<rpm@xenomai.org> ha scritto:
>
>
> Davide Valeri <engineervalide@gmail.com> writes:
>
> > Hi!
> > We need your help once more.
> > We cannot enable SPI in the built kernel. Neither "sudo raspi-config"
> > nor manually editing "config.txt" worked.
> >
> > Using "raspi-config" results in
> > "mount: /config/device-tree: mount point does not exist
> > * Failed to mount configfs - 2"
> >
> > Commit linux-evl: 81e5b7be.
> >
> > We're using the bcm2711_defconfig provided by [1].
> > We tried the kernel from the repository in [1] and we were able to enable SPI.
> >
> > Do you experience something like this?
> >
> > Davide Valeri
> >
> > [1] https://github.com/raspberrypi/linux/blob/rpi-5.15.y/arch/arm64/configs/bcm2711_defconfig
> > (commit: 9b573727)
>
> This is not an EVL issue. Google has a match for this it seems:
> https://forums.gentoo.org/viewtopic-t-1104786-start-0.html
>
> --
> Philippe.

