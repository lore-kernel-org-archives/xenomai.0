Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <453647E6.2050307@domain.hid>
References: <1161184570.5093.61.camel@domain.hid>  <453647E6.2050307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4hJEW9hxDxuI5Bb9iiHt"
Date: Sat, 21 Oct 2006 14:11:53 +0200
Message-Id: <1161432713.5007.16.camel@domain.hid>
Mime-Version: 1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--=-4hJEW9hxDxuI5Bb9iiHt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!

One problem I had was that I needet to set very high periode-values for
latency and switchbench.
I think I've found a solution.

1. I increased the granularity of the system-timer
I'm using full system-clock f=FCr the timer now, instead of
system-clock/64 so now I have 1769472 ticks per jiffy (instead of 27648)

2. There was a wrong value for CLOCK_TICK_RATE in timex.h I think.
It was set to 50000000 / 16 (by netsilicon), but it should be the hw
clock frequency (http://arm.nihilisme.ca/doc/aleph.pdf )
CLOCK_TICK_RATE is now set to 176947200.

Results:
I'm able to pass Periods about 200us and lower to latency and
switchbench now.



But the Problem with Latency-Test with in-kernel periodic tasks and
in-kernel timer handler exists further.

ioctl RTTST_RTIOC_INTERM_BENCH_RES is sent once in userspace
and received twice (by rt_tmbench_ioctl_rt and
rt_tmbench_ioctl_nrt) ...=20
There is no such behavior on my x86 running these tests.

Now i'll try to check the communication between the rt-driver and the
userspace now and will report my results.


Greets
	Manfred



--=-4hJEW9hxDxuI5Bb9iiHt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFOg6JbMvu5jIEpfsRAl42AJ0YgCdZF81TkhHGGDMQRzvs0sVI7wCeNMxn
srWMYb5CL6GOnWAjihOGpmM=
=6Xef
-----END PGP SIGNATURE-----

--=-4hJEW9hxDxuI5Bb9iiHt--


