Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <20100712222926.GA2463@domain.hid>
Date: Mon, 12 Jul 2010 22:51:42 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <F730DBD8-DEB8-4C64-BA65-19657D6EFA95@domain.hid>
References: <20100627103712.GA2565@domain.hid>
	<46F86785-737D-41F4-BC37-5DC5A4462039@domain.hid>
	<20100630134535.GA2849@domain.hid>
	<B09D50F0-3A7A-4501-8E96-C5E67AE11D19@domain.hid>
	<20100705214047.GB2444@domain.hid>
	<20100705220238.GC2444@domain.hid>
	<5A2DB1C3-C660-45BE-9743-716F63C11825@domain.hid>
	<20100709221733.GC10254@domain.hid>
	<5BACCC6E-A481-4953-ABAC-ACE3185E1A9C@usc.edu>
	<3712D196-B8B5-430C-A5F5-189C77F76997@domain.hid>
	<20100712222926.GA2463@domain.hid>
Subject: Re: [Xenomai-core] analogy - experimental branch
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi Alexis,

  thanks a lot for the explanations. One item I am confused about is =
that you write that TRIG_TIMER is not suitable for DIO, but in =
cmd_write.c in your sample code, it is used for the analog write without =
problems. Wouldn't one be able to just use the same clock source for DIO =
as in analogue I/O?

Best wishes,

-Stefan



On Jul 12, 2010, at 15:29, Alexis Berlemont wrote:

> Hi,
>=20
> Stefan Schaal wrote:
>> Hi Alexis,
>>=20
>>  I guess I slowly understand that my clocking signal connected to
>>  scan_begin_arg has to come from an external DIO input, if
>>  scan_bigin_src =3D TRIG_EXT, and that the insn instruction is still
>>  needed to trigger the entire acquisition.=20
>=20
> Yes. The trigger instruction is needed so as to start the whole
> acquisition (which is composed of many scans). A periodic external
> signal is needed so as to trigger each scan.
>=20
>>=20
>>  Alternatively, would it be possible to use the internal clocking =
signals like=20
>>=20
>> scan_bigin_src =3D TRIG_FOLLOW
>>=20
>> or=20
>>=20
>> scan_bigin_src =3D TRIG_TIMER
>=20
> I think you are right. If the sampling clock comes from another
> subdevice, TRIG_EXT may not be the most appropriate constant. However,
> the original comedi driver only expects TRIG_EXT even if... the
> sampling signal is not external.
>=20
> TRIG_TIMER does not seem suitable because it assumes an independant
> sampling clock is available. =20
>=20
> And TRIG_FOLLOW may be the most appropriate one. We should modify the
> driver so that TRIG_FOLLOW is used if the analog sampling clock is
> chosen.
>=20
>>=20
>>=20
>> if I try any of these sources, I get an error -22, and dmesg reports:
>>=20
>> [195882.321300] Analogy: a4l_check_cmddesc: scan_begin_src, trigger =
unsupported
>>=20
>=20
> For me, the command interface is an empty shell because the various
> parameters (start_src, scan_begin_src, ...) and the values (TRIG_*)
> are imposed. And, on the other side, the driver is fully in charge of
> the command structure as it is. So, the comedi command imposes a
> communication method but does not ease the driver's task of managing
> it (errors checking, translation, etc.)
>=20
> And, in our case: DIO, we may conclude that this imposed API does not
> fit well: in scan_begin_arg, we have to pass an index which is
> supposed to correspond to some sampling clock (which is specific to a
> board). Then, we use a generic interface with board-specific
> arguments.
>=20
> So, to sum up, I understand your point: the way we control the driver
> may not always be the most appropriate one. But, we inherited from
> comedi both the interface and the drivers.=20
>=20
> On my side, I am working on trying to implement (as a background task)
> a generic interface a little bit more based on discovery (query /
> enum) that would render the command interface obsolete. Unfortunately,
> I have nothing interesting to show yet.
>=20
>> Best wishes,
>>=20
>> -STefan
>>=20
>>=20
>=20


