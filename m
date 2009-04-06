Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 6 Apr 2009 10:47:42 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A01903012@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0190259F@ARVMAIL1.mra.roland-man.biz>
From: <roderik.wildenburg@domain.hid>
Subject: [Xenomai-help]  Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid, gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Hi Gurus,

has anybody been able to reproduce this topic or is it just a problem of =
my hardware and software constellation ?

Roderik

> > > I have two problems with shared memory and Xenomai 2.4.6=20
> > (2.4.25 PPC-kernel):
> > >=20
> > > 1.) If I don=B4t page align the size of shared memory=20
> > (multiple of 4096) I get the following error message :
> > > "createshm mmap: No such device or address"
> > >=20
> > > Detailed programm output of attached testprogram :
> > > {
> > > prompt # ./killtest -c &
> > > [1] 104
> > > prompt # createshm mmap: No such device or address
> > > shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
> > > killtest user exit !
> > > }
> > >=20
> > > You can reproduce this effect by commenting out line 60 in=20
> > the attached source file and calling the program as follows:
> > >=20
> > > prompt # killtest -c
> > >=20
> > >=20
> > > 2.) If I create 2 processes which use the same shared=20
> > memory and I kill the process which created the SHM before=20
> > (!) the other process, which only uses the SHM, the whole=20
> > system stalls.
> > > You can reproduce this with the attached testprogramm by=20
> > calling it in the following way :
> > >=20
> > > prompt # ./killtest -c &
> > > [1] 105
> > > prompt # ./killtest &
> > > [2] 106
> > > prompt # kill 105
> > > prompt # killtest user exit !
> > > [1]-  Done                    ./killtest -c
> > > prompt # kill 106
> > >=20
> > > System stalls   =20
> > >=20
> > >=20
> > > Is this a problem of Xenomai (Cleanup od SHM) or am I=20
> > creating/deleting the SHM in a wrong way ?
> > > Could you please try to reproduce this problem ?
> >=20
> > Could you try to reproduce these issues with xenomai 2.4.7=20
> > and the patch
> > posted here:
> > https://mail.gna.org/public/xenomai-help/2009-03/msg00098.html
> >=20
>=20
> Sorry, neither problem 1 nor problem 2 changed with 2.4.7 and=20
> your patch :
>=20
> Output of killtest and Shared Memory not page aligned :
> ------------------------------------------------------
> killtest2 # cat /proc/xenomai/version
> 2.4.7
> killtest2 # ./killtest -c &
> [1] 107
> killtest2 # createshm mmap: No such device or address
> shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
> killtest user exit !
> =20
> Output of killtest and Shared Memory page aligned :
> ---------------------------------------------------
> killtest2 # cat /proc/xenomai/version
> 2.4.7
> killtest2 # ./killtest -c &
> [1] 109
> killtest2 # ./killtest &
> [2] 110
> killtest2 #
> killtest2 # kill 109
> killtest user exit !
> [1]-  Done                    ./killtest -c
> killtest2 #
> killtest2 # kill 110=20
>=20
> System stalled
>=20
>=20
> Page align problem is the same with Xenomai 2.3.5
> Output of killtest and Shared Memory not page aligned with=20
> xenomai 2.3.5:
> --------------------------------------------------------------
> -----------
> killtest2 # cat /proc/xenomai/version
> 2.3.5
> killtest2 # ./killtest -c &
> [1] 120
> killtest2 # createshm mmap: No such device or address
> shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
> killtest user exit !
>=20
> [1]+  Done(255)               ./killtest -c
> killtest2 #=20
>=20
>=20
> But the "stall"-problem does not occur with Xenomai 2.3.5 !
> Output of killtest and Shared Memory page aligned with xenomai 2.3.5:
> ----------------------------------------------------------------------
> killtest2 # cat /proc/xenomai/version
> 2.3.5
> killtest2 # ./killtest -c &
> [1] 122
> killtest2 #
> killtest2 # ./killtest &
> [2] 123
> killtest2 #
> killtest2 # kill 122
> killtest user exit !
> [1]-  Done                    ./killtest -c
> killtest2 #
> killtest2 # kill 123
> killtest2 # killtest user exit !
>=20
> [2]+  Done                    ./killtest
> killtest2 #
> killtest2 #
>=20
>=20
> Anything else I could test ?
> Does the problem accour on your testequipment ?
>=20
> Many thanks for your help
> Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

