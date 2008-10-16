Message-ID: <48F73680.8020103@domain.hid>
Date: Thu, 16 Oct 2008 14:41:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0155D80B@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0155D80B@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] how to build a Xenomai posix library ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
>>>> roderik.wildenburg@domain.hid wrote:
>>> *shmfd =3D shm_open(LOGSHMNAME, oflags, 0);
>> a shm name should contain one slash at the beginning and no=20
>> other slash,
>> for best portability.
>=20
> As I expected, reducing the number of slashes to one does not change the =
behavior.

I never said it would.

>=20
>> If you want to create a shared memory, you should pass the=20
>> O_CREAT flag.
>=20
> As mentioned above, an other process creates the shared memory.

Is it also linked with xenomai posix skin?

> What I still don=B4t understand is, what influence the wrapper defines ha=
ve on linking.
> With wrappers : aplication works fine. Without wrappers : application doe=
s not work !?

I would say that with wrappers, you are in fact using the vanilla linux
shared memory, by passing __wrap_shm_open, you really use xenomai posix
skin services.

If that is the case, when using the wrapped version, you should see the
shared memory appear under /dev/shm.

--=20
                                                 Gilles.

