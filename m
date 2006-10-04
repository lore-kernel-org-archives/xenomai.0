In-Reply-To: <4523B2EC.3050805@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Please remove "-I." in "xeno-config --*-cflags
Message-ID: <OFACF3C5AC.1F615263-ONC12571FD.004ACE3C-C12571FD.004F1995@domain.hid>
From: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Date: Wed, 4 Oct 2006 16:23:59 +0200
Content-Type: multipart/mixed; boundary="=_mixed 004F1991C12571FD_="
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, xenomai-core-bounces@domain.hid

--=_mixed 004F1991C12571FD_=
Content-Type: text/plain; charset="US-ASCII"

> BTW, providing a patch, even if it's trivial, is always welcome in such
> cases.

I had already attached it to the email, but then i thought it was so
ridiculously small ... and removed it :)
So here it is again.

 
> Well, -Wall should be considered a reasonable policy to keep code clean.
> Me feeling is that this switch is fairly appropriate, specifically for
> real-time applications. But it can easily be relaxed by adding specific
> -Wno-xxx after the Xenomai flags. And *that* should happen explicitly.
>
> -pipe is an optimisation of the build process, something one may
> discuss, though I don't see an immediate reason why it could fail in the
> context of Xenomai applications (that should use the GNU toolchain 
anyway).

I definitley agree on the use of "-Wall" and "-pipe", but i think these
optional flags should be set in the main project, and not by external
libraries or tools. It's not that i think they would conflict with
other flags or that they are wrong or inappropriate, but just because
i expect *-config-tools to not specify any flags that affect the
compiler behaviour. I just don't want every libraries' config-script
to place the authors favorite compiler-flags into my own flags.


> PS: sed 's/-I.//' applied on xeno-config output may meanwhile save your
> day...

make's $(filter-out -I.,$(XENOMAICFLAGS)) works as well, thank you anyway 
;)

Thomas Wiedemann


--=_mixed 004F1991C12571FD_=
Content-Type: text/plain; name="patch.txt"
Content-Disposition: attachment; filename="patch.txt"
Content-Transfer-Encoding: quoted-printable

diff -urN xenomai-2.2.0.orig/scripts/xeno-config.in xenomai-2.2.0/scripts/x=
eno-config.in=0A--- xenomai-2.2.0.orig/scripts/xeno-config.in	2006-06-23 11=
:23:24.000000000 +0200=0A+++ xenomai-2.2.0/scripts/xeno-config.in	2006-10-0=
4 13:29:12.000000000 +0200=0A@@ -12,12 +12,12 @@=0A XENO=5FPREFIX=3D"${stag=
ing}${prefix}"=0A XENO=5FCC=3D"@CC@"=0A XENO=5FTARGET=5FARCH=3D"@XENO=5FTAR=
GET=5FARCH@"=0A-XENO=5FBASE=5FCFLAGS=3D"-I. -I${staging}${includedir} @XENO=
=5FUSER=5FAPP=5FCFLAGS@"=0A+XENO=5FBASE=5FCFLAGS=3D"-I${staging}${includedi=
r} @XENO=5FUSER=5FAPP=5FCFLAGS@"=0A XENO=5FBASE=5FLDFLAGS=3D"-L${staging}${=
libdir} -lpthread @XENO=5FUSER=5FAPP=5FLDFLAGS@"=0A-XENO=5FPOSIX=5FCFLAGS=
=3D"-I. -I${staging}${includedir} -I${staging}${includedir}/posix @XENO=5FU=
SER=5FAPP=5FCFLAGS@"=0A+XENO=5FPOSIX=5FCFLAGS=3D"-I${staging}${includedir} =
-I${staging}${includedir}/posix @XENO=5FUSER=5FAPP=5FCFLAGS@"=0A XENO=5FPOS=
IX=5FLDFLAGS=3D"-L${staging}${libdir} -lpthread=5Frt -lpthread -lrt @XENO=
=5FUSER=5FAPP=5FLDFLAGS@"=0A XENO=5FPOSIX=5FWRAPPERS=3D"${staging}${libdir}=
/posix.wrappers"=0A-XENO=5FUVM=5FCFLAGS=3D"-I. -I${staging}${includedir} @X=
ENO=5FUSER=5FAPP=5FCFLAGS@ -D=5F=5FXENO=5FUVM=5F=5F"=0A+XENO=5FUVM=5FCFLAGS=
=3D"-I${staging}${includedir} @XENO=5FUSER=5FAPP=5FCFLAGS@ -D=5F=5FXENO=5FU=
VM=5F=5F"=0A XENO=5FUVM=5FLDFLAGS=3D"-u=5F=5Fxeno=5Fskin=5Finit -L${staging=
}${libdir} -luvm -lnucleus=5Fuvm -lpthread"=0A XENO=5FLIBRARY=5FDIR=3D"${st=
aging}${libdir}"=0A =0A=
--=_mixed 004F1991C12571FD_=--

