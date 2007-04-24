Message-ID: <462DE368.9020005@domain.hid>
Date: Tue, 24 Apr 2007 13:00:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45F68258.5040603@domain.hid>
	<460AB8FF.5060904@domain.hid>	<460B21C0.7090200@domain.hid>
	<460B7FDF.8030100@domain.hid>	<460BECFD.2030003@domain.hid>
	<460C0C7D.7000001@domain.hid>	<bc4264770704230809i9f9c554k14d67007b828971d@domain.hid>	<17964.64208.463335.611234@domain.hid>	<bc4264770704240144n74d4cfa0lafcbc84b76e06822@domain.hid>	<462DC874.20303@domain.hid>
	<bc4264770704240331v31f81487l32e27634e77804b4@domain.hid>
	<462DE28F.5010400@domain.hid>
In-Reply-To: <462DE28F.5010400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBC2944C112343DC37FD2F331"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC2944C112343DC37FD2F331
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> roland Tollenaar wrote:
>> Hi
>>
>>> Two conclusions:
>>>
>>>  - You are running your kernel as i586 without TSC support - suboptim=
al,
>>>    costs you a few micros.
>> I am aware of this. For the current machine I will stick to this.
>>
>>
>>>  - The reported latency perfectly matches the trace, nothing
>>>    pathological there. The trace looks like this: Timer fired,
>>>    measurement task woken up, two interrupts squeeze themselves betwe=
en
>>>    wakeup and time stamp acquisition. All sane.
>> Is it not a bit strange that a machine as fast as this one is supposed=

>> to be give worse latencies than much slower machines. Are the 2
>> interrupts causing the latency?
>=20
> Yes, what puzzels me is actually the high min latency of more than 24us=
:
>=20
>  =3D=3D Sampling period: 100 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|--lat min|---lat avg|-----lat max|-overrun|----lat best|---lat wors=
t
> RTD|   24.304|    35.199|      65.371|       0|      24.304|      65.37=
1
>=20
> Can the TSC cause such high delays?
>

You mean TSC emulation? Definitely yes for the worst-case. Almost every
rthal_get_8254_tsc() costs about 3 us, and I counted >15 in Roland's
critical trace path.

> And what is the output of "/proc/xenomai/latency"?

Indeed interesting. Maybe the system is not well tuned. But the overhead
of rthal_get_8254_tsc() will remain for the non-minimal case (e.g.
host-tick hitting before or after task-wakeup tick).

Jan


--------------enigBC2944C112343DC37FD2F331
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLeNpniDOoMHTA+kRAiisAJ46t+Gibs5kmj3xkuIPr/KnovRFAwCfXNf3
xrYkYOn21mtTfzLaFZEAUaA=
=RbMK
-----END PGP SIGNATURE-----

--------------enigBC2944C112343DC37FD2F331--

