Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] error after timeout on serial port
Date: Fri, 23 Feb 2007 16:16:34 +0100
Message-ID: <AD78122AD7C05B4B936EBAD7F49738C0AB2BA1@domain.hid>
In-Reply-To: <45DEFF7D.6080507@domain.hid>
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2BA0@domain.hid>
	<45DEFF7D.6080507@domain.hid>
From: "Lauener Nathan" <Nathan.Lauener@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

Thank you for your advice. After receiving a timeout I didn't set the =
size again before calling rt_dev_read(). It now works smoothly. Thanks =
again.

Nathan =20

-----Urspr=FCngliche Nachricht-----
Von: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Gesendet: Freitag, 23. Februar 2007 15:52
An: Lauener Nathan
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] error after timeout on serial port

Lauener Nathan wrote:
> Hi,
>=20
> I am polling on a serial port during an init sequence of a positioning =

> device. Every once in a while I get a return code indicating that a=20
> timeout occured, code -110 (ETIMEDOUT). After a timeout occured I=20
> can't read the port anymore. Whenever I call rt_dev_read() again the=20
> function returns the error code -14 (EFAULT). Is there a flag I must=20
> clear to get the port operatioanl again?

I /tend/ to say it's an application bug, because we are using the driver =
heavily, and our sluggish devices often cause timeouts during setup.
Some colleague should have already slapped me otherwise. :)

Are you sure that a valid buffer and a valid size is passed to =
rt_dev_read after the timeout (because those should be the reason for =
EFAULT)? If yes, maybe you can post a simple demo for the effect.

Jan


