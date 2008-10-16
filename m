Message-ID: <48F7302D.8050105@domain.hid>
Date: Thu, 16 Oct 2008 14:14:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0155D72A@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0155D72A@ARVMAIL1.mra.roland-man.biz>
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
>> -----Urspr=FCngliche Nachricht-----
>> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
>> Gesendet: Donnerstag, 16. Oktober 2008 11:48
>> An: Wildenburg, Roderik RAEK3 MRA
>> Cc: xenomai@xenomai.org
>> Betreff: Re: [Xenomai-help] how to build a Xenomai posix library ?
>>
>> roderik.wildenburg@domain.hid wrote:
>>> I did so and called, within the library, every=20
>> posix_rt-function with
>>> the prefix __wrap_ : e.g. __wrap_shm_open then I compiled my
>>> application, which does not use any Xenomai-function, and linked it
>>> with pthread_rt an rt (-lpthread_rt -lrt) and my new Xenomai-library
>>> (linking without any wrapping defined). Linking and=20
>> compiling did not
>>> produce any error. But, when I call a function in my library, which
>>> in turn calls __wrap_shm_open, then shm_open fails. When I link my
>>> application with wrapping (as provided by the XENO_CONFIG-script)
>>> then everything is fine. Do you have an explanation for=20
>> this behavior
>>> or even better a solution ?
>> __wrap_shm_open only works if you have the CONFIG_XENO_OPT_POSIX_SHM
>> option enabled. Is it enabled?
>=20
> yes it is :=20
> CONFIG_XENO_OPT_POSIX_SHM=3Dy
> otherwise, I think, my application linked with wrappings defined wouldn=
=B4t work ? But it does.
>=20
>> Note that xenomai posix skin shm support
>> is mainly useful for sharing memory between kernel and=20
>> user-space.=20
> O.k., I just want to share SHM between applications. What SHM construct s=
hould I use instead ?
>=20
>> If it is enabled, then please tell us what is the value of errno when
>> __wrap_shm_open fails.
>>
>=20
> shm_open fails. errno=3D2
> shm_open fails : : No such file or directory
>=20
> I don=B4t know what this should mean ??

Well, it means that the shared memory does not exist.

> I call shm_open in the following way :
> #define LOGSHMNAME   "/var/logshm"
> oflags=3DO_RDWR;
> *shmfd =3D shm_open(LOGSHMNAME, oflags, 0);

a shm name should contain one slash at the beginning and no other slash,
for best portability.
If you want to create a shared memory, you should pass the O_CREAT flag.

This is all documented here:

http://www.xenomai.org/documentation/trunk/html/api/group__posix__shm.html#=
gf765a0fa9152fbf874436c966f3af7ba

--=20
                                                 Gilles.

