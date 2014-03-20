References: <4C58E39DE6620348B85D78E601C268AF437ABD@srv-exchang2-mi.jerviswebb.com>,
 <201402142329.10853.paul_c@tuxcnc.org>
 <4C58E39DE6620348B85D78E601C268AF438358@srv-exchang2-mi.jerviswebb.com>
 <1392655777.26562.YahooMailNeo@web163503.mail.gq1.yahoo.com>
 <53026F63.5080403@grandegger.com>
 <1392760838.41780.YahooMailNeo@web163505.mail.gq1.yahoo.com>
 <d3241e64b0ad1946aaa3952553fe354f@grandegger.com>
 <1392847535.52577.YahooMailNeo@web163501.mail.gq1.yahoo.com>
 <3a692b55821a5a04d7b55253388edeaf@grandegger.com>
Message-ID: <1395322305.1566.YahooMailNeo@web163504.mail.gq1.yahoo.com>
Date: Thu, 20 Mar 2014 06:31:45 -0700 (PDT)
From: Wayne Ross <mr_trekkie@yahoo.com>
In-Reply-To: <3a692b55821a5a04d7b55253388edeaf@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] CAN ISA support
Reply-To: Wayne Ross <mr_trekkie@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thursday, February 20, 2014 2:47 AM Wolfgang Grandegger wrote:=0A> Am Mi=
, 19.02.2014, 23:05 schrieb Wayne Ross:=0A>> On Wednesday, February 19, 201=
4 3:16 AM Wolfgang Grandegger wrote:=0A>>> Am Di, 18.02.2014, 23:00 schrieb=
 Wayne Ross:=0A>>>> On Monday, February 17, 2014 3:21 PM, Wolfgang Grandegg=
er=0A>>>> <wg@grandegger.com> wrote:=0A...=0A>>>> dmesg shows new activity:=
 =0A=0A>>>> rtcan0: real bitrate 250000, sampling point 87.5%=0A>>>> rtcan_=
sja_set_bit_time: btr0=3D0x1 btr1=3D0x1c=0A>>>> rtcan1: real bitrate 250000=
, sampling point 87.5%=0A>>>> rtcan_sja_set_bit_time: btr0=3D0x1 btr1=3D0x9=
c=0A>>>=0A>>> That's strange. "btr1" should here be "0x1c" as well.=0A>>>=
=0A>> *Most* times I start after boot, BOTH report btr1=3D0x9c...=0A>> One =
boot I saw the values swapped.=0A>=0A> That's wired =3D=3D not OK! btr1 sho=
uld always be "0x1c".=0A>=0A> Wolfgang.=0A =0AResearching=0Athis some more,=
 I *think* I have tracked down this behavior to an=0Auninitialized variable=
 in the file ksrc/drivers/can/rtcan_raw_dev.c, routine=0Artcan_cal_bit_time=
(): this function is called by rtcan_ioctl_dev_set(),=0Apassing a can_bitti=
me pointer.  At the end of rtcan_calc_bit_time, 5=0Amembers of that structu=
re (bt) are filled out, not touching 1 value (sam, a single bit) leaving it=
 uninitialized.  I don't see any=0Ainitialization of that structure in the =
calling routine either. =0A=0A=0AI=0Asee the alternate Kernel configuration=
 of=0ACONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD earlier in the file always s=
ets this=0Avalue to 0.=0A=0A I=0Acannot see any reason to have this value u=
nset for the STD=0Acalculation. =0A=0Ainclude/rtdm/rtcan.h describes this b=
it as "enable triple sampling", which is probably available=0Afor a custom =
timing. =0A=0ASo, I=0Apropose the following change:=0Adiff --git a/ksrc/dri=
vers/can/rtcan_raw_dev.c b/ksrc/drivers/can/rtcan_raw_dev.c=0Aindex c5fd1b6=
..d305bab 100644=0A--- a/ksrc/drivers/can/rtcan_raw_dev.c=0A+++ b/ksrc/driv=
ers/can/rtcan_raw_dev.c=0A@@ -219,6 +219,7 @@ static int rtcan_calc_bit_tim=
e(struct rtcan_device *dev,=0A=A0=A0=A0=A0 bt->phase_seg1 =3D tseg1 - bt->p=
rop_seg;=0A=A0=A0=A0=A0 bt->phase_seg2 =3D tseg2;=0A=A0=A0=A0=A0 bt->sjw =
=3D 1;=0A+=A0=A0=A0 bt->sam =3D 0;=0A=A0=A0=A0=A0 bt->brp =3D best_brp;=0A=
=A0=0A=A0=A0=A0=A0 /* real bit-rate */=0A=0A=0AWith this change I have conf=
irmed rtcanconfig *always* yields the *same* result for btr1 (0x1c):=0Artca=
n0: real bitrate 250000, sampling point 87.5%=0Artcan_sja_set_bit_time: btr=
0=3D0x1 btr1=3D0x1c=0A=0A=0AWayne

