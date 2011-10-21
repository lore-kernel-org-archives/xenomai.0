Message-ID: <4EA19A9D.1080502@domain.hid>
Date: Fri, 21 Oct 2011 18:15:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>
In-Reply-To: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_task_wait_period returns an undocumented value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVybmFuZG8gSGVycmVybyBDYXJyw7Nu?= <elferdo@domain.hid>
Cc: Xenomai-help@domain.hid

On 10/21/2011 06:04 PM, Fernando Herrero Carr=C3=B3n wrote:
> Dear list,
>=20
> I am running xenomai-2.6-rc4 on an amd64 linux kernel version 2.6.38.8.=

>=20
> I am setting up a periodic task using
>=20
> rt_task_set_periodic(NULL, TM_NOW, 11500);
>=20
> For period values smaller than 11450 I get an EINVAL return value. I've=
 got
> one question regarding this, and it's how is this threshold calculated?=


See:
http://www.xenomai.org/documentation/trunk/html/api/group__pod.html#gaed5=
776a428e7c59b52b1da76f0d765fa

>=20
> However, further down the program, supposing rt_task_set_periodic() fai=
led
> with the above result, calling
>=20
> rt_task_wait_period()
>=20
> will return EAGAIN, which is not documented in
> http://www.xenomai.org/documentation/trunk/html/api/group__task.html#ga=
1645d3a072ef3cefeed3bcbb27dcf108
> .

That is because glibc choose to have EWOULDBLOCK =3D=3D EAGAIN. And=20
EWOULDBLOCK is documented.

--=20
					    Gilles.


