Message-ID: <43AAC0A2.7020409@domain.hid>
Date: Thu, 22 Dec 2005 16:05:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] don't try this at home...
References: <438DD4E2.9080208@domain.hid>	<438DE166.5090303@domain.hid>	<438DE551.7080708@domain.hid>
	<43A32305.8030004@domain.hid> <43A329E6.3080505@domain.hid>
	<43A34F6C.6020904@domain.hid> <43A56A44.6020308@domain.hid>
	<43A5AACF.6050505@domain.hid>
In-Reply-To: <43A5AACF.6050505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig530A61FB81BB1936F8EF75E8"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig530A61FB81BB1936F8EF75E8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> ...
>> Anyway, there seems to be some latency issues pending. I discovered this
>> again with my migration test. Please give it a try on a mid- (800 MHz
>> Athlon in my case) to low-end box. On that Athlon I got peaks of over
>> 100 us in the userspace latency test right on starting migration. The
>> Athlon does not support the NMI watchdog, but on my 1.4 GHz Notebook
>> there were alarms (>30 us) hitting in the native registry during
>> rt_task_create. I have no clue yet if anything is broken there.
> 
> 
> I suspect that rt_registry_enter() is inherently a long operation when
> considered as a non-preemptible sum of reasonably short ones. Since it
> is always called with interrupts enabled, we should split the work in
> there, releasing interrupts in the middle. The tricky thing is that we
> must ensure that the new registration slot is not exposed in a
> half-baked state during the preemptible section.
> 

Grr, I should stop profiling systems which have DEBUG options switched
on (e.g. Xenomain's queue debugging...). This totally skrewed up my
measurings - end of alarm, all fine!

Anyway, keeping the number of ops inside continues lock paths low is a
good thing. But if the task deletions path is already one of the most
critical points, needs some analysis first.

Jan

--------------enig530A61FB81BB1936F8EF75E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDqsCjniDOoMHTA+kRAqQRAJ9qfW4cTOTWadYZAM2OMoJd4YTawwCbBT9k
IYUOMZHlxOT0PueR1Yw/v3I=
=+8ic
-----END PGP SIGNATURE-----

--------------enig530A61FB81BB1936F8EF75E8--

