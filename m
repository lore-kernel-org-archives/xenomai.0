References: <CAA09Y8RZo_QUN_ncm7UighfkC9imE68FsnZx=M__pQbX9K_j=A@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: SPI
Date: Thu, 09 Jun 2022 13:50:19 +0200
In-reply-to: <CAA09Y8RZo_QUN_ncm7UighfkC9imE68FsnZx=M__pQbX9K_j=A@mail.gmail.com>
Message-ID: <878rq6vyw6.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Davide Valeri <engineervalide@gmail.com>
Cc: Roberto Ferri <ironsnetwork@gmail.com>, xenomai@xenomai.org


Davide Valeri <engineervalide@gmail.com> writes:

> Hi!
> We need your help once more.
> We cannot enable SPI in the built kernel. Neither "sudo raspi-config"
> nor manually editing "config.txt" worked.
>
> Using "raspi-config" results in
> "mount: /config/device-tree: mount point does not exist
> * Failed to mount configfs - 2"
>
> Commit linux-evl: 81e5b7be.
>
> We're using the bcm2711_defconfig provided by [1].
> We tried the kernel from the repository in [1] and we were able to enable SPI.
>
> Do you experience something like this?
>
> Davide Valeri
>
> [1] https://github.com/raspberrypi/linux/blob/rpi-5.15.y/arch/arm64/configs/bcm2711_defconfig
> (commit: 9b573727)

This is not an EVL issue. Google has a match for this it seems:
https://forums.gentoo.org/viewtopic-t-1104786-start-0.html

-- 
Philippe.

