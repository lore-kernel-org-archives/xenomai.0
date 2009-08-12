From: "Charlton, John" <john.charlton@domain.hid>
Date: Wed, 12 Aug 2009 14:29:47 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE20060EFA4EE1@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
	<4A81CA67.9060301@domain.hid> <4A81CE4F.9060301@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4DEE@us194mx002.tycoelectronics.net>
	<4A82DC78.9060408@domain.hid>
In-Reply-To: <4A82DC78.9060408@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles,

I am using linux kernel 2.6.27.7 and xenomai 2.4.6.1. I get the same result=
s below after loading xeno_timerbench module:

I loaded xeno_timerbench module as follows but get the same results:
modprobe xeno_timerbench

./latency -t 2:

=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -38
(modprobe xeno_timerbench?)

./latency -t 1:
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -38
(modprobe xeno_timerbench?)

cat /proc/modules:
xeno_timerbench 5700 0 - Live 0xce9a0000
savagefb 23520 0 - Live 0xce9a9000
via686a 12780 0 - Live 0xce986000
i2c_viapro 7348 0 - Live 0xce979000
8139cp 17152 0 - Live 0xce99a000
i2c_core 22448 1 i2c_viapro, Live 0xce993000
shpchp 26996 0 - Live 0xce98b000
pci_hotplug 7492 1 shpchp, Live 0xce97d000
via_agp 7456 1 - Live 0xce976000=20

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Wednesday, August 12, 2009 11:15 AM
To: Charlton, John
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented

Charlton, John wrote:
> Gilles,
>=20
> Thank you for the reply.  Here is the output of ld-linux.so.2.  I do not =
have ldd on the open embedded target embedded controller:
> ld-linux.so.2 --list ./latency:
>         linux-gate.so.1 =3D>  (0xffffe000)
>         libnative.so.1 =3D> /usr/xenomai/lib/libnative.so.1 (0xb7f1c000)
>         librtdm.so.1 =3D> /usr/xenomai/lib/librtdm.so.1 (0xb7f1a000)
>         libpthread.so.0 =3D> /lib/libpthread.so.0 (0xb7eff000)
>         libm.so.6 =3D> /lib/libm.so.6 (0xb7ed9000)
>         libc.so.6 =3D> /lib/libc.so.6 (0xb7da4000)
>         /lib/ld-linux.so.2 (0xb7f23000)
>=20
> ld-linux.so.2 --list ./cyclictest:
>         linux-gate.so.1 =3D>  (0xffffe000)
>         libpthread_rt.so.1 =3D> /usr/xenomai/lib/libpthread_rt.so.1 (0xb7=
fbe000)
>         libpthread.so.0 =3D> /lib/libpthread.so.0 (0xb7fa3000)
>         librt.so.1 =3D> /lib/librt.so.1 (0xb7f8e000)
>         libc.so.6 =3D> /lib/libc.so.6 (0xb7e59000)
>         /lib/ld-linux.so.2 (0xb7fc8000)

These two are Ok. I think your debug log contained the output of several co=
mmands. You should try and run the commands one by one by yourself, and rep=
ort the errors you get for the command that produce it.

>=20
> .config:
(snip)
> CONFIG_XENO_SKIN_POSIX=3Dy

Well, since the POSIX skin is enabled, you should not get the message Xenom=
ai Posix skin init: pthread_setschedparam: Function not implemented. Are yo=
u sure you run the kernel you think you are running?

(snip)
> CONFIG_XENO_DRIVERS_TIMERBENCH=3Dm

timerbench is configured as a module, you should load it before you run lat=
ency -t 1 or latency -t 2, or you will get the message:

latency: failed to open benchmark device, code -38 (modprobe xeno_timerbenc=
h?)

Note that the error message gives you the solution.

>> Exactly what version of Xenomai kernel-space suppors runs with what=20
>> version of user-space support?

You did not answer that question. With what version of Xenomai user-space a=
nd kernel-space do you get these issues?

--=20
                                          Gilles


