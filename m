Message-ID: <4BB1287B.6020205@domain.hid>
Date: Tue, 30 Mar 2010 00:23:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507168.65506.qm@domain.hid>,
	<4BAF58F7.7070707@domain.hid>
	<B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
In-Reply-To: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem to cross-compile
	Xenomai	user-space	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Huan Fang <huanf@domain.hid>
Cc: Chtourou Sonda <chtourou_sonda@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Huan Fang wrote:
> eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm
> libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc -Wl,-elf2f=
lt -o check-vdso check_vdso-check-vdso.o  ../../skins/native/.libs/libnat=
ive.a -lpthread -lm
> check-vdso.elf2flt(.text+0x16c): In function `main':
> : undefined reference to `xeno_sem_heap'
> check-vdso.elf2flt(.text+0x170): In function `main':
> : undefined reference to `xeno_sem_heap'
> collect2: ld returned 1 exit status
> make[3]: *** [check-vdso] Erreur 1
> make[3]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenomai=
-2.5.1/src/testsuite/unit =C2=BB
> make[2]: *** [all-recursive] Erreur 1
> make[2]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenomai=
-2.5.1/src/testsuite =C2=BB
> make[1]: *** [all-recursive] Erreur 1
> make[1]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenomai=
-2.5.1/src =C2=BB
> make: *** [all-recursive] Erreur 1
>=20
> what can I do? Please help

Please try xenomai 2.5.2


--=20
					    Gilles.


