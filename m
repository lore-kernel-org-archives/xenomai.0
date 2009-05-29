Message-ID: <4A202C8D.9000605@domain.hid>
Date: Fri, 29 May 2009 20:42:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0198FC6F@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0198FC6F@ARVMAIL1.mra.roland-man.biz>
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
>> All I want to hear is "yes, we ran the shm test without Xenomai, on
>> exactly the same kernel, on the same platform, and the shm=20
>> test worked".
>> Because Xenomai runs plain Linux mmap under the hood and do no
>> particular check on the mmap length. So, the problem is either that
>> Linux mmap on that particular machine with that particular=20
>> kernel does a
>> check on length, or that there is a subtle bug somewhere that I do not=

>> want to investigate until I am usre that it is real.
>=20
>=20
> yes, we ran the shm test without Xenomai, on
> exactly the same kernel, on the same platform, and the shm=20
> test worked.
>=20
> This means :=20
> I took a plain 2.4.25 PPC-Kernel and started killtest without pagealign=
ed shm size and got the error message :
> shm_open fails. errno=3D38 SHM:/testshm
> shm_open: Function not implemented
>=20
> Therefore I mounted a tmpfs on /dev/shm and killtest ran without any er=
rormessage.
> To make shure the missing /dev/shm isn=B4t the reason for the mmap-erro=
r I took a xenomai-enhanced kernel, mounted /dev/shm and run (a xenomai-l=
inked) killtest, but I still got the error :
> killtest2 # ./killtest -c
> createshm mmap: No such device or address
> shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
> killtest user exit !
>=20
> This I tried with Xenomai 2.3.5 and 2.4.7 (and got the same error).
> Even on a Xenomai-enhanced kernel a killtest, which was linked without =
Xenomai-libraries, run without error.
>=20
> Sorry for not having better news
> Roderik

Hi,

this should have been fixed in the 2.4.8 release, so please test it and
tell us whether it works for you.


--=20
					    Gilles.


