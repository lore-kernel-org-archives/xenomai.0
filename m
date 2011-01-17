From: "Peter Hua" <Phua@domain.hid>
References: <007901cbb667$db66b860$92342920$@innovative-dsp.com>
	<4D3485AC.3070500@domain.hid>
In-Reply-To: <4D3485AC.3070500@domain.hid>
Date: Mon, 17 Jan 2011 10:43:24 -0800
Message-ID: <008f01cbb676$6c5420c0$44fc6240$@innovative-dsp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Xenomai-help] Xenomai mmap
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, pwfhua@domain.hid

It is here:

http://www.xenomai.org/documentation/xenomai-2.4/html/api/index.html

Peter


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Monday, January 17, 2011 10:09 AM
To: Peter Hua
Cc: xenomai@xenomai.org; pwfhua@domain.hid
Subject: Re: [Xenomai-help] Xenomai mmap

Peter Hua wrote:
> Is there any example code to map PCI registers into user space?  I am =
having
> problem getting functions rtdm_iomap_to_user and mmap to compile.   My =
code
> is attached. =20
>=20
> =20
>=20
> Xenomai - 2.4.10
>=20
> Kernel - 2.6.29.1
>=20
> OS - Red Hat 5.5

You will find the documentation of Xenomai 2.4.10 API here:
http://www.xenomai.org/documentation/xenomai-2.4/html/api/index.html

As you can see, it has no rtdm_iomap_to_user funtion.

--=20
                                                                Gilles.


