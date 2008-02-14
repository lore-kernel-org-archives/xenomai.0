Message-ID: <47B45F5D.60509@domain.hid>
Date: Thu, 14 Feb 2008 16:33:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <mailman.5479.1202920211.28415.xenomai@xenomai.org>
	<47B415340200000100192592@domain.hid>
In-Reply-To: <47B415340200000100192592@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai-2.4.2 vs kernel-2.6.24 (i686)
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

Hubert Talbot wrote:
> Hi,
>=20
> I try to build kernel 2.6.24 with adeos-ipipe-2.6.24-x86-2.0-03.patch
> and I get this:
>=20
>   ...
>   AR      arch/x86/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86/kernel/built-in.o: In function `do_machine_check_vector':
> ipipe.c:(.text+0x128de): undefined reference to `do_machine_check'
> make[1]: *** [.tmp_vmlinux1] Erreur 1
> make[1]: quittant le r=E9pertoire * /usr/src/linux-2.6.24 *
> make: *** [debian/stamp-build-kernel] Erreur 2
>

It's a 64bit symbol only it seems. Disable CONFIG_X86_MCE for now, will
fix. Thanks.

> real	7m59.559s
> user	6m36.813s
> sys	0m40.419s
>=20
>=20
> Just to report the problem...
>=20
>=20
> Hubert
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.

