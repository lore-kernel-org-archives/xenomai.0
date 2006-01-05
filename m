Message-ID: <43BCFFBB.1080303@domain.hid>
Date: Thu, 05 Jan 2006 12:15:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <43BC4FFB.8040709@domain.hid> <43BCF891.1080402@domain.hid>
In-Reply-To: <43BCF891.1080402@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F1FDF5139C7D2B11E778AB8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] latency tracer update
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F1FDF5139C7D2B11E778AB8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Hi again,
>>
>> here comes the first update of the new latency tracer.
>>
>>  arch/i386/kernel/entry.S      |   27 +++
> 
> 
> Is there any good reason to patch the callers of __ipipe_handle_irq
> instead of instrumenting the callee directly?
> 

To capture the invocation delay of __ipipe_handle_irq itself.

>>  arch/i386/kernel/ipipe-root.c |    4
>>  include/asm-i386/system.h     |   70 +++++++++
>>  include/linux/ipipe_trace.h   |    3
>>  kernel/ipipe/Kconfig          |   18 ++
>>  kernel/ipipe/tracer.c         |  247 +++++++++++++++++++++++-----------
>>  6 files changed, 288 insertions(+), 81 deletions(-)
>>
> 
> 

Meanwhile I found a solution for the described unterminated trace (put
an explicite trace_end at the end of __ipipe_unstall_iret_root),
included the irq number in the begin/end report, and stumbled over some
other remaining unterminated trace on a different machine. So, no need
to hurry with the merge (not the review! ;) ), I will publish a second
revision first.

Jan

--------------enig4F1FDF5139C7D2B11E778AB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDvP/BniDOoMHTA+kRAnDnAJ9g9kjBiG88jnVIX/0jyQ3q8NLSoACfXlVp
m7p5ep01SNA0h3NJXboFNjU=
=Z01e
-----END PGP SIGNATURE-----

--------------enig4F1FDF5139C7D2B11E778AB8--

