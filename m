From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01A45BCA@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A01A45BCA@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Jun 2009 16:06:16 +0200
Message-Id: <1244815576.7890.193.camel@domain.hid>
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

On Wed, 2009-06-10 at 13:47 +0200, roderik.wildenburg@domain.hid
wrote:
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von: Philippe Gerum [mailto:rpm@xenomai.org
> > Gesendet: Dienstag, 9. Juni 2009 15:28
> > An: Wildenburg, Roderik RAEK3 MRA
> > Cc: gilles.chanteperdrix@xenomai.org; xenomai@xenomai.org
> > Betreff: Re: [Xenomai-help] Some problems with shared memory
> >=20
> > On Mon, 2009-06-08 at 10:25 +0200, roderik.wildenburg@domain.hid
> > wrote:
> > > >=20
> > > > roderik.wildenburg@domain.hid wrote:
> > > > >> All I want to hear is "yes, we ran the shm test=20
> > without Xenomai, on
> > > > >> exactly the same kernel, on the same platform, and the shm=20
> > > > >> test worked".
> > > > >> Because Xenomai runs plain Linux mmap under the hood and do no
> > > > >> particular check on the mmap length. So, the problem=20
> > is either that
> > > > >> Linux mmap on that particular machine with that particular=20
> > > > >> kernel does a
> > > > >> check on length, or that there is a subtle bug somewhere=20
> > > > that I do not
> > > > >> want to investigate until I am usre that it is real.
> > > > >=20
> > > > >=20
> > > > > yes, we ran the shm test without Xenomai, on
> > > > > exactly the same kernel, on the same platform, and the shm=20
> > > > > test worked.
> > > > >=20
> > > > > This means :=20
> > > > > I took a plain 2.4.25 PPC-Kernel and started killtest=20
> > > > without pagealigned shm size and got the error message :
> > > > > shm_open fails. errno=3D38 SHM:/testshm
> > > > > shm_open: Function not implemented
> > > > >=20
> > > > > Therefore I mounted a tmpfs on /dev/shm and killtest ran=20
> > > > without any errormessage.
> > > > > To make shure the missing /dev/shm isn=C2=B4t the reason for th=
e=20
> > > > mmap-error I took a xenomai-enhanced kernel, mounted /dev/shm=20
> > > > and run (a xenomai-linked) killtest, but I still got the error :
> > > > > killtest2 # ./killtest -c
> > > > > createshm mmap: No such device or address
> > > > > shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
> > > > > killtest user exit !
> > > > >=20
> > > > > This I tried with Xenomai 2.3.5 and 2.4.7 (and got the=20
> > same error).
> > > > > Even on a Xenomai-enhanced kernel a killtest, which was=20
> > > > linked without Xenomai-libraries, run without error.
> > > > >=20
> > > > > Sorry for not having better news
> > > > > Roderik
> > >=20
> > >=20
> > >=20
> > > > Hi,
> > > >=20
> > > > this should have been fixed in the 2.4.8 release, so please=20
> > > > test it and
> > > > tell us whether it works for you.
> > > >=20
> > >=20
> > > Hello,
> > >=20
> > > sorry for the delayed answer.
> > > Yes and no: The restriction of a page aligned SHM-size=20
> > seems to be abolished (I didn=C2=B4t get the error message "No=20
> > such device or address" any more).
> > > But my target still stalls, when I kill my test=20
> > applications in the wrong order.
> > > For your convenience I appended the test again (start=20
> > "killtest -c &" then "killtest &" and then kill the last one=20
> > before the first).
> > >=20
> >=20
> > By "stalls", do you mean a lockup, or does your shell hang=20
> > upon ^C while
> > the rest of the system keeps running fine?
> >=20
>=20
> In fact, my system reboots because a high priority (no other Xenomai ta=
sk has higher priority) Xenomai watchdog trigger task isn=C2=B4t executed=
 any more (the hardware watchdog resets the system if it is not triggered=
 for more than 0,5 seconds).=20
> When I deactivate the watchdog, the console is dead immediatelly (after=
 the kill) but the system seems to work  (ping works) for a while. Even a=
 telnet login is sometimes (sometimes the system stalls with the login so=
metimes not) possible. Sometimes the system stalls only after a minute, s=
ometimes not at all.
> Sorry that I can=C2=B4t give you a better description, but the behaviou=
r is pretty strange.
>=20
> Here is the output of /proc/xenomai/irq when I had access to the system=
 via telnet :
> fer1_rw:/ # cat /proc/xenomai/irq
> IRQ         CPU0
>   6:           0         pciibm0
> 256:       14619         [virtual]
> 259:           9         [virtual]
> fer1_rw:/ # cat /proc/xenomai/irq
> IRQ         CPU0
>   6:           0         pciibm0
> 256:       14619         [virtual]
> 259:           9         [virtual]
> fer1_rw:/ # cat /proc/xenomai/irq
> IRQ         CPU0
>   6:           0         pciibm0
> 256:       14619         [virtual]
> 259:           9         [virtual]

We have a stuck timer interrupt. Ok, the I-pipe 1.2 series for Linux 2.4
is so old that I have probably handwritten that code on some parchment
first, so please try the following patch. It is basically the most
recent I-pipe core available for the 2.6/powerpc series backported to
your venerable 2.4/ppc kernel. Let me know if the issue is gone; it
seems to be fixed here, but that's no proof unfortunately, given the
randomness of it.

http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4.25-ppc-DEN=
X-2.0-00.patch

PS: this patch handles mpc5xxx, UIC and AIC (i.e. 4xx) PICs, so if you
are still based on an Icecube, this should do the trick; at least it
works on mine. Otherwise, just let me know which kind of hw you actually
run.

--=20
Philippe.



