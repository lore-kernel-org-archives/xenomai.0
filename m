From: =?UTF-8?Q?Robert?= <robert-km@o2.pl>
In-Reply-To: <52060B80.1080601@gmail.com>
References: <52039EC3.4050908@gmail.com>
	<2A0F278E-ED28-46CC-8727-DC97BB89A6D6@mah.priv.at>
	<68671d77.6ce2003b.520526a4.3e2c@o2.pl>
	<52060B80.1080601@gmail.com>
Mime-Version: 1.0
Message-ID: <ca8c552.13b41e8d.52063223.12f46@o2.pl>
Date: Sat, 10 Aug 2013 14:29:23 +0200
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
To: =?UTF-8?Q?Sagar_Behere?= <sagar.behere@gmail.com>, =?UTF-8?Q?xenomai@xenomai.org?=, xenomai@xenomai.org

I=20have=20decided=20to=20push=20it=20here,=20since=20it=20was=20private=20=
message:

Dnia=2010=20sierpnia=202013=2011:44=20Sagar=20Behere=20<sagar.behere@gmai=
l.com>=20napisa=C5=82(a):

>=20On=2008/09/2013=2007:28=20PM,=20Robert=20wrote:
>=20>=20I=20wrote=20this=20driver=20recently,=20and=20it=20generates=20st=
able=20pwm=20signal.=20Probably=20you=20will=20have=20to=20adapt=20it=20t=
o=20beaglebone=20black.
>=20>=20It=20is=20written=20for=20Pandaboard=20and=20its=20hardware=20gen=
eral=20purpose=20timer.
>=20>=20There=20are=20some=20ioctl=20interfaces=20for=20user=20space.
>=20>
>=20>=20https://github.com/rkmiec/pandaboard-pwm-rtdm/tree/dc=5Fengine
>=20>
>=20>=20Do=20NOT=20use=20master=20branch=20now.
>=20
>=20Hello=20Robert,
>=20
>=20Quick=20question=20about=20your=20pandaboard-pwm-rtdm.
>=20
>=20I=20see=20in=20pwm.c=20(dc=5Fengine=20branch),=20lines=20125=20and=20=
127,=20that=20you=20use=20
>=20gpio=5Fset=5Fvalue()=20to=20set=20the=20level=20of=20the=20gpio=20pin=
.=20This=20function=20comes=20
>=20from=20#include=20<linux/gpio.h>,=20which=20is=20a=20standard=20linux=
=20driver,=20I=20guess.=20
>=20So=20every=20time=20you=20call=20this=20function,=20you=20are=20makin=
g=20a=20linux=20kernel=20
>=20call..=20won't=20that=20trigger=20a=20transition=20away=20from=20xeno=
mai's=20primary=20
>=20domain?=20i.e.,=20you=20task=20won't=20be=20hard=20realtime=20anymore=
..
>=20
>=20I=20haven't=20understood=20xenomai=20completely,=20so=20it=20is=20pos=
sible=20that=20my=20
>=20reasoning=20is=20wrong.=20Could=20you=20clarify?
>=20
>=20Thanks=20and=20regards,
>=20Sagar
>=20



I'm=20learning=20it=20too.
gpio=5Fset=5Fvalue()=20could=20be=20called=20from=20any=20context=20(comm=
ents=20in
drivers/gpio/gpiolib.c),=20so=20it=20shouldn't=20sleep.
On=20osciloscope=20this=20signal=20looks=20very=20stable.=20Also=20servo=20=
connected=20to=20this
signal=20is=20not=20shaking.


And=20why=20I'm=20toggling=20gpio:
On=20pandaboard,=20hardware=20outputs=20from=20those=20timers=20are=20con=
nected=20to=20HDMI
outuput,=20camera,=20display=20(for=20backlight)=20etc.
None=20of=20them=20is=20available=20on=20expansion=20connector.=20That=20=
is=20why=20I'm=20toggling
gpios.

My=20program=20differs=20a=20little=20from=20Andrey.
I'm=20using=20hardware=20interrupts=20from=20timers=20to=20change=20value=
=20on=20gpio=20pin=20and
he=20was=20using=20rtdm=5Fsleep*()=20(as=20far=20as=20I=20remember).

