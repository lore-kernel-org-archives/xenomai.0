Message-ID: <45F87970.5060506@domain.hid>
Date: Thu, 15 Mar 2007 00:38:40 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mem usage and other application
References: <45F86426.9000309@domain.hid>
	<17912.26777.313494.393466@domain.hid>
In-Reply-To: <17912.26777.313494.393466@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

Gilles Chanteperdrix =D0=C9=DB=C5=D4:

>  >=20
>  > Second problem:  other applications sometimes (50% attemps) fail to=20
>  > start (especially perl scripts and Eclipse) then at least one Xenoma=
i=20
>  > application running.
>  >=20
>  > I use linux 2.6.17.14, Adeos 1.5-02, Xenomai trunk 2170
>=20
> Could you try running "switchtest" while your Xenomai application is
> running ?
>=20

during running program i got:
[root@domain.hid switchtest]# ./switchtest
=3D=3D Testing FPU check routines...
r0: 1 !=3D 2
r1: 1 !=3D 2
r2: 1 !=3D 2
r3: 1 !=3D 2
r4: 1 !=3D 2
r5: 1 !=3D 2
r6: 1 !=3D 2
r7: 1 !=3D 2
=3D=3D FPU check routines: OK.
ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
=3D=3D Threads: sleeper_ufps-0RTT|  326087:53:20
RTH|ctx switches|-------total
RTD|           0|           0

after stopping program:
[root@domain.hid switchtest]# ./switchtest
=3D=3D Testing FPU check routines...
r0: 1 !=3D 2
r1: 1 !=3D 2
r2: 1 !=3D 2
r3: 1 !=3D 2
r4: 1 !=3D 2
r5: 1 !=3D 2
r6: 1 !=3D 2
r7: 1 !=3D 2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-=
5=20
rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12=20
rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18=20
rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|       11500|       11500
RTD|       11523|       23023
RTD|       11523|       34546
RTD|       11523|       46069
RTD|       11500|       57569
RTD|        9108|       66677

switchtest's results are the same for two configurations:

1) kernel 2.6.17.14, xenomai 2.2.4, Adeos 1.5-00
2) kernel 2.6.17.14, xenomai 2.3.0-r2170, Adeos 1.5-02, debug enabled

except that in first configuration there are no fails (i did not found)=20
of perl scrips or Eclipse.


--=20
________________________________________
Maksym Veremeyenko

