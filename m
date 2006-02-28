Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help]
	undefinedreference	__xnarch_xchg_called_with_bad_pointer
Date: Tue, 28 Feb 2006 16:35:36 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C3DB1@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: holindho@domain.hid
Cc: xenomai@xenomai.org

You are right, but who is somebody ?  The example definitly does not =
call any xchg-function directly. The only thing I did, was to activate =
debugging and recompile all the libraries (make clean; configure =
--debug-enable;  make ) and soon I get this error message when compiling =
the demo (I don=B4t get an error message when debugging is disabled) . =
Amazingly I don=B4t get this error message when compiling the native =
examples (ksrc/skins/native/demos) (debug enabled).
Any ideas ?

Roderik



> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Heikki Lindholm
> Gesendet: Dienstag, 28. Februar 2006 15:48
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] undefinedreference=20
> __xnarch_xchg_called_with_bad_pointer
>=20
> Roderik_Wildenburg@domain.hid kirjoitti:
> > Dear Gurus,
> >=20
> > I have compiled ppc(!)-xenomai with debug information=20
> (configure --enable-debug), so far so good (compiling of=20
> xenomai itself and it=B4s libraries, testsuite etc. was successful). =20
> > Buuuut ..., when compiling the vxWorks-demos=20
> (ksrc/skins/vxworks/demos/*.c), I get an error message about=20
> an undefined refernce __xnarch_xchg_called_with_bad_pointer.=20
> I searched for this mysterious function, but could only find=20
> it in asm-powerpc/atomic.h, where it is declared as external=20
> (extern void __xnarch_xchg_called_with_bad_pointer(void);).
> >=20
> > Does anybody know, where I can get the implementation of=20
> this function, or what I have to do else to get rid of the=20
> error message ?
>=20
> You might also want to read the comment near the extern=20
> declaration of the function in atomic.h, where it says that=20
> the function is not even intended to be implemented. The=20
> error means somebody called *atomic_xchg with wrong arguments=20
> (or there's something else wrong like inlines not working).
>=20
> -- Heikki Lindholm
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

