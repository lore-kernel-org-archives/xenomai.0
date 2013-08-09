From: =?UTF-8?Q?Robert?= <robert-km@o2.pl>
In-Reply-To: <2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
References: <52039EC3.4050908@gmail.com>
	<2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
Mime-Version: 1.0
Message-ID: <68671d77.6ce2003b.520526a4.3e2c@o2.pl>
Date: Fri, 09 Aug 2013 19:28:04 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] =?utf-8?q?Using_hardware_PWM_generators_with_Xenomai?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?xenomai@xenomai.org?=, xenomai@xenomai.org, =?UTF-8?Q?Michael_Haberler?= <mail17@mah.priv.at>

I=20wrote=20this=20driver=20recently,=20and=20it=20generates=20stable=20p=
wm=20signal.=20Probably=20you=20will=20have=20to=20adapt=20it=20to=20beag=
lebone=20black.
It=20is=20written=20for=20Pandaboard=20and=20its=20hardware=20general=20p=
urpose=20timer.
There=20are=20some=20ioctl=20interfaces=20for=20user=20space.

https://github.com/rkmiec/pandaboard-pwm-rtdm/tree/dc=5Fengine

Do=20NOT=20use=20master=20branch=20now.

Dnia=208=20sierpnia=202013=2016:26=20Michael=20Haberler=20<mail17@mah.pri=
v.at>=20napisa=C5=82(a):

>=20Sagar,
>=20
>=20you=20might=20want=20to=20study=20the=20LinuxCNC=20code,=20which=20do=
es=20PWM=20-=20among=20other=20functions=20like=20a=20stepper=20generator=
=20-=20via=20the=20PRU
>=20
>=20http://git.linuxcnc.org/gitweb?p=3Dlinuxcnc.git;a=3Dtree;f=3Dsrc/hal/=
drivers/hal=5Fpru=5Fgeneric;h=3D5e7dc56c1891408833362fd7f480a9da20dcc31d;=
hb=3Drefs/heads/unified-build-candidate-1
>=20
>=20-=20Michael
>=20Am=2008.08.2013=20um=2015:36=20schrieb=20Sagar=20Behere=20<sagar.behe=
re@gmail.com>:
>=20
>=20>=20Hello,
>=20>=20
>=20>=20I=20wish=20to=20generate=20PWM=20signals=20from=20Xenomai,=20usin=
g=20the=20beaglebone=20black,=20kernel=203.8.13=20patched=20with=20xenoma=
i.
>=20>=20
>=20>=20There=20already=20exist=20linux=20kernel=20modules=20for=20the=20=
hardware=20PWM=20generator=20(eHRPWM)=20on=20the=20am335x=20chip=20in=20t=
he=20beaglebone.=20The=20PWM=20generator=20can=20be=20configured=20and=20=
controlled=20via=20the=20/sysfs=20interface=20and=20the=20whole=20thing=20=
works=20very=20well.
>=20>=20
>=20>=20I=20understand=20that=20the=20/sysfs=20interface=20cannot=20be=20=
used=20by=20xenomai=20tasks=20without=20triggering=20a=20transition=20awa=
y=20from=20the=20primary=20xenomai=20(hard=20realtime)=20domain.=20So=20m=
y=20question=20is:=20What=20is=20the=20least=20effort=20way=20to=20change=
=20the=20duty=20cycle=20of=20the=20hardware=20PWM=20generator,=20from=20a=
=20xenomai=20task?
>=20>=20
>=20>=20Does=20the=20following=20approach=20sound=20feasible?
>=20>=20
>=20>=201.=20Configure=20the=20PWM=20generator=20(freq,=20polarity=20etc.=
)=20from=20the=20/sysfs=20interface=20at=20application=20startup.=20This=20=
need=20not=20be=20realtime
>=20>=202.=20Assuming=20that=20the=20duty-cycle=20is=20controlled=20by=20=
the=20value=20of=20some=20memory-mapped=20register,=20use=20mmap()/iorema=
p()=20to=20map=20that=20register's=20address=20into=20the=20xenomai=20tas=
k's=20address=20space.
>=20>=203.=20Write=20the=20duty-cycle=20values=20to=20the=20mapped=20memo=
ry,=20from=20within=20the=20xenomai=20task
>=20>=20
>=20>=20So=20this=20is=20like=20a=20hybrid=20approach=20that=20uses=20the=
=20existing=20linux=20kernel=20module=20for=20initializing/configuring=20=
the=20hardware=20PWM=20and=20the=20xenomai=20task=20only=20changes=20the=20=
value=20of=20one=20register=20that=20affects=20the=20duty=20cycle=20of=20=
the=20output=20waveform.
>=20>=20
>=20>=20Thanks=20in=20advance,
>=20>=20Sagar
>=20>=20
>=20>=20=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=

>=20>=20Xenomai=20mailing=20list
>=20>=20Xenomai@xenomai.org
>=20>=20http://www.xenomai.org/mailman/listinfo/xenomai
>=20
>=20
>=20=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
>=20Xenomai=20mailing=20list
>=20Xenomai@xenomai.org
>=20http://www.xenomai.org/mailman/listinfo/xenomai
>=20

