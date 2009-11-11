MIME-Version: 1.0
Sender: lcasassa@domain.hid
From: Linus Casassa <linus@domain.hid>
Date: Wed, 11 Nov 2009 18:37:26 -0300
Message-ID: <47a3101a0911111337q643dbe48m1dc5ee484f2c93a9@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd16e60ca5ee004781f3c4a
Subject: [Xenomai-help] RTDM Serial port Gumstix PXA270
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--000e0cd16e60ca5ee004781f3c4a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.

I am using open/read/write for a serial port. But the read function delays =
8
ms from the last bit received untill it returns the chars.

Obviously you would say open/read/write functions are not realtime
functions.

I changed open/read/write to rt_dev_open/rt_dev_read/rt_dev_write but the
open function returns -19.

I am using /dev/ttyS2.
Looking the proc directory I found that there is an interrupt on the serial
port I want to use: FFUART

root@domain.hid:~$ cat /proc/interrupts
           CPU0
  3:          2          SC  ohci_hcd:usb1
  6:          0          SC  pxa_i2c-i2c.1
 18:          0          SC  pxa_i2c-i2c.0
 22:         76          SC  FFUART
 23:        204          SC  pxa2xx-mci
 25:          0          SC  DMA
 26:     198061          SC  ost0
163:       4720        GPIO  eth0
Err:          0
root@domain.hid:~$

Thanks.

--=20
Linus Casassa
Estudiante Ingenier=EDa Civil Electr=F3nica
Fono: 56-9-97776941

--000e0cd16e60ca5ee004781f3c4a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.<br><br>I am using open/read/write for a serial port. But the read funct=
ion delays 8 ms from the last bit received untill it returns the chars.<br>=
<br>Obviously you would say open/read/write functions are not realtime func=
tions.<br>

<br>I changed open/read/write to rt_dev_open/rt_dev_read/rt_dev_write but t=
he open function returns -19.<br><br>I am using /dev/ttyS2.<br>Looking the =
proc directory I found that there is an interrupt on the serial port I want=
 to use: FFUART<br>

<br>root@domain.hid:~$ cat /proc/interrupts <br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 CPU0<br>=A0 3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 SC=A0 ohci_hcd:usb1<br>=A0 6:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 pxa_i2c-i2c.1<br>=A018:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 pxa_i2c-i2c.0<br>=A022:=A0=A0=A0=
=A0=A0=A0=A0=A0 76=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 FFUART<br>

=A023:=A0=A0=A0=A0=A0=A0=A0 204=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 pxa2xx-mci=
<br>=A025:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 DM=
A<br>=A026:=A0=A0=A0=A0 198061=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 ost0<br>163=
:=A0=A0=A0=A0=A0=A0 4720=A0=A0=A0=A0=A0=A0=A0 GPIO=A0 eth0<br>Err:=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0<br>root@domain.hid:~$ <br><br clear=3D"all"=
>

Thanks.<br><br>-- <br>Linus Casassa<br>Estudiante Ingenier=EDa Civil Electr=
=F3nica<br>Fono: 56-9-97776941<br>

--000e0cd16e60ca5ee004781f3c4a--

