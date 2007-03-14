Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] rtcansend.c problem if using together
	with-lpthread_rt
Date: Wed, 14 Mar 2007 11:58:07 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01C21D24@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01BB4107@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB01BB4107@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>, xenomai@xenomai.org

Hi,

Sorry to repost this issue, which I posted some days ago, but there was
no reaction so far.
It should be easy to reproduce. I need just a short answer from somebody
with a RT-CAN driver.


Thanks in advance,

Best regards,

Daniel Schnell.


Daniel Schnell wrote:
> Hi,
>=20
> Hunting down a RTCAN related bug in my application I ended up
> compiling the rtcansend.c function with our make environment.=20
>=20
> Basicly the compilation is done like this:
>=20
> ppc_6xx-gcc -W -Wall -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> -I/usr/xenomai/include -c -o rtcansend.o rtcansend.c=20
>=20
> Linking:
>=20
> ppc_6xx-gcc  -o rtcansend rtcansend.o -L/usr/xenomai/lib -lpthread_rt
> -lnative -lrtdm -lpthread -lrt=20
>=20
> If run, the following happens:
> bash-2.05b# ./rtcansend rtcan0 -v -i0 01 interface rtcan0 s=3D0,
> ifr_name=3Drtcan0=20
> rt_task_shadow: Device or resource busy
> Cleaning up...
>=20
> If I leave away -lpthread_rt in the linking step, output is normal:
>=20
> bash-2.05b# test/rtcansend rtcan0 -v -i0 01 interface rtcan0 s=3D0,
> ifr_name=3Drtcan0 <0x000> [1] 01 Cleaning up...=20
>=20
> I am using svn version 2256.
> Am I doing here something fundamentally wrong in providing
> -lpthread_rt as an additional library ? Shouldn't the native skin and
> the POSIX skin just work together ? =20
>=20
>=20

