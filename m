Subject: Re: [Xenomai-core] Buildbot detects failure in recent build
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200612232158.34758.niklaus.giger@domain.hid>
References: <200612231931.23828.niklaus.giger@domain.hid>
	<1166900039.17393.3.camel@domain.hid>
	<200612232158.34758.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 24 Dec 2006 01:06:41 +0100
Message-Id: <1166918801.17393.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Sat, 2006-12-23 at 21:58 +0100, Niklaus Giger wrote:
> Am Samstag, 23. Dezember 2006 19:53 schrieb Philippe Gerum:
> > On Sat, 2006-12-23 at 19:31 +0100, Niklaus Giger wrote:
> > > Hi Philippe
> > >
> > > It seems that your revision 1978 or 1979 broke building PSOS+ on pp=
c and
> > > PPC405.
> >
> > Fixed, thanks. Btw, could you ask the buildbot to spam me gently each
> > time a commit wrecks the Xenomai boat? It would be easier for me than
> > tracking the WEB interface status. TIA,
> Sorry for a (wrong positive) mail from my test installation.=20
>=20
> You should receive an email on build failures. I changed the buildbot s=
etup so=20
> that failures while running the test on my CPU-board are only flagged a=
s=20
> warnings, as they were often reporting failures in my setup.
> As my PPC405 board is also used for may other development work, it is=20
> sometimes unavailable for the buildbot and the buildbot would also flag=
 this=20
> as an error.
> The sim is reporting error since quite a few weeks, but Gilles never fi=
xed=20
> this error (which is probably just an expectation or a time value which=
 has=20
> varied a little bit):
> Some problems were reported in:
> vxworks->t010823-2:t010823-2.c:163: Expected sequence: SEQ("Test2",2004=
); got=20
> SEQ("Test2",1999)
> vxworks->t010823-2: t010823-2.c:166, test finished: 1 failures/ 33 test=
s
> If you want I could also made a failure in this buildstep be considered=
 only a=20
> warning.

No problem for now. If I ever get sick of these warnings, I will spam
Gilles in turn. Eh.

>=20
> If you receive too many emails just let me know and I will try to impro=
ve this=20
> situation.
>=20

Great, thanks. Let's see how this evolves; my mail filters will help me
handling the notifications appropriately.

> Joyeux no=EBl
>=20
> Niklaus Giger
--=20
Philippe.



