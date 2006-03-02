Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: AW: [Xenomai-core] vxworks-skin taskSpawn
Date: Thu, 2 Mar 2006 14:23:16 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C401D@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, rpm@xenomai.org, holindho@domain.hid
Cc: xenomai@xenomai.org

Thank you to all of you for fixing !!
VxWorks-examples now compile correctly also with debug-anabled !
(just as a remark : make clean; make; make install; have been necessary =
after changing atomic.h =3D> dependencies of atomic.h have not been =
resolved, at least with my installation/configuration)

Best regards=20
Roderik

> -----Urspr=FCngliche Nachricht-----
> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> Gesendet: Mittwoch, 1. M=E4rz 2006 17:44
> An: Philippe Gerum
> Cc: Wildenburg, Roderik RAEK3 MRA; xenomai@xenomai.org
> Betreff: Re: AW: AW: [Xenomai-core] vxworks-skin taskSpawn
>=20
> Philippe Gerum wrote:
>  > Roderik_Wildenburg@domain.hid wrote:
>  > > Philippe Gerum wrote :
>  > >
>  > >>I've run the satch example successfully on an Icecube=20
> board  > >>here using -rc2.=20
>  > >>What's the status of this issue on your side? Was it a=20
> timer  > >>configuration issue as suspected by Gilles?
>  > >>
>  > >
>  > >
>  > > Status is unchanged. I still try to debugg satch with=20
> gdb/ddd and have been a little bit successfull with this.
>  >   But I face more and more problems the deeper I dig into=20
> the system (e.g.=20
>  > unresolved symbols when compiling vxWorks-examples
>  >   with --debug enabled (see other thread)
>  >
>  > This has been fixed in the repository:
>  > http://mail.gna.org/public/xenomai-help/2006-02/msg00149.html
>  >=20
>=20
> The UVM timer configuration issue is also fixed in the=20
> repository: uvm module insertion fails if the system timer is=20
> started in periodic mode.
>=20
> --=20
>=20
>=20
> 					    Gilles Chanteperdrix.
>=20

