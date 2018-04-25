MIME-Version: 1.0
In-Reply-To: <lh74n2pg893hlqlq0lo8j8t0.1524652457846@embeddedgreg.com>
References: <B4C4C988-263B-479A-92A8-71C47B8CA7A1@icloud.com>
 <lh74n2pg893hlqlq0lo8j8t0.1524652457846@embeddedgreg.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 25 Apr 2018 16:25:55 +0530
Message-ID: <CAOuPNLg8gDaw=g5r3MDka5BSC4a4bOyw6Zv+hg=MOYfN=bpoyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] question on installing xenomai 3 on raspberry pi 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Yuan Dai <yuan.dai24@icloud.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Sometime back I have given a presentation about "Tizen bring up on
Raspberry Pi 2".
https://elinux.org/images/7/78/Pkumar.pdf

Here I have described about how to replace the kernel image on rpi2.
Please refer to slide:22,23

Hope this method should work even on rpi3 as well.


Thanks,
Pintu


On Wed, Apr 25, 2018 at 4:04 PM, Greg Gallagher <greg@embeddedgreg.com> wro=
te:
>
> Usually on pi the kernel image is called kernel.img, kernel7.img or kerne=
l8.img unless otherwise specified in your config.txt file. You can either r=
ename your zimage to kernel.img (or similar) or add kernel=3DzImage in your=
 config.txt.
>
> https://www.raspberrypi.org/documentation/configuration/config-txt/boot.m=
d
>
> This may also be different in you are using uboot to load the kernel. I'm=
 assuming you are using the raspberry Pi bootloader only.
>
> Greg
>
>
>   Original Message
> From: yuan.dai24@icloud.com
> Sent: April 25, 2018 3:16 AM
> To: xenomai@xenomai.org
> Subject: [Xenomai] question on installing xenomai 3 on raspberry pi 3
>
> Hi
>
> I am trying to install xenomai 3 on raspberry pi 3B and would like to kno=
w where exactly should I put the compiled kernel image on the SD card.
>
> I have downloaded xenomai v.3.0.2
> compiled the kernel by
> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- zImage modules dtbs
> Now I just need to copy the zImage and the device tree to the microSD car=
d.
>
> But whether I copied to
> sudo cp arch/arm/boot/zImage /boot/
> or I tried to copy to
> sudo cp arch/arm/boot/zImage /media/${USER}/boot
> I cannot get a successful reboot from the new Kernel image.
>
> I will either get a black screen after I restart the computer or get a wa=
rning after sometime for a normal boot.
> The error code is like this
> end kernel panic : attempted to kill init! Exitcode =3D0x000000b=E2=80=93=
not syncing
>
> I believe this is not a xenomai problem but rather a kernel compiling iss=
ue or even a SD issue. But I have tried several ways by searching online an=
d have not had any luck yet. Please let me know if you have any suggestions=
 or webpage that I can refer to. Thank you so much for your time!
>
> Best,
> Yuan
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

