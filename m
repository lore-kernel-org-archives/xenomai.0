Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2009 13:47:30 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01A45BCA@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <1244554081.7890.99.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org
> Gesendet: Dienstag, 9. Juni 2009 15:28
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: gilles.chanteperdrix@xenomai.org; xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Some problems with shared memory
>=20
> On Mon, 2009-06-08 at 10:25 +0200, roderik.wildenburg@domain.hid
> wrote:
> > >=20
> > > roderik.wildenburg@domain.hid wrote:
> > > >> All I want to hear is "yes, we ran the shm test=20
> without Xenomai, on
> > > >> exactly the same kernel, on the same platform, and the shm=20
> > > >> test worked".
> > > >> Because Xenomai runs plain Linux mmap under the hood and do no
> > > >> particular check on the mmap length. So, the problem=20
> is either that
> > > >> Linux mmap on that particular machine with that particular=20
> > > >> kernel does a
> > > >> check on length, or that there is a subtle bug somewhere=20
> > > that I do not
> > > >> want to investigate until I am usre that it is real.
> > > >=20
> > > >=20
> > > > yes, we ran the shm test without Xenomai, on
> > > > exactly the same kernel, on the same platform, and the shm=20
> > > > test worked.
> > > >=20
> > > > This means :=20
> > > > I took a plain 2.4.25 PPC-Kernel and started killtest=20
> > > without pagealigned shm size and got the error message :
> > > > shm_open fails. errno=3D38 SHM:/testshm
> > > > shm_open: Function not implemented
> > > >=20
> > > > Therefore I mounted a tmpfs on /dev/shm and killtest ran=20
> > > without any errormessage.
> > > > To make shure the missing /dev/shm isn=B4t the reason for the=20
> > > mmap-error I took a xenomai-enhanced kernel, mounted /dev/shm=20
> > > and run (a xenomai-linked) killtest, but I still got the error :
> > > > killtest2 # ./killtest -c
> > > > createshm mmap: No such device or address
> > > > shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
> > > > killtest user exit !
> > > >=20
> > > > This I tried with Xenomai 2.3.5 and 2.4.7 (and got the=20
> same error).
> > > > Even on a Xenomai-enhanced kernel a killtest, which was=20
> > > linked without Xenomai-libraries, run without error.
> > > >=20
> > > > Sorry for not having better news
> > > > Roderik
> >=20
> >=20
> >=20
> > > Hi,
> > >=20
> > > this should have been fixed in the 2.4.8 release, so please=20
> > > test it and
> > > tell us whether it works for you.
> > >=20
> >=20
> > Hello,
> >=20
> > sorry for the delayed answer.
> > Yes and no: The restriction of a page aligned SHM-size=20
> seems to be abolished (I didn=B4t get the error message "No=20
> such device or address" any more).
> > But my target still stalls, when I kill my test=20
> applications in the wrong order.
> > For your convenience I appended the test again (start=20
> "killtest -c &" then "killtest &" and then kill the last one=20
> before the first).
> >=20
>=20
> By "stalls", do you mean a lockup, or does your shell hang=20
> upon ^C while
> the rest of the system keeps running fine?
>=20

In fact, my system reboots because a high priority (no other Xenomai =
task has higher priority) Xenomai watchdog trigger task isn=B4t executed =
any more (the hardware watchdog resets the system if it is not triggered =
for more than 0,5 seconds).=20
When I deactivate the watchdog, the console is dead immediatelly (after =
the kill) but the system seems to work  (ping works) for a while. Even a =
telnet login is sometimes (sometimes the system stalls with the login =
sometimes not) possible. Sometimes the system stalls only after a =
minute, sometimes not at all.
Sorry that I can=B4t give you a better description, but the behaviour is =
pretty strange.

Here is the output of /proc/xenomai/irq when I had access to the system =
via telnet :
fer1_rw:/ # cat /proc/xenomai/irq
IRQ         CPU0
  6:           0         pciibm0
256:       14619         [virtual]
259:           9         [virtual]
fer1_rw:/ # cat /proc/xenomai/irq
IRQ         CPU0
  6:           0         pciibm0
256:       14619         [virtual]
259:           9         [virtual]
fer1_rw:/ # cat /proc/xenomai/irq
IRQ         CPU0
  6:           0         pciibm0
256:       14619         [virtual]
259:           9         [virtual]
=20

Best regards
Roderik

P.s.: I will not be in office till next monday.

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

