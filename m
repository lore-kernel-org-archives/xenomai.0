Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C85366.6F6A6B71"
Date: Thu, 10 Jan 2008 09:54:39 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AEF9AF4@domain.hid>
In-Reply-To: <4784BCDD.9000404@domain.hid>
From: <Roderik.Wildenburg@domain.hid>
Subject: [Xenomai-help] Shared Memory mmap fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C85366.6F6A6B71
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Xenomai Pros,

executing the attached code snippet(a very much striped down satch.c =
example) results in the following error message.

# ./satch
mmap(producer_shm): 6

This means : "ENXIO, the range [off;off+len) is invalid for the shared =
memory region specified by fd;"

This problem does not only occur in this small example but also in my =
application.
Therefore and as I can=B4t see any obvious  mistake in this example, I =
think this could be a problem of Xenomai.=20
Could somedbody try to execute this example and validate if there is a =
general problem ?
I use Xenomai 2.3.5 on a 2.4.25 PPC-kernel.

Thank you very much in advance
Roderik=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

------_=_NextPart_001_01C85366.6F6A6B71
Content-Type: application/octet-stream;
	name="satch.c"
Content-Transfer-Encoding: base64
Content-Description: satch.c
Content-Disposition: attachment;
	filename="satch.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CgojaW5jbHVkZSA8dGltZS5oPgojaW5jbHVkZSA8ZXJybm8uaD4K
I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxzeXMvbW1h
bi5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8bXF1ZXVlLmg+CiNpbmNsdWRlIDxw
b3NpeC9wb3NpeC5oPgoKI2RlZmluZSBTSE1fTkFNRSAiL3NhdGNoc2htIgoKc3RhdGljIHZvaWQg
KnByb2R1Y2VyX3NobSA9IE1BUF9GQUlMRUQ7CgoKdm9pZCBfX3hlbm9fdXNlcl9leGl0ICh2b2lk
KQp7CiAgICBpZiAocHJvZHVjZXJfc2htICE9IE1BUF9GQUlMRUQpCiAgICAgICAgbXVubWFwKHBy
b2R1Y2VyX3NobSwgNjU1MzYpOwogICAgc2htX3VubGluayhTSE1fTkFNRSk7Cn0KCmludCBfX3hl
bm9fdXNlcl9pbml0ICh2b2lkKQoKewogICAgaW50IGZkID0gLTE7CgogICAgZmQgPSBzaG1fb3Bl
bihTSE1fTkFNRSwgT19DUkVBVCB8IE9fUkRXUiwgMDc3Nyk7CiAgICBpZiAoZmQgPT0gLTEpCiAg
ICAgICAgewogICAgICAgIHByaW50Zigic2htX29wZW46ICVkXG4iLCBlcnJubyk7CiAgICAgICAg
cmV0dXJuIC1lcnJubzsKICAgICAgICB9CgogICAgaWYgKGZ0cnVuY2F0ZShmZCwgNjU1MzYpKQog
ICAgICAgIHsKICAgICAgICBwcmludGYoImZ0cnVuY2F0ZTogJWRcbiIsIGVycm5vKTsKICAgICAg
ICBjbG9zZShmZCk7CiAgICAgICAgcmV0dXJuKC0xKTsKICAgICAgICB9CgogICAgCiAgICBwcm9k
dWNlcl9zaG0gPSBtbWFwKE5VTEwsIDY1NTM2LCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBNQVBf
U0hBUkVELCBmZCwgMCk7CiAgICBpZiAocHJvZHVjZXJfc2htID09IE1BUF9GQUlMRUQpCiAgICAg
ICAgewogICAgICAgIHByaW50ZigibW1hcChwcm9kdWNlcl9zaG0pOiAlZFxuIiwgZXJybm8pOwog
ICAgICAgIHJldHVybiAtZXJybm87CiAgICAgICAgfQogICByZXR1cm4oZmQpOwp9CgppbnQgbWFp
biAoaW50IGFjLCBjaGFyICphdltdKQoKewogICAgc2lnc2V0X3QgbWFzazsKICAgIGludCByYywg
c2lnOwoKICAgIHNpZ2VtcHR5c2V0KCZtYXNrKTsKICAgIHNpZ2FkZHNldCgmbWFzayxTSUdJTlQp
OwogICAgc2lnYWRkc2V0KCZtYXNrLFNJR1RFUk0pOwogICAgc2lnYWRkc2V0KCZtYXNrLFNJR0hV
UCk7CiAgICBzaWdhZGRzZXQoJm1hc2ssU0lHQUxSTSk7CgogICAgcHRocmVhZF9zaWdtYXNrKFNJ
R19CTE9DSywgJm1hc2ssIE5VTEwpOwoKICAgIG1sb2NrYWxsKE1DTF9DVVJSRU5UfE1DTF9GVVRV
UkUpOwoKICAgIHJjID0gX194ZW5vX3VzZXJfaW5pdCgpOwoKICAgIGlmIChyYz4wKQogICAgICAg
IHsKICAgICAgICAgICBjbG9zZShyYyk7CiAgICAgICAgfQoKICAgIHNpZ3dhaXQoJm1hc2ssICZz
aWcpOwogICAgX194ZW5vX3VzZXJfZXhpdCgpOwoKICAgIHJldHVybiAwOwp9Cg==

------_=_NextPart_001_01C85366.6F6A6B71
Content-Type: application/octet-stream;
	name="Makefile"
Content-Transfer-Encoding: base64
Content-Description: Makefile
Content-Disposition: attachment;
	filename="Makefile"

QVBQTElDQVRJT05TID0gc2F0Y2gKCmFsbDo6CgpzYXRjaDogc2F0Y2guYwoKCgojIyMgRGVmYXVs
dCBYZW5vbWFpIGluc3RhbGxhdGlvbiBwYXRoClhFTk8gPz0gL29wdC9lbGRrL3hlbm9tYWkKClhF
Tk9DT05GSUc9JChzaGVsbCBQQVRIPSQoWEVOTyk6JChYRU5PKS9iaW46JChQQVRIKSB3aGljaCB4
ZW5vLWNvbmZpZyAyPi9kZXYvbnVsbCkKCgpDQz0kKHNoZWxsICQoWEVOT0NPTkZJRykgLS1jYykK
CkNGTEFHUz0gJChzaGVsbCAkKFhFTk9DT05GSUcpIC0tcG9zaXgtY2ZsYWdzKQoKTERGTEFHUz0k
KHNoZWxsICQoWEVOT0NPTkZJRykgLS1wb3NpeC1sZGZsYWdzKQoKCmFsbDo6ICQoQVBQTElDQVRJ
T05TKQoKY2xlYW46OgoJJChSTSkgJChBUFBMSUNBVElPTlMpICoubwoKCgoKCgo=

------_=_NextPart_001_01C85366.6F6A6B71--

