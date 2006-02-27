Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-core] vxworks-skin taskSpawn
Date: Mon, 27 Feb 2006 11:56:07 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C3C4F@ARVMAIL1.mra.roland-man.biz>
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
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Dear Gilles,

perhaps I should have mentioned in my earlier postings that I am using a =
PowerPC platform. I hope this does not nullify your prior analyses.
As the following output shows, my timer is running in onshot mode :

~ # cat /proc/xenomai/timer
status=3Doneshot:setup=3D40:tickval=3D1:jiffies=3D940509634545=20

so, the prerequisites for uvm module should be correct !?
Is the default timing something I can influence with the vxWorks-API ? =
In the examples satch.c and koan.c I can=B4t see any function call =
refering to timer mode manipulation.

Best regards=20
Roderik

>=20
> This looks like a configuration issue: I get a similar=20
> behaviour when configuring periodic timing by default and=20
> loading the native module before the uvm module. The uvm skin=20
> needs aperiodic timing.
>=20
> The UVM skin should refuse to start with an error instead of=20
> starting with the wrong timer. I am trying to fix this.
>=20
> --=20
>=20
>=20
> 					    Gilles Chanteperdrix.
>=20

