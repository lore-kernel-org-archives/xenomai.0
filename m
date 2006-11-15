Message-ID: <455B9A30.5040909@domain.hid>
Date: Wed, 15 Nov 2006 23:52:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
References: <200611151121.51836.s.zimmermann@domain.hid>	
	<b647ffbd0611150519w1a510582n40782bdccaa7562d@domain.hid>	
	<200611151544.00429.s.zimmermann@domain.hid>
	<455B8016.2020605@domain.hid>	 <1163629342.4974.36.camel@domain.hid>
	<455B9666.8080604@domain.hid> <1163630779.4974.45.camel@domain.hid>
In-Reply-To: <1163630779.4974.45.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA17C5155B581CB90444B3B0E"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA17C5155B581CB90444B3B0E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-11-15 at 23:36 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2006-11-15 at 22:01 +0100, Jan Kiszka wrote:
>>>
>>>> /me unfortunately failed to reproduce your problem here. Instead, I
>>>> found a regression in SVN head - different story for a different thr=
ead.
>>>>
>>> It's reproducible here. This bug triggers if you leave enough time
>>> between queue creation and deletion for Linux to deal with its usual
>>> business, like running workqueues... Additionally, this bug would not=

>>> trigger with different queue names passed to the creation routines. I=
t
>>> seems to be caused by out-of-sequence create/delete requests of /proc=

>>> entries relayed to the proc_fs subsystem, which does not perform any
>>> sanity checks on the data it is submitted.
>>>
>> Yes, that delay makes the difference. I just added a huge one (100
>> ticks), and now I get tones of this:
>>
>>> xenomai 2.2.4 timer-test
>>> task shadow:0
>>> timer set mode:0
>>> task sleep:0
>>> testing XENOMAI q-functions
>>> Bad page state in process 'maintask'
>>> page:c10e8b20 flags:0x80000400 mapping:00000000 mapcount:0 count:0
>>> Trying to fix it up, but a reboot is needed
>>> Backtrace:
>>>  <c0103055> show_trace+0x12/0x14  <c01035e0> dump_stack+0x1c/0x1e
>>>  <c0157104> bad_page+0x49/0x73  <c01577d8> free_hot_cold_page+0x68/0x=
13d
>>>  <c01578fb> free_hot_page+0xf/0x11  <c0157a17> __free_pages+0x2e/0x39=

>>>  <c01646f2> __vunmap+0x90/0xbc  <c01647c4> vfree+0x2e/0x30
>>>  <c01388ca> xnheap_destroy_mapped+0xe2/0x11b  <c8887d93> rt_queue_del=
ete+0xb5/0xf2 [xeno_native]
>>>  <c88836d9> __rt_queue_delete+0x4e/0x72 [xeno_native]  <c0141b20> los=
yscall_event+0xa3/0x145
>>>  <c013594f> __ipipe_dispatch_event+0xac/0x16c  <c0109fd2> __ipipe_sys=
call_root+0x78/0x100
>>>  <c02a5520> system_call+0x20/0x38=20
>> Is this also what you see? Looks quite different on first sight. [Note=
:
>> it's on a qemu box.]
>>
>=20
> Uh, no. Try removing the second part of your heap patch, regarding the
> memory unreservation routine.
>=20

Ouch, that part of my patch was nonsense, indeed. Fine again now.

Jan


--------------enigA17C5155B581CB90444B3B0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFW5owniDOoMHTA+kRAvmwAJ49jBz8CNHD+2Rug1yKI6CqK/Bq5ACeIJpC
IpcJKjc5JwLJoIfLsBZu6XE=
=bAx5
-----END PGP SIGNATURE-----

--------------enigA17C5155B581CB90444B3B0E--

