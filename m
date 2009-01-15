Message-ID: <496FAEAD.3060604@domain.hid>
Date: Thu, 15 Jan 2009 22:46:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <496F0DBE.5010108@domain.hid>
	<496F1041.20306@domain.hid>	<496F1DD0.1090408@domain.hid>
	<496F3595.9020806@domain.hid> <496F457A.5030000@domain.hid>
In-Reply-To: <496F457A.5030000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C344A1070F402E84698EBFC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Pending patches
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C344A1070F402E84698EBFC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> commit 028d4766a38b6937d9a2c02a20022e3ee5b67b55
>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>> Date:   Thu Jan 15 11:10:24 2009 +0100
>>>>>
>>>>>     POSIX: Fix initialization of SCHED_RR threads
>>>>>    =20
>>>>>     Passing SCHED_RR as policy to pthread_create has currently not =
the
>>>>>     desired effect. The kernel part expects that user space adjusts=
 the
>>>>>     policy and prio via __pse51_thread_setschedparam after setting =
up the
>>>>>     shadow. And this is what the patch does by calling the wrapped
>>>>>     pthread_setschedparam instead of the real one.
>>>>>    =20
>>>>>     Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>
>>>>>  src/skins/posix/thread.c |    2 +-
>>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>
>>>>> commit 71666ce04ef216d281fe86ee82a5560c2b57c6dd
>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>> Date:   Thu Jan 15 11:10:24 2009 +0100
>>>>>
>>>>>     Handle priority changes of SCHED_RR tasks
>>>>>    =20
>>>>>     If shadowed Linux tasks with SCHED_RR policy change their prior=
ity,
>>>>>     do_setsched_event currenty ignores this. Extend the condition t=
o catch
>>>>>     this case as well.
>>>>>    =20
>>>>>     Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>
>>>>>  ksrc/nucleus/shadow.c |    2 +-
>>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>
>>>> Nack these two ones too. Philippe implemented a SCHED_RR working ove=
r
>>>> aperiodic mode. I think the POSIX skin needs fixing, but not that wa=
y.
>>> Then please suggest a better fix.
>> I thought I did: simply pass the SCHED_RR option to kernel-space and
>> handle it there, but replace it with SCHED_FIFO for anything in
>> user-space. I plan to do it, but trunk is not my current priority.
>=20
> This is also a stable bug (so the final version should also be
> backported). However, I will check your proposal.

Extending the __pse51_thread_create syscall to also take the sched
policy is likely no option to fix 2.4.x -- ABI breakage...

Suggestion: Apply my original fix to stable but go the enhanced
__pse51_thread_create path for trunk (I'm working on the latter ATM).

Jan


--------------enig2C344A1070F402E84698EBFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklvrrAACgkQniDOoMHTA+mtLgCbBr1frahVy8iqfY3lP03V23Vp
MIoAn2j8j+upJlTPzCp7QUZfGIu3hyPG
=GAq9
-----END PGP SIGNATURE-----

--------------enig2C344A1070F402E84698EBFC--

