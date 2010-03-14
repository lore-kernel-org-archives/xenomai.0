Message-ID: <4B9CA590.7040102@domain.hid>
Date: Sun, 14 Mar 2010 10:00:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B968DB5.5020302@domain.hid>
	<1268495969.27899.144.camel@domain.hid>
In-Reply-To: <1268495969.27899.144.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig962A8A59433F6B876C5D05C3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [pull request] Improve ftrace interaction
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig962A8A59433F6B876C5D05C3
Content-Type: multipart/mixed;
 boundary="------------040400070000050503030301"

This is a multi-part message in MIME format.
--------------040400070000050503030301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2010-03-09 at 19:04 +0100, Jan Kiszka wrote:
>> The following changes since commit 7c90959b7e4eb5ef8a775ec17005c23f30d=
aade1:
>>   Philippe Gerum (1):
>>         ipipe: introduce 3-level IRQ pending map
>>
>> are available in the git repository at:
>>
>>   git://git.kiszka.org/ipipe-2.6 queues/2.6.32-noarch
>>
>> These patches address various possible configuration errors around
>> ftrace that can cause hard crashes over I-pipe kernels. Moreover, one
>> patch enables the safe use of ftrace's PID filtering that comes for fr=
ee
>> for the I-pipe tracer now.
>>
>> The patches also apply on 2.6.33-noarch but were only tested on
>> 2.6.32-x86.
>>
>>
>> Jan Kiszka (5):
>>       Use ipipe_safe_current in ftrace_pid_func
>>       Prevent unsafe ftrace usage over I-pipe
>=20
> This one looks pretty ugly. I would rather define a entry point for
> registering ftrace hooks allowed to run in NMI context, and deny the
> regular unsafe registration routine when the I-pipe tracer is enabled.

I just learned yesterday from Frederic that the ftrace ring buffer
should be NMI-safe by now. I need to look into this again, maybe we can
make _much_ more of ftrace usable for I-pipe. IOW: Series on hold.

Jan



--------------040400070000050503030301
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC45IChH
TlUvTGludXgpCkNvbW1lbnQ6IFVzaW5nIEdudVBHIHdpdGggU1VTRSAtIGh0dHA6Ly9lbmln
bWFpbC5tb3pkZXYub3JnCgppRVlFQVJFQ0FBWUZBa3VjcFUwQUNna1FpdFNzYjNybDV4UkVs
d0NlSTNhTk1QWW51Y2t0cHI0OU9tWHhzL0Z0CkxId0FvSjZRc0h0SUMwcDlLNnVmTjJYVmpY
d2VHOGxaCj1nNmFUCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQoK
--------------040400070000050503030301--

--------------enig962A8A59433F6B876C5D05C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkucpZAACgkQitSsb3rl5xSUKwCg4R0zeZklkI1QKNex+LGj8b1/
03IAoNJPo9x9cX6NAi3ltEvrj49mHDgM
=r3kV
-----END PGP SIGNATURE-----

--------------enig962A8A59433F6B876C5D05C3--

