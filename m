Message-ID: <46441EC7.4000603@domain.hid>
Date: Fri, 11 May 2007 09:44:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <15183185.1178867312688.JavaMail.ngmail@domain.hid>
In-Reply-To: <15183185.1178867312688.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9B45E61DB6593532328B0591"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B45E61DB6593532328B0591
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi,
>=20
> here are my latest results:
> I included xeno_nucleus and xeno_native into the kernel. (see first opr=
ofile result).
> (I also added debug information to the kernel which was of no additiona=
l help).
> I detected that most of the time was spent in __ipipe_hard_cpuid.
> I looked at that routine and broke that using 2 additional helper funct=
ions that are use
> to "monitor" the apic_read() resp. the GET_APIC_ID calls (see patch bel=
ow).
> The results of this experiment can be found at "second oprofile result"=
 below.
> When I interpret the results correctly, then it looks as if the apic_re=
ad() is actually
> eating up the performance. As this call "leaves" the CPU internal "area=
" and accesses the external=20
> APIC this sounds sensible.
> I think this is done here to detect the current CPU.
> Is it possible to detect differently or to store that information someh=
ow with a thread (TLS)
> to avoid requesting it frequently?

Actually, this is how Linux works. On x86, it used to derive the CPU ID
from current_thread_info, which required a valid "current" what Xenomai
kernel threads do not guarantee (their stack size is variable, but Linux
needs a fixed, predefined one to resolve current). Nowadays (>=3D 2.6.20)=

we have PDA (Per-CPU Data Array) on x86, a register based approach, and
I think we could safely use it for I-pipe/Xenomai as well. That would
make A LOT of thinks easier, because replacing smp_processor_id all over
the place to make some code I-pipe aware is a boring job (I recently did
so for LTTng...) - and it results in slower code on SMP.

As an experiment, you could try implementing the cpuid lookup via
raw_smp_processor_id(), given you use 2.6.20. Hmm, maybe/likely some
Xenomai tuning is required as well to make sure that the PDA is set
correctly when a Xenomai task is created/migrated. Results welcome!

Jan


--------------enig9B45E61DB6593532328B0591
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGRB7HniDOoMHTA+kRAu7CAJ481tbk8L6074lvkinS9m+XRa3OwwCfYdW4
rMKkaTPUoUNhRRfxInNLD50=
=DX01
-----END PGP SIGNATURE-----

--------------enig9B45E61DB6593532328B0591--

