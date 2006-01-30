Message-ID: <43DE0955.7060608@domain.hid>
Date: Mon, 30 Jan 2006 13:40:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Dual Xeon, 2.6.10, adeos-r13
References: <200601251105.k0PB5uPK028509@domain.hid>
	<43D7CD2F.9030709@domain.hid>
In-Reply-To: <43D7CD2F.9030709@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB98D2497470B777D4069C598"
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
To: Nathaniel Villaume <villaume@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB98D2497470B777D4069C598
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nathaniel Villaume wrote:
> Hi all,
>=20
> I can't seem to find any info about Dual Xeon and Xenomai (well, ADEOS,=

> really). Is this a configuration that is expected to work?  What about
> smp Athlon? or DualCore Athlon? (I think Opteron is not in the picture
> yet, right?)

x86-64 is not yet supported by Xenomai (hmm, would be a nice next goal
now that ARM is running... ;)). But everything that runs in plain x86
mode has to work.

But don't use oldgen adeos patches with Xenomai anymore, use the recent
ipipe patches. Pick Xenomai 2.0.3 or 2.1-rc2 and install a fitting patch
that comes with it.

>=20
> For the dual Xeon, I'm able to patch and build fine, but boot stalls
> after the hardware has been initialized by the init process.
> (i.e. The last line I get from Fedora Core 3 Init 2.85 booting says:
> Initializing hardware... storage network, audio done [ok])
>=20
> I've done what I think are correct:
> - turned off HyperThreading in both bios and in kernel config

That's recommended as HyperThreading degrades RT performance (but it
should not crash your box, though).

> - disabled REGPARM

That is only needed for RTAI to work around its oddities. It is NOT
needed for Xenomai.

>=20
> The Processor family  is set to Pentium 4 and sub arch is set to Generi=
c
> architecture (X86_GENERICARCH), but I've also tried Pc Compatible (X86)=

> to  the same effect.
> I used an adeos-r9 patch that came with RTAI, and I at least got the
> system to boot. But RTAI puked when loading the SMP scheduler....

Are we now talking about RTAI or do you still mean Xenomai? Note that
both projects have almost nothing organisationally in common anymore.
RTAI is patching the original ipipe-patches for its purpose, so the
golden rule is: use only that patch that comes with the desired
real-time extension, don't mix both up!

>=20
> Is there anything else I might do to make this work?  What is the
> confidence level in SMP support?

I would say that SMP is not that intensively tested as UP, but there are
no known issues ATM which should prevent it from working (AFAIK).

If you think you have found a bug in a *recent* version (2.0.3/2.1-rc2),
please report again precisely what you did. Start with getting a
*vanilla* kernel booted, then continue with adding the ipipe and finally
Xenomai itself. Please also provide your .config if step #2 or #3 fails.

Jan


--------------enigB98D2497470B777D4069C598
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3glVniDOoMHTA+kRAi3VAJ4mtauWKwk97gWA3fFTmfz+0h+wlwCfbFVp
4/1Qj5vc8/75bobFjIVdTGQ=
=farG
-----END PGP SIGNATURE-----

--------------enigB98D2497470B777D4069C598--

