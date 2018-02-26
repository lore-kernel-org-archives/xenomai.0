MIME-Version: 1.0
In-Reply-To: <AM4PR0801MB1587343E7952DF08F44F7781F5C10@AM4PR0801MB1587.eurprd08.prod.outlook.com>
References: <CAOuPNLjwrgQu2wEd+pcNrcka6J9PJZJceh6UvhaXZy_tZ=8C0g@mail.gmail.com>
 <AM4PR0801MB1587343E7952DF08F44F7781F5C10@AM4PR0801MB1587.eurprd08.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 26 Feb 2018 09:38:24 -0500
Message-ID: <CALLqZ8R6cQJ6sem3-EcBJFp0e3BMBsEO6FMxm4zqurc4wg+_1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [RTDM/rt-serial] How to verify 16550A on Ubuntu
	desktop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

+1 for that solution, this link helped me when i was trying to unbind
the imx uart driver.

https://lwn.net/Articles/143397/

On Mon, Feb 26, 2018 at 8:24 AM, Johann Obermayr
<johann.obermayr@sigmatek.at> wrote:
> Hi,
>
> Take a look into the file /proc/tty/driver/serial
> Here you see all found uart and used linux driver and uart parameter (por=
t, irq,..)
>
> With follow function you can unbind the linux driver
>
> static int uart_unbind(int ttynr)
> {
>         char dev[64];
>         int fd;
>         struct serial_struct serinfo;
>
>         // do unbind
>         sprintf(dev, "/dev/ttyS%u", ttynr);
>         fd =3D open(dev, O_RDWR | O_NONBLOCK);
>         if (fd >=3D 0) {
>
>                 int ret =3D ioctl(fd, TIOCGSERIAL, &serinfo);
>                 if (ret =3D=3D 0) {
>                         serinfo.type =3D PORT_UNKNOWN;
>                         ret =3D ioctl(fd, TIOCSSERIAL, &serinfo);
>                 }
>                 close(fd);
>                 return ret;
>         }
>         return -EFAULT;
> }
>
> We are using the modular xeno_16550A driver
>
> And we are loading this with
>
> system("/sbin/modprobe xeno_16550A io=3D0x3F8 irq=3D4");
>
> better solution are welcome =F0=9F=98=89
>
> Regards
>   Johann
>
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Xenomai [mailto:xenomai-bounces@xenomai.org] Im Auftrag von Pintu
>> Kumar
>> Gesendet: Montag, 26. Februar 2018 11:59
>> An: Xenomai@xenomai.org; Jan Kiszka <jan.kiszka@web.de>; Philippe
>> Gerum <rpm@xenomai.org>; Greg Gallagher <greg@embeddedgreg.com>
>> Betreff: [Xenomai] [RTDM/rt-serial] How to verify 16550A on Ubuntu
>> desktop
>>
>> Hi,
>>
>> I have enabled RTDM serial driver 16550A in kernel and I am using it wit=
h x86-
>> 64 Ubuntu 16.04 desktop.
>> CONFIG_XENO_DRIVERS_16550A=3Dy
>> CONFIG_XENO_DRIVERS_16550A_PIO=3Dy
>>
>> Now I wanted to verify this driver using a sample application such as
>> : cross-link
>> But, when I check, the driver is not available under: /dev/rtdm/ (rtser0=
,
>> rtser1)
>>
>> Is it possible to use this RT serial driver on Ubuntu PC?
>> Please let me know how to install this driver and verify it.
>>
>> I wanted to modify some part in the driver and verify it.
>>
>> Need your initial support please!
>>
>>
>> Thanks,
>> Pintu
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fxe
>> nomai.org%2Fmailman%2Flistinfo%2Fxenomai&data=3D02%7C01%7Cjohann.o
>> bermayr%40sigmatek.at%7C2a831f53799d44bc0ec008d57d07f97f%7Cbcb1d8
>> 7ad2bc486ea62b9ac9c746bc1b%7C0%7C0%7C636552395567117346&sdata=3DW
>> crSRALRwjO590ZckkGOQm58MvTGd%2BT%2BxrW%2BQTFMw4g%3D&reser
>> ved=3D0
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

