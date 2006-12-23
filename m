From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot detects failure in recent build
Date: Sat, 23 Dec 2006 21:58:34 +0100
References: <200612231931.23828.niklaus.giger@domain.hid>
	<1166900039.17393.3.camel@domain.hid>
In-Reply-To: <1166900039.17393.3.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200612232158.34758.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Samstag, 23. Dezember 2006 19:53 schrieb Philippe Gerum:
> On Sat, 2006-12-23 at 19:31 +0100, Niklaus Giger wrote:
> > Hi Philippe
> >
> > It seems that your revision 1978 or 1979 broke building PSOS+ on ppc and
> > PPC405.
>
> Fixed, thanks. Btw, could you ask the buildbot to spam me gently each
> time a commit wrecks the Xenomai boat? It would be easier for me than
> tracking the WEB interface status. TIA,
Sorry for a (wrong positive) mail from my test installation.=20

You should receive an email on build failures. I changed the buildbot setup=
 so=20
that failures while running the test on my CPU-board are only flagged as=20
warnings, as they were often reporting failures in my setup.
As my PPC405 board is also used for may other development work, it is=20
sometimes unavailable for the buildbot and the buildbot would also flag thi=
s=20
as an error.
The sim is reporting error since quite a few weeks, but Gilles never fixed=
=20
this error (which is probably just an expectation or a time value which has=
=20
varied a little bit):
Some problems were reported in:
vxworks->t010823-2:t010823-2.c:163: Expected sequence: SEQ("Test2",2004); g=
ot=20
SEQ("Test2",1999)
vxworks->t010823-2: t010823-2.c:166, test finished: 1 failures/ 33 tests
If you want I could also made a failure in this buildstep be considered onl=
y a=20
warning.

If you receive too many emails just let me know and I will try to improve t=
his=20
situation.

Joyeux no=EBl

Niklaus Giger

