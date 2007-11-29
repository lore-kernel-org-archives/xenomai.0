Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C83299.50183321"
Date: Thu, 29 Nov 2007 16:05:43 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE3C474@domain.hid>
From: <Roderik.Wildenburg@domain.hid>
Subject: [Xenomai-help] rt_queue_write strange behaviour
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

------_=_NextPart_001_01C83299.50183321
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sometimes we get an EINVAL-Error with rt_queue_write.
If we immediatelly after the EINVAL-Error try an a second time to write
to the queue (with exactly the same parameters as at the first time) the
rt_queue_write succeeds (see appended code sniped) !!??

I traced down (xnprintf) the error to the function rt_queue_send where a
plausibility test is made :

if (xnheap_check_block(&q->bufpool, msg) || msg->refcount =3D=3D 0)=20
[approx at line 614]

this test fail as (msg->refcount =3D=3D 0).
If I understand the comment correctly :

/* In case of invalid block or if the sender does not own the
   message, just bail out. */

the sender does not own the message.
But if so, the second try should fail also (and I am quite sure the
message belongs to the sender) ?
Does anyone (probabliy Philipe) has an idea in what situation this
problem could occur or what is the reason for this stange behaviour ?

Unfortunately I could not reproduce this problem in a simple testcase.
Therefore I do not have an simple test case, but with our application
the error occurs regularly (~10 times a hour).
So I rely on your intuition to spike this problem.

Many thanks in advance and best regards
Roderik=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

------_=_NextPart_001_01C83299.50183321
Content-Type: application/octet-stream;
	name="rt_queue_write.c"
Content-Transfer-Encoding: base64
Content-Description: rt_queue_write.c
Content-Disposition: attachment;
	filename="rt_queue_write.c"

ZXJyID0gcnRfcXVldWVfd3JpdGUoJmlwcHRyLT51ZHBSY3ZRLCBucHRyLCBNQVhMRU4vKjEwICsg
bnB0ci0+bGVuKi8sIFFfTk9STUFMKTsNCmlmIChlcnIgPT0gLUVOT01FTSkgICAgIA0Kew0KICAg
ZG9zb21ldGhpbmcoKTsNCn0NCmVsc2UgaWYgKGVyciA8IDApDQp7DQogICBSVF9RVUVVRV9JTkZP
IHFpbmZvOw0KICAgZXJybm8gPSAtZXJyLCBwZXJyb3IoIlByb0Nvbk9TLXVkcFJjdjogcnRfcXVl
dWVfd3JpdGUiKTsNCiAgIGZwcmludGYoc3RkZXJyLCAiZXJyb3I9JWQsIFE9JXAsIG5wdHI9JXBc
biIsIGVyciwgJmlwcHRyLT51ZHBSY3ZRLCBucHRyKTsNCiAgIGlmICgoZXJyPXJ0X3F1ZXVlX2lu
cXVpcmUoJmlwcHRyLT51ZHBSY3ZRLCAmcWluZm8pKTwwKQ0KICAgICAgICAgZnByaW50ZihzdGRl
cnIsICJxdWV1ZV9pbnF1aXJlIDogJWRcbiIsZXJyKTsNCiAgIGVsc2UNCiAgICAgICAgIGZwcmlu
dGYoc3RkZXJyLCAiLS0tLSAlcyBOTXNnOiVkIFNpemU6JWQgdXNlZDolZFxuIixxaW5mby5uYW1l
LCBxaW5mby5ubWVzc2FnZXMscWluZm8ucG9vbHNpemUscWluZm8udXNlZG1lbSk7DQogICBmcHJp
bnRmKHN0ZGVyciwgIjIuIHRyeTogIik7DQogICBlcnIgPSBydF9xdWV1ZV93cml0ZSgmaXBwdHIt
PnVkcFJjdlEsIG5wdHIsIE1BWExFTi8qMTAgKyBucHRyLT5sZW4qLywgUV9OT1JNQUwpOw0KICAg
aWYgKGVyciA8IDApDQogICAgICBlcnJubyA9IC1lcnIsIHBlcnJvcigiUHJvQ29uT1MtdWRwUmN2
OiBydF9xdWV1ZV93cml0ZSAyLiBWZXJzdWNoIik7DQogICBlbHNlDQogICAgICBmcHJpbnRmKHN0
ZGVyciwgIk9LXG4iKTsNCn0=

------_=_NextPart_001_01C83299.50183321--

