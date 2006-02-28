Message-ID: <440462AD.5050908@domain.hid>
Date: Tue, 28 Feb 2006 16:48:13 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] undefined
	reference	__xnarch_xchg_called_with_bad_pointer
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3DA2@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A1C3DA2@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid kirjoitti:
> Dear Gurus,
>=20
> I have compiled ppc(!)-xenomai with debug information (configure --enable=
-debug), so far so good (compiling of xenomai itself and it=B4s libraries, =
testsuite etc. was successful). =20
> Buuuut ..., when compiling the vxWorks-demos (ksrc/skins/vxworks/demos/*.=
c), I get an error message about an undefined refernce __xnarch_xchg_called=
_with_bad_pointer. I searched for this mysterious function, but could only =
find it in asm-powerpc/atomic.h, where it is declared as external (extern v=
oid __xnarch_xchg_called_with_bad_pointer(void);).
>=20
> Does anybody know, where I can get the implementation of this function, o=
r what I have to do else to get rid of the error message ?

You might also want to read the comment near the extern declaration of=20
the function in atomic.h, where it says that the function is not even=20
intended to be implemented. The error means somebody called *atomic_xchg=20
with wrong arguments (or there's something else wrong like inlines not=20
working).

-- Heikki Lindholm

