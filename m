Message-ID: <4EE5C121.70104@domain.hid>
Date: Mon, 12 Dec 2011 09:53:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EE1C949.2030404@domain.hid> <4EE27819.4050000@domain.hid>
	<4EE5BE9F.4060706@domain.hid>
In-Reply-To: <4EE5BE9F.4060706@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Novice - help needed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Damir Anicic <Damir.Anicic@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 12/12/2011 09:43 AM, Damir Anicic wrote:
> Thanx, that worked, except it is  -fno-omit-frame-pointer   (without s =

> at the end)
>=20
> I have another problem now - trying examples/posix :
>=20
>  >>> make ARCH=3Dx86 all
> make -C /lib/modules/2.6.38.8-xenomai/build ARCH=3Dx86 CROSS_COMPILE=3D=
=20
> SUBDIRS=3D/home/anicic/ttt/posix modules
> make[1]: Entering directory `/home/anicic/Xenomai/linux-2.6.38.8'
>   CC [M]  /home/anicic/ttt/posix/satch.o
> /home/anicic/ttt/posix/satch.c: In function =E2=80=98__xeno_user_init=E2=
=80=99:
> /home/anicic/ttt/posix/satch.c:296:5: warning: =E2=80=98pthread_create=E2=
=80=99 is=20
> deprecated (declared at=20
> /lib/modules/2.6.38.8-xenomai/build/include/xenomai/posix/pthread.h:270=
)=20
> [-Wdeprecated-declarations]
>   Building modules, stage 2.
>   MODPOST 1 modules
> WARNING: "pse51_shm_close" [/home/anicic/ttt/posix/satch.ko] undefined!=

> WARNING: "mmap" [/home/anicic/ttt/posix/satch.ko] undefined!
> WARNING: "ftruncate" [/home/anicic/ttt/posix/satch.ko] undefined!
> WARNING: "shm_open" [/home/anicic/ttt/posix/satch.ko] undefined!
> WARNING: "shm_unlink" [/home/anicic/ttt/posix/satch.ko] undefined!
> WARNING: "munmap" [/home/anicic/ttt/posix/satch.ko] undefined!
>   CC      /home/anicic/ttt/posix/satch.mod.o
>   LD [M]  /home/anicic/ttt/posix/satch.ko
> make[1]: Leaving directory `/home/anicic/Xenomai/linux-2.6.38.8'
> rm -f *.o
>=20
>  >>> sudo insmod satch.ko
> insmod: error inserting 'satch.ko': -1 Unknown symbol in module
>=20
>  >>> dmesg
> [ 3988.840669] satch: Unknown symbol munmap (err 0)
> [ 3988.840739] satch: Unknown symbol shm_open (err 0)
> [ 3988.840990] satch: Unknown symbol pse51_shm_close (err 0)
> [ 3988.841138] satch: Unknown symbol ftruncate (err 0)
> [ 3988.841204] satch: Unknown symbol mmap (err 0)
> [ 3988.841527] satch: Unknown symbol shm_unlink (err 0)

These are posix shared memory services. They are probably not enabled in
your kernel configuration.

Please no private mails.

--=20
                                                                Gilles.


