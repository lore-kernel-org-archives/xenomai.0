Message-ID: <4788BE8C.5020000@domain.hid>
Date: Sat, 12 Jan 2008 14:20:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <d3623eab0801110744y63764ba2sb122db96a85bde80@domain.hid>	
	<d3623eab0801110806y75b51c1kc31efe7d357de522@domain.hid>	
	<4787B3DB.5010507@domain.hid>
	<2ff1a98a0801111029g3d3312ads532b6ec0ca5bcaf7@domain.hid>
In-Reply-To: <2ff1a98a0801111029g3d3312ads532b6ec0ca5bcaf7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig27E8B8CD75F10D9B4D4CD28C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] cannot make system() calls anymore
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, jay@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27E8B8CD75F10D9B4D4CD28C
Content-Type: multipart/mixed;
 boundary="------------000002090102050602000902"

This is a multi-part message in MIME format.
--------------000002090102050602000902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On Jan 11, 2008 7:22 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Jerome Pasquero wrote:
>>> Hi,
>>>
>>> I recently upgraded from xenomai 2.3.0 under linux 2.6.17.14 to the l=
atest
>>> stable version of xenomai 2.4.1 under linux 2.6.23.12.
>>> Everything seems to be working just fine, except that I seem to  no l=
onger
>>> be able to make system calls inside a real-time task. It simply freez=
es
>>> everything and I need to restart my computer.
>>> I don't know if it was just a fluke that it was working with 2.3.0 an=
d that
>>> I am not supposed to do that at all. Could it be that I forgot to inc=
lude an
>>> option when recompiling the kernel?
>> A system freeze is not a valid reaction of Xenomai on invalid user
>> activity - unless that freeze just means one of your high-prio tasks
>> decided to enter an endless loop. Have you already tried to enable the=

>> Xenomai watchdog?
>=20
> A freeze on fork (system calls fork) is typical of the "nocow" stuff
> not working correctly.

Yep, you are most probably right: The page table walks in
ipipe_disable_ondemand_mappings and below is not safe /wrt unused and
bad entries. A test for p?d_none_or_clear_bad is missing, see attached
patch. Jerome, could you try this one and report if it helps? Please
also watch out for kernel messages that might pop up with this patch.

I'm not %100 sure if we should use clear_bad here or better just ignore
bad pages. Once and only once during the last tests, I had a warning
about a bad page in my syslog after running Jerome's test. On the other
hand, most other code in mm/memory.c does it like that. Opinions?

Jerome's test triggered another, less critical I-pipe bug (SMP-related)
I'm going to report separately.

Jan

--------------000002090102050602000902
Content-Type: text/x-patch;
 name="safe-pagetable-walks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="safe-pagetable-walks.patch"

---
 mm/memory.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.24-rc6-xeno_64/mm/memory.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/mm/memory.c
+++ linux-2.6.24-rc6-xeno_64/mm/memory.c
@@ -2827,6 +2827,8 @@ static inline int ipipe_pin_pmd_range(st
 	pmd =3D pmd_offset(pud, addr);
 	do {
 		next =3D pmd_addr_end(addr, end);
+		if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+			continue;
 		if (ipipe_pin_pte_range(mm, pmd, vma, addr, end))
 			return -ENOMEM;
 	} while (pmd++, addr =3D next, addr !=3D end);
@@ -2843,6 +2845,8 @@ static inline int ipipe_pin_pud_range(st
 	pud =3D pud_offset(pgd, addr);
 	do {
 		next =3D pud_addr_end(addr, end);
+		if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+			continue;
 		if (ipipe_pin_pmd_range(mm, pud, vma, addr, end))
 			return -ENOMEM;
 	} while (pud++, addr =3D next, addr !=3D end);
@@ -2875,6 +2879,8 @@ int ipipe_disable_ondemand_mappings(stru
 		pgd =3D pgd_offset(mm, addr);
 		do {
 			next =3D pgd_addr_end(addr, end);
+			if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+				continue;
 			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
 				result =3D -ENOMEM;
 				goto done_mm;

--------------000002090102050602000902--

--------------enig27E8B8CD75F10D9B4D4CD28C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHiL6QniDOoMHTA+kRAp1hAJ0UYdc+N+SgkhvJjQpo3dh9zOhYXACfRdz/
N3xNhbRvFHPheMdpiMgp4ss=
=DA8N
-----END PGP SIGNATURE-----

--------------enig27E8B8CD75F10D9B4D4CD28C--

