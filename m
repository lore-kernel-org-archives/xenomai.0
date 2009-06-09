From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01A4598F@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A01A4598F@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Jun 2009 15:28:01 +0200
Message-Id: <1244554081.7890.99.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Some problems with shared memory
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

On Mon, 2009-06-08 at 10:25 +0200, roderik.wildenburg@domain.hid
wrote:
> >=20
> > roderik.wildenburg@domain.hid wrote:
> > >> All I want to hear is "yes, we ran the shm test without Xenomai, o=
n
> > >> exactly the same kernel, on the same platform, and the shm=20
> > >> test worked".
> > >> Because Xenomai runs plain Linux mmap under the hood and do no
> > >> particular check on the mmap length. So, the problem is either tha=
t
> > >> Linux mmap on that particular machine with that particular=20
> > >> kernel does a
> > >> check on length, or that there is a subtle bug somewhere=20
> > that I do not
> > >> want to investigate until I am usre that it is real.
> > >=20
> > >=20
> > > yes, we ran the shm test without Xenomai, on
> > > exactly the same kernel, on the same platform, and the shm=20
> > > test worked.
> > >=20
> > > This means :=20
> > > I took a plain 2.4.25 PPC-Kernel and started killtest=20
> > without pagealigned shm size and got the error message :
> > > shm_open fails. errno=3D38 SHM:/testshm
> > > shm_open: Function not implemented
> > >=20
> > > Therefore I mounted a tmpfs on /dev/shm and killtest ran=20
> > without any errormessage.
> > > To make shure the missing /dev/shm isn=C2=B4t the reason for the=20
> > mmap-error I took a xenomai-enhanced kernel, mounted /dev/shm=20
> > and run (a xenomai-linked) killtest, but I still got the error :
> > > killtest2 # ./killtest -c
> > > createshm mmap: No such device or address
> > > shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
> > > killtest user exit !
> > >=20
> > > This I tried with Xenomai 2.3.5 and 2.4.7 (and got the same error).
> > > Even on a Xenomai-enhanced kernel a killtest, which was=20
> > linked without Xenomai-libraries, run without error.
> > >=20
> > > Sorry for not having better news
> > > Roderik
>=20
>=20
>=20
> > Hi,
> >=20
> > this should have been fixed in the 2.4.8 release, so please=20
> > test it and
> > tell us whether it works for you.
> >=20
>=20
> Hello,
>=20
> sorry for the delayed answer.
> Yes and no: The restriction of a page aligned SHM-size seems to be abol=
ished (I didn=C2=B4t get the error message "No such device or address" an=
y more).
> But my target still stalls, when I kill my test applications in the wro=
ng order.
> For your convenience I appended the test again (start "killtest -c &" t=
hen "killtest &" and then kill the last one before the first).
>=20

By "stalls", do you mean a lockup, or does your shell hang upon ^C while
the rest of the system keeps running fine?

> Best regards
> Roderik
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



