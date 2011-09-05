Message-ID: <4E6471E8.90001@domain.hid>
Date: Mon, 05 Sep 2011 08:53:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
	<4E61D028.3000702@domain.hid>
	<CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
	<4E635FD3.3010704@domain.hid>
	<CAG0ejMGyNRZCAoyhnQ3A10g21HXxUx66DQjckZYeDUcuAMmAsA@mail.gmail.com>
	<4E636667.4030107@domain.hid>
	<CAG0ejMEmmevXe0yn_=ufgcO7HKLv5+3pV-diuxw4x-rvepuwOQ@mail.gmail.com>
	<4E637061.8090605@domain.hid>
	<CAG0ejMFKjFdvhXWLabv5+V8sJy=OXdpP=XZAUasHS2PEGqTg8g@domain.hid>
	<4E63829E.1090500@domain.hid>
	<CAG0ejMEyzyvr79Bf8x79R65+u3MBapCPq3t_RGarfDGaLVe+Zg@domain.hid>
In-Reply-To: <CAG0ejMEyzyvr79Bf8x79R65+u3MBapCPq3t_RGarfDGaLVe+Zg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3A763DDF98E3E2B32FAA68F9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] xenomai-core ftrace
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rainbow <lvqq05@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A763DDF98E3E2B32FAA68F9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-09-05 04:32, rainbow wrote:
> hi,
> I did a test for ftrace-xenomai on x86_64 test just now:
> the environment is : OS: debian 6.0 gcc-4.1
> I use origin/queues/2.6.37-x86 branch on git
> git://git.kiszka.org/ipipe-2.6for linux kernel and use branch
> origin/queues/ftrace on git git://
> git.xenomai.org/xenomai-jki.git
> then I do as the following procedures:
> 1,cd xenomai git
> 2, ./scripts/prepare-kernel.sh --arch=3Dx86_64 --linux=3Dpath_to_2.6.37=
-x86
> 3, cd path_to_2.6.37_x86
> 4,make menuconfig
> then enble ftrace on kernel hacking option.
> 5,install the kernel and reboot the machine.
> 6,do ftrace test
> 6.1 mount -t debugfs nodev /sys/kernel/debug
> 6.2 cd /sys/kernel/debug/tracing
> 6.3 echo function > current_tracer
> At last the machine reboot.
> Is there something wrong about the above procedure? Thanks!

Only queues/2.6.35-x86-trace contains ftrace support.

Jan


--------------enig3A763DDF98E3E2B32FAA68F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5kce0ACgkQitSsb3rl5xSTXACePcHMGQW9DOyyq6LU5yEfRLH5
e5wAoN8zPjIq5FQXaI76TG4ba77/3biX
=PPQ7
-----END PGP SIGNATURE-----

--------------enig3A763DDF98E3E2B32FAA68F9--

