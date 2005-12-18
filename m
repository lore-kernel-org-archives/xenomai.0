Message-ID: <43A56A44.6020308@domain.hid>
Date: Sun, 18 Dec 2005 14:55:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] don't try this at home...
References: <438DD4E2.9080208@domain.hid>	<438DE166.5090303@domain.hid>	<438DE551.7080708@domain.hid>
	<43A32305.8030004@domain.hid> <43A329E6.3080505@domain.hid>
	<43A34F6C.6020904@domain.hid>
In-Reply-To: <43A34F6C.6020904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC6A1DD0EC7D15D4126C55E62"
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
--------------enigC6A1DD0EC7D15D4126C55E62
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
>>> ...
>>> Fixed. The cause was related to the thread migration routine to
>>> primary mode (xnshadow_harden), which would spuriously call the Linux
>>> rescheduling procedure from the primary domain under certain
>>> circumstances. This bug only triggers on preemptible kernels. This
>>> also fixes the spinlock recursion issue which is sometimes triggered
>>> when the spinlock debug option is active.
>>>
>>
>> Gasp. I've found a severe regression with this fix, so more work is
>> needed. More later.
>>
> 
> End of alert. Should be ok now.
> 

No crashes so far, looks good. But the final test, a box which always
went to hell very quickly, is still waiting in my office - more on Monday.

Anyway, there seems to be some latency issues pending. I discovered this
again with my migration test. Please give it a try on a mid- (800 MHz
Athlon in my case) to low-end box. On that Athlon I got peaks of over
100 us in the userspace latency test right on starting migration. The
Athlon does not support the NMI watchdog, but on my 1.4 GHz Notebook
there were alarms (>30 us) hitting in the native registry during
rt_task_create. I have no clue yet if anything is broken there. We need
that back-tracer soon - did I mentioned this before? ;)

BTW, a kernel timer latency test based on a RTDM device is half-done.
I'm able to dump kernel-based timed-task latencies via a patched
testsuite latency. Histograms need to be added as well as a timer
handler latency test. Will keep you posted.

Jan

--------------enigC6A1DD0EC7D15D4126C55E62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDpWpEniDOoMHTA+kRAnNAAJ9ryjQ+DdXBA62n3Sgpq76kzUoeHQCfU4II
a6iUi2+eT2ZQp72mC5kDsbQ=
=qiIA
-----END PGP SIGNATURE-----

--------------enigC6A1DD0EC7D15D4126C55E62--

