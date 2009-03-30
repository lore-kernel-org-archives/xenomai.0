Message-ID: <49D0B7BE.8090207@domain.hid>
Date: Mon, 30 Mar 2009 14:14:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1
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

roderik.wildenburg@domain.hid wrote:
> I have two problems with shared memory and Xenomai 2.4.6 (2.4.25 PPC-ke=
rnel):
>=20
> 1.) If I don=B4t page align the size of shared memory (multiple of 4096=
) I get the following error message :
> "createshm mmap: No such device or address"
>=20
> Detailed programm output of attached testprogram :
> {
> prompt # ./killtest -c &
> [1] 104
> prompt # createshm mmap: No such device or address
> shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
> killtest user exit !
> }
>=20
> You can reproduce this effect by commenting out line 60 in the attached=
 source file and calling the program as follows:
>=20
> prompt # killtest -c
>=20
>=20
> 2.) If I create 2 processes which use the same shared memory and I kill=
 the process which created the SHM before (!) the other process, which on=
ly uses the SHM, the whole system stalls.
> You can reproduce this with the attached testprogramm by calling it in =
the following way :
>=20
> prompt # ./killtest -c &
> [1] 105
> prompt # ./killtest &
> [2] 106
> prompt # kill 105
> prompt # killtest user exit !
> [1]-  Done                    ./killtest -c
> prompt # kill 106
>=20
> System stalls   =20
>=20
>=20
> Is this a problem of Xenomai (Cleanup od SHM) or am I creating/deleting=
 the SHM in a wrong way ?
> Could you please try to reproduce this problem ?

Could you try to reproduce these issues with xenomai 2.4.7 and the patch
posted here:
https://mail.gna.org/public/xenomai-help/2009-03/msg00098.html

--=20
                                                 Gilles.


