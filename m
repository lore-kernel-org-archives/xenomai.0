Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<878wkkzxba.fsf@domain.hid>
	<9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 26 May 2009 00:10:14 +0200
In-Reply-To: <9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
	(Cristian Axenie's message of "Tue\,
	26 May 2009 00\:35\:49 +0300")
Message-ID: <871vqczveh.fsf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Cristian Axenie <cristian.axenie@domain.hid> writes:

> Hi,
>
> I finally figured out this aspect but I still have one problem, residing =
in the fact that I have no comedi devices in my dev list
> and so I cannot ./comedi_config /dev/comedi0 nipcimio !
>
> As I see it there are no comedi devices
>
> /usr/xenomai/sbin # cat /proc/devices

You should not look at there. This proc file lists everything but RTDM devi=
ces.

>
> and the list
>
> /usr/xenomai/sbin # cat /proc/comedi/devices
> --=C2=A0 Comedi devices --
>
> | idx | status | driver
> |=C2=A0 00 | Unused | No driver
> |=C2=A0 01 | Unused | No driver
> |=C2=A0 02 | Unused | No driver
> |=C2=A0 03 | Unused | No driver
> |=C2=A0 04 | Unused | No driver
> |=C2=A0 05 | Unused | No driver
> |=C2=A0 06 | Unused | No driver
> |=C2=A0 07 | Unused | No driver
> |=C2=A0 08 | Unused | No driver
> |=C2=A0 09 | Unused | No driver
> /usr/xenomai/sbin # cat /proc/comedi/drivers
> comedi_config=C2=A0=C2=A0 rtcanconfig=C2=A0=C2=A0=C2=A0=C2=A0 rtps
> /usr/xenomai/sbin # cat /proc/comedi/drivers
> --=C2=A0 Comedi drivers --
>
> | idx | driver name
> |=C2=A0 00 | pcimio
> |=C2=A0 01 | comedi_8255
> |=C2=A0 02 | comedi_loop
> |=C2=A0 03 | comedi_fake
>
> Shouldn't the specific comedi devices be generated when installing Xenoma=
i ?

That is common comedi behaviour. So far, the comedi drivers are listed,
they are available in the kernel. However, you have to attach them so as
to make them reachable (thanks to comedi_config).

Once the attach will be done, you will see your driver appear in
/proc/comedi/devices.

If the comedi_config did not work, the problem is here. In such case,
could you send the traces?

Alexis.

