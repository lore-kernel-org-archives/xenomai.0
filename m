Message-ID: <4B7BFB19.2070308@domain.hid>
Date: Wed, 17 Feb 2010 15:20:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.63.1266404417.13819.xenomai@xenomai.org>
	<COL105-W19CEDDAC71AEB3BEEE7B54C3480@domain.hid>
In-Reply-To: <COL105-W19CEDDAC71AEB3BEEE7B54C3480@domain.hid>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to solve this high latency problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?GB2312?B?19Mg0KE=?= <hapcobot@domain.hid>
Cc: xenomai@xenomai.org

=D7=D3 =D0=A1 wrote:
> Hi,
>=20
> after I installed the xenomai-2.5.1 with kernel 2.6.32.7, I ran the
> latency test program at /usr/xenomai/share/xenomai/testsuite/latency
>=20
> below is what I got. High latency (about 400 microseconds for max
> latency) is present.
>=20
> Basically, in my configuration, I have disabled ACPI, APM, and CPU
> frequency scaling;

You should NOT disable ACPI. The only thing you should disable is
ACPI_PROCESSOR.

> enalbed "Enable periodic timing", "Enable FPU support", and "Enable
> NMI watchdog".

You probably do not need the periodic timer.

>=20
> I know that SMI workaround is important here. So I also enabled
> "Enable SMI workaround". Regarding "Globally disable SMI", I tried
> many times and found that if I enabled it, my laptop cannot boot
> up... Thus I have to keep it disabled, while I did not enable any
> other SMI options below "Globally disable SMI" in the configuration
> menu.
>=20
> Now I am stuck here, not able to find out the solution to the
> problem. Could you help on this?

See xenomai troubleshooting guide.

>=20
> Another question I would like to ask: in the result of my latency
> test, what is the difference between "lat max" and "lat worst"?
> because the numbers shown there are different.

the max is the max during the last second, the worst is the max since
the latency program is running.


--=20
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

