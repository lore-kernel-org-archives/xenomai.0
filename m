Message-ID: <455B82F3.702@domain.hid>
Date: Wed, 15 Nov 2006 22:13:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig90EBD8C7C2A8E60EDDC778CD"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] commit #1833 breaks rt_queue_create
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90EBD8C7C2A8E60EDDC778CD
Content-Type: multipart/mixed; boundary="------------090906030102030809020505"

This is a multi-part message in MIME format.
--------------090906030102030809020505
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

As xnheap_size() changed, a sanity check in xnheap_mmap fails now, at
least for SVN head, maybe also 2.2.x.

I would suggest the following patch to fix this, though I'm not 100%
sure its correct in all cases (do we ever come across a heap of multiple
extents in xnheap_mmap?).

Jan


PS: I'll spent a beer (or two...) for the one who starts writing a
testsuite for the native skin - in user-space, please, to catch also
issues like this one.

--------------090906030102030809020505
Content-Type: application/octet-stream;
 name="fix-mapped-heap-size.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fix-mapped-heap-size.patch"

SW5kZXg6IGtzcmMvbnVjbGV1cy9oZWFwLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0ga3NyYy9udWNs
ZXVzL2hlYXAuYwkoUmV2aXNpb24gMTgzNSkKKysrIGtzcmMvbnVjbGV1cy9oZWFwLmMJKEFy
YmVpdHNrb3BpZSkKQEAgLTk1Miw3ICs5NTIsNyBAQCBzdGF0aWMgaW50IHhuaGVhcF9tbWFw
KHN0cnVjdCBmaWxlICpmaWxlCiAJc2l6ZSA9IHZtYS0+dm1fZW5kIC0gdm1hLT52bV9zdGFy
dDsKIAloZWFwID0gKHhuaGVhcF90ICopZmlsZS0+cHJpdmF0ZV9kYXRhOwogCi0JaWYgKHNp
emUgIT0gaGVhcC0+ZXh0ZW50c2l6ZSkKKwlpZiAoc2l6ZSAhPSB4bmhlYXBfc2l6ZShoZWFw
KSkKIAkJcmV0dXJuIC1FTlhJTzsJLyogRG9lc24ndCBtYXRjaCB0aGUgaGVhcCBzaXplLiAq
LwogCiAJdm1hLT52bV9vcHMgPSAmeG5oZWFwX3Ztb3BzOwpAQCAtMTEzNSw3ICsxMTM1LDcg
QEAgaW50IHhuaGVhcF9kZXN0cm95X21hcHBlZCh4bmhlYXBfdCAqaGVhcAogCXhubG9ja19w
dXRfaXJxcmVzdG9yZSgmbmtsb2NrLCBzKTsKIAogCV9fdW5yZXNlcnZlX2FuZF9mcmVlX2hl
YXAoaGVhcC0+YXJjaGRlcC5oZWFwYmFzZSwKLQkJCQkgIGhlYXAtPmV4dGVudHNpemUsIGhl
YXAtPmFyY2hkZXAua21mbGFncyk7CisJCQkJICB4bmhlYXBfc2l6ZShoZWFwKSwgaGVhcC0+
YXJjaGRlcC5rbWZsYWdzKTsKIAlyZXR1cm4gMDsKIH0KIAoAAAAAAAAA
--------------090906030102030809020505--

--------------enig90EBD8C7C2A8E60EDDC778CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFW4LzniDOoMHTA+kRAtYBAJ9RoNKskPVXlRAaqQaaFAL4rpM7nACeJliT
nJI1HQJL2Zn2F+RmBfXVh1E=
=qfJG
-----END PGP SIGNATURE-----

--------------enig90EBD8C7C2A8E60EDDC778CD--

