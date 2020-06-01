MIME-Version: 1.0
References: <5ed4bf2d.1c69fb81.29f0f.b36cSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5ed4bf2d.1c69fb81.29f0f.b36cSMTPIN_ADDED_BROKEN@mx.google.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 1 Jun 2020 09:51:28 -0400
Message-ID: <CALLqZ8QXO7zg7a7qAFkSSHnY9jcv2bQs3L+cWNomYqBFS=Kz2A@mail.gmail.com>
Subject: Re: an xhci problem on raspberry pi 4b
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: chensong <chensong@tj.kylinos.cn>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Mon, Jun 1, 2020 at 4:41 AM chensong via Xenomai <xenomai@xenomai.org> wrote:
>
> hi guys,
>
> I have a raspberry pi 4b and i have had xenoami running on it. Here is
> what i did:
>
I don't think anyone has tried this yet, so you are one of the first :)

> 1,git clone https://github.com/raspberrypi/linux.git
> 2,git checkout -b rpi-4.19.y remotes/origin/rpi-4.19.y
> 3,./xenomai3.1-devel/scripts/prepare-kernel.sh --arch=arm64
> --linux=rpi-kernel
> --ipipe=./nudt-hgj-xenomai-tjrd/scripts/prepare-kernel.sh --arch=arm64

What ipipe patch are you using?

> --linux=rpi-kernel
> 4,make bcm2711_xeno_defconfig
> 5,make
>
I'm not sure if the rpi4 is in mainline yet but you may have more
success trying this with the mainline kernel


> As a result, usb is not working appropriately, there is no input devices
> and sometimes system is hanging there when connecting an usb device.
>
> Has anyone managed to enable xenomai on rspberry pi 4b? Can you
> reporduce this problem and how is it fixed? Please help, many thanks.

If you use a serial terminal can you open a shell?
>
> BR
>
> chensong
>
>
-Greg
>

