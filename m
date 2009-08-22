Message-ID: <4A8FC200.2@domain.hid>
Date: Sat, 22 Aug 2009 12:01:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0AB95BFCF14F984980DE7149C21D6B90065D58B59F@FND-MAILB03.VIA.DK>	<1250242914.3019.6.camel@domain.hid>
	<0AB95BFCF14F984980DE7149C21D6B9006E8E3078C@FND-MAILB03.VIA.DK>
In-Reply-To: <0AB95BFCF14F984980DE7149C21D6B9006E8E3078C@FND-MAILB03.VIA.DK>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_mutex_acquire returns -3
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?IkhhbnMgU8O4bmRlcmdhYXJkIChIU08pIg==?= <HSO@VIAUC.DK>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hans S=C3=B8ndergaard (HSO) wrote:
> Thank you to both Gilles and Philippe.
> I followed the advises from you both:
> typedef struct object {
>   RT_MUTEX rt_lock;=20
>    ..=20
>  } Object;
>=20
> and used:
>   printf("%ld", ob->rt_lock.opaque);
> to see output.

So, what is the result? Did you find the bug?

--=20
					    Gilles.


