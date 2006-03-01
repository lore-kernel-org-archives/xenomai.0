Message-ID: <440587C8.8090406@domain.hid>
Date: Wed, 01 Mar 2006 12:38:48 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-core] vxworks-skin taskSpawn
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3C4F@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A1C3C4F@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
> Dear Gilles,
>=20
> perhaps I should have mentioned in my earlier postings that I am using =
a PowerPC platform. I hope this does not nullify your prior analyses.
> As the following output shows, my timer is running in onshot mode :
>=20
> ~ # cat /proc/xenomai/timer
> status=3Doneshot:setup=3D40:tickval=3D1:jiffies=3D940509634545=20
>=20
> so, the prerequisites for uvm module should be correct !?
> Is the default timing something I can influence with the vxWorks-API ? =
In the examples satch.c and koan.c I can=B4t see any function call referi=
ng to timer mode manipulation.
>=20

I've run the satch example successfully on an Icecube board here using -r=
c2.=20
What's the status of this issue on your side? Was it a timer configuratio=
n issue=20
as suspected by Gilles?

> Best regards=20
> Roderik
>=20
>=20
>>This looks like a configuration issue: I get a similar=20
>>behaviour when configuring periodic timing by default and=20
>>loading the native module before the uvm module. The uvm skin=20
>>needs aperiodic timing.
>>
>>The UVM skin should refuse to start with an error instead of=20
>>starting with the wrong timer. I am trying to fix this.
>>
>>--=20
>>
>>
>>					    Gilles Chanteperdrix.
>>
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20

Philippe.

