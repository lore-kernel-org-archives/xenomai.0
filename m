Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C835BF.88D6B289"
Date: Mon, 3 Dec 2007 16:16:51 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE66E86@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE66E11@domain.hid>
From: <Roderik.Wildenburg@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write strange behaviour ++ testcase !!
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C835BF.88D6B289
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

After I realized that the error depends on TM_NONBLOCK in the queue =
reading task (rt_queue_read(&qtest1q, &buf, sizeof (buf), TM_NONBLOCK)), =
I finaly succeded in generating a simple testcase !

On my target (PPC 400MHZ) the appended programm produces an EINVAL error =
with rt_queue_write nearly immediately and the second rt_queue_write =
succeeds nearly allways.

So, could you/Philippe try this testcase on your target and tell me =
whether you face the same problem.

Thanks a lot for yor help
Roderik
=20

> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von=20
> Roderik.Wildenburg@domain.hid
> Gesendet: Montag, 3. Dezember 2007 14:31
> An: rpm@xenomai.org
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] rt_queue_write strange behaviour ++
>=20
> > Does the attached patch trigger any message when your app fails?
>=20
> Unforunatelly not (there is no message in /var/log/messages=20
> (see below)).
> (see also my mail from 30.11. 13:27)
>=20
> I still can=B4t see, were refcount can get zero when=20
> rt_queue_write is used.
> Whatever problem occurs, refcount should stay one, as set by=20
> rt_queue_alloc.
> Can you imagine a scenario where refcount gets 0 ? If so,=20
> please tell me, so I can
> build a test case around it.
>=20
> Many thanks for your help from a very helpless
> Roderik
>=20
>=20
> fer1_764_4080605:~ # tail /var/log/messages
> Dec  3 15:15:11 (none) user.info kernel: Xenomai: ----=20
> xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
> Dec  3 15:15:11 (none) user.info kernel: Xenomai: ----=20
> xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
> Dec  3 15:15:11 (none) user.info kernel: Xenomai: ----=20
> xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
> Dec  3 15:15:13 (none) user.info kernel: Xenomai: ----=20
> xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
> Dec  3 15:15:16 (none) user.info kernel: Xenomai: ----=20
> xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
> Dec  3 15:15:20 (none) user.info kernel: Xenomai: ----=20
> xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
>=20
> > -----Urspr=FCngliche Nachricht-----
> > Von: Philippe Gerum [mailto:philippe.gerum@domain.hid] Im=20
> > Auftrag von Philippe Gerum
> > Gesendet: Freitag, 30. November 2007 11:55
> > An: Wildenburg, Roderik RAEK3 MRA
> > Cc: xenomai@xenomai.org
> > Betreff: Re: [Xenomai-help] rt_queue_write strange behaviour ++
> >=20
> > Roderik.Wildenburg@domain.hid wrote:
> > > Sorry, but in my last mail (see below) I had forgotten to=20
> > tell you my=20
> > > Xenomai-Version and architecture.
> > > I still use Xenomai 2.3.2 on PPC.
> > >=20
> > > In the meantime I had a deeper look into the Xenomai source code=20
> > > and I would say, the case we observed (msg->refcount =3D=3D 0 ;=20
> > see below)
> > > isn=B4t possible with rt_queue_write, as this function=20
> > implicitly allocate=20
> > > its messagebuffer and rt_queue_alloc initilaizes refcount to 1.
> > > Immediatelly after this rt_queue_send is called, where the=20
> > > plausibility test if( msg->refcount =3D=3D 0) is done and fails.=20
> > > So, I can=B4t see a gap where refcount falls back to 0.
> >=20
> > Does the attached patch trigger any message when your app fails?
> >=20
> > --=20
> > Philippe.
> >=20
>=20
> MAN Roland Druckmaschinen AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr.=20
> Markus Rall, Paul Steidle   =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht:=20
> Amtsgericht Offenbach HRB-Nr. 42592   =20
> USt-Ident-Nr. DE 250200933
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

------_=_NextPart_001_01C835BF.88D6B289
Content-Type: application/octet-stream;
	name="qtest.c"
Content-Transfer-Encoding: base64
Content-Description: qtest.c
Content-Disposition: attachment;
	filename="qtest.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxhc3NlcnQuaD4KI2luY2x1ZGUgPHN5cy90eXBl
cy5oPgojaW5jbHVkZSA8c3lzL2lwYy5oPgojaW5jbHVkZSA8c3lzL3NobS5oPgojaW5jbHVkZSA8
c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8bmV0aW5ldC9pbi5oPgojaW5jbHVkZSA8YXJwYS9pbmV0
Lmg+CiNpbmNsdWRlIDxzeXMvdW4uaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxzdGRs
aWIuaD4KI2luY2x1ZGUgPHN0ZGRlZi5oPgojaW5jbHVkZSA8c3RkYXJnLmg+CiNpbmNsdWRlIDxz
eXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2lu
Y2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2lu
Y2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgoKI2luY2x1ZGUgPG5hdGl2ZS90
YXNrLmg+CiNpbmNsdWRlIDxuYXRpdmUvcXVldWUuaD4KCiNkZWZpbmUgZWludmFsCgojaWZkZWYg
ZWludmFsICAgICAgCiAgICNkZWZpbmUgIE1BWExFTiAgIDE4MzAgIC8qIGdy9t9lciBtYXhpbWFs
ZSBOYWNocmljaHRlbmzkbmdlICovCiAgICNkZWZpbmUgIE1BWFdBSVQgIDEwMDAwMCAKICAgI2Rl
ZmluZSAgTUlOV0FJVCAgMTAwMDAwIAojZW5kaWYKCiNpZmRlZiBlbm9tZW0gICAKICAgI2RlZmlu
ZSAgTUFYTEVOICAgMTAyNCAgLyogZ3L232VyIG1heGltYWxlIE5hY2hyaWNodGVubORuZ2UgKi8K
I2VuZGlmCiNkZWZpbmUgQ09OVFJPTExFUl9XQUlUMSAxNTAwMDAwMDAKI2RlZmluZSBDT05UUk9M
TEVSX1dBSVQyIDE1MDAwMDAwCiNkZWZpbmUgQ09OVFJPTExFUl9XQUlUMyAxMjMwMDAwMAoKClJU
X1FVRVVFIHF0ZXN0MXE7ClJUX1RBU0sgcXRlc3QxLCBxdGVzdDIsIHF0ZXN0MzsKCgp2b2lkIHF0
ZXN0cnQodm9pZCkKewogICBzc2l6ZV90IGxlbjsKICAgc3RhdGljIGNoYXIgYnVmW01BWExFTl07
CiAgIGxvbmcgdHdhaXQ7CgogICBmb3IgKDs7KQogICB7CiNpZmRlZiBlbm9tZW0gICAgICAKICAg
ICAgaWYgKChsZW4gPSBydF9xdWV1ZV9yZWFkKCZxdGVzdDFxLCAmYnVmLCBzaXplb2YgKGJ1Ziks
IFRNX0lORklOSVRFKSkgPCAwKQogICAgICB7CiAgICAgICAgIHByaW50ZigicXRlc3QxdDogcnRf
cXVldWVfcmVhZCBmYWlsZWQgd2l0aCAlZFxuIixsZW4pOwogICAgICAgICBwZXJyb3IoInBlcnJv
ciBxdGVzdDF0OiBydF9xdWV1ZV9yZWFkIik7CiAgICAgICAgIGVycm5vID0gLWxlbiwgcGVycm9y
KCJwZXJyb3IyIHF0ZXN0MXQ6IHJ0X3F1ZXVlX3JlYWQiKTsKICAgICAgfQojZW5kaWYgICAgICAK
I2lmZGVmIGVpbnZhbCAgICAgIAogICAgICBydF9xdWV1ZV9yZWFkKCZxdGVzdDFxLCAmYnVmLCBz
aXplb2YgKGJ1ZiksIFRNX05PTkJMT0NLKTsKICAgICAgdHdhaXQ9IChsb25nKSAoKGZsb2F0KSgo
ZmxvYXQpcmFuZCgpLyhmbG9hdClSQU5EX01BWCkgKiAoZmxvYXQpTUFYV0FJVCArIChmbG9hdClN
SU5XQUlUICk7CiAgICAgIHJ0X3Rhc2tfc2xlZXAodHdhaXQpOwojZW5kaWYgICAgICAKICAgfQog
ICAgCn0KCnZvaWQgcXRlc3R3dCh2b2lkKiBwYXIpCnsKICAgaW50IHJldCwgbGVuOwogICBSVF9R
VUVVRV9JTkZPIHFpbmZvOwogICBjaGFyIGJ1ZltNQVhMRU5dOwogICBpbnQgenVmOwogICBsb25n
IHR3YWl0OwoKICAgdHdhaXQ9KGludClwYXI7CiAgIHByaW50ZigicXRlc3R3dCBzdGFydCAhICVs
ZFxuIix0d2FpdCk7CiAgIGZvciAoOzspCiAgIHsKICAgICAgenVmPXJhbmQoKTsKI2lmZGVmIGVp
bnZhbCAgICAgIAogICAgICBsZW49TUFYTEVOOwogICAgICB0d2FpdD16dWY+PjU7CiNlbHNlICAg
ICAgCiAgICAgIGxlbj0gKGludCkgKChmbG9hdCkoKGZsb2F0KXp1Zi8oZmxvYXQpUkFORF9NQVgp
ICogKGZsb2F0KShNQVhMRU4tMTApICsgMi4wICk7CiNlbmRpZiAgICAgIAogICAgICAvL3ByaW50
ZigiV3JpdGVRdWV1ZSAlZCAlZFxuIixsZW4senVmKTsKICAgICAgaWYgKChyZXQgPSBydF9xdWV1
ZV93cml0ZSgmcXRlc3QxcSwgJmJ1ZiwgbGVuICwgUV9OT1JNQUwpKSA8IDApCiAgICAgIHsKICAg
ICAgICAgZXJybm8gPSAtcmV0LCBwZXJyb3IoInF0ZXN0d3Q6IHJ0X3F1ZXVlX3dyaXRlIGVycm9y
Iik7CiAgICAgICAgIHByaW50ZigiTWVzc2FnZSBzaXplIDolZCByZXR1cm4gOiAlZFxuIixsZW4s
IHJldCk7CiAgICAgICAgIGlmKCAocmV0PXJ0X3F1ZXVlX2lucXVpcmUoJnF0ZXN0MXEsJnFpbmZv
KSk8MCkKICAgICAgICAgewogICAgICAgICAgICBwcmludGYoInF1ZXVlX2lucXVpcmUgOiAlZFxu
IixyZXQpOwogICAgICAgICB9CiAgICAgICAgIGVsc2UKICAgICAgICAgewogICAgICAgICAgICBw
cmludGYoIi0tLS0gJXMgTk1zZzolZCBTaXplOiVkIHVzZWQ6JWRcbiIscWluZm8ubmFtZSwgcWlu
Zm8ubm1lc3NhZ2VzLHFpbmZvLnBvb2xzaXplLHFpbmZvLnVzZWRtZW0pOwogICAgICAgICB9CiAg
ICAgICAgIHByaW50ZigiMi4gdHJpYWwgXG4iKTsKICAgICAgICAgaWYgKChyZXQgPSBydF9xdWV1
ZV93cml0ZSgmcXRlc3QxcSwgJmJ1ZiwgbGVuICwgUV9OT1JNQUwpKSA8IDApCiAgICAgICAgICAg
IHByaW50ZigiZmFpbGVkXG4iKTsKICAgICAgICAgZWxzZQogICAgICAgICAgICBwcmludGYoIk9L
XG4iKTsKICAgICAgfQogICAgICBydF90YXNrX3NsZWVwKHR3YWl0KTsKICAgfQp9CiAgICAKCmlu
dCBzdGFydHF0ZXN0KHZvaWQpCnsKICAgaW50IGVycjsKICAgaW50IHR3YWl0OwoKICAgc3JhbmQg
KHRpbWUgKDApKTsKICAgCiAgIGlmKCFydF9xdWV1ZV9iaW5kKCZxdGVzdDFxLCJxdGVzdDFxIixU
TV9OT05CTE9DSykpCiAgICAgIHJ0X3F1ZXVlX2RlbGV0ZSgmcXRlc3QxcSk7CiAgIGlmKCAoZXJy
ID0gcnRfcXVldWVfY3JlYXRlKCZxdGVzdDFxLCAicXRlc3QxcSIsIE1BWExFTioxMCwgUV9VTkxJ
TUlURUQsIFFfRklGTykpICE9IDAgKQogICAgICBwcmludGYoInFfY3JlYXRlIHF0ZXN0MXEgZmFp
bGVkIHdpdGggJWRcbiIsZXJyKTsKCiAgIGVyciA9IHJ0X3Rhc2tfY3JlYXRlKCZxdGVzdDEsICJx
dGVzdDF0IiwgMCwgNTAsIDApOyAgIC8qIFJlYWQgKi8KICAgaWYgKCFlcnIpCiAgICAgIHJ0X3Rh
c2tfc3RhcnQoJnF0ZXN0MSwgKHZvaWQoKikodm9pZCAqKSlxdGVzdHJ0LCBOVUxMKTsKCiAgIGVy
ciA9IHJ0X3Rhc2tfY3JlYXRlKCZxdGVzdDIsICJxdGVzdHcydCIsIDAsIDMwLCAwKTsgICAvKiBX
cml0ZSAqLwojaWZkZWYgZW5vbWVtICAgCiAgIHR3YWl0PUNPTlRST0xMRVJfV0FJVDE7CiNlbmRp
ZgojaWZkZWYgZWludmFsICAgCiAgIHR3YWl0PUNPTlRST0xMRVJfV0FJVDI7CiNlbmRpZiAgIAog
ICBpZiAoIWVycikKICAgICAgcnRfdGFza19zdGFydCgmcXRlc3QyLCAodm9pZCgqKSh2b2lkICop
KXF0ZXN0d3QsICh2b2lkKil0d2FpdCk7CiAgIAojaWZkZWYgZWludmFsCiAgIGVyciA9IHJ0X3Rh
c2tfY3JlYXRlKCZxdGVzdDMsICJxdGVzdHczdCIsIDAsIDMwLCAwKTsgICAvKiBXcml0ZSAqLwog
ICBpZiAoIWVycikKICAgICAgcnRfdGFza19zdGFydCgmcXRlc3QzLCAodm9pZCgqKSh2b2lkICop
KXF0ZXN0d3QsICh2b2lkKilDT05UUk9MTEVSX1dBSVQzKTsKI2VuZGlmCiAgIAogICByZXR1cm4o
MCk7CgoKfQoKCmludCBtYWluIChpbnQgYWMsIGNoYXIgKmF2W10pCgp7CiAgICBzaWdzZXRfdCBt
YXNrOwogICAgaW50IHNpZzsKCiAgICBwcmludGYoInF0ZXN0IHN0YXJ0ICFcbiIpOwogICAgc2xl
ZXAoMik7CgogICAgc2lnZW1wdHlzZXQoJm1hc2spOwogICAgc2lnYWRkc2V0KCZtYXNrLFNJR0lO
VCk7CiAgICBzaWdhZGRzZXQoJm1hc2ssU0lHVEVSTSk7CiAgICBzaWdhZGRzZXQoJm1hc2ssU0lH
SFVQKTsKICAgIHNpZ2FkZHNldCgmbWFzayxTSUdBTFJNKTsKCiAgICBwdGhyZWFkX3NpZ21hc2so
U0lHX0JMT0NLLCAmbWFzaywgTlVMTCk7CgogICAgbWxvY2thbGwoTUNMX0NVUlJFTlR8TUNMX0ZV
VFVSRSk7CgogICAgc3RhcnRxdGVzdCgpOwoKCiAgICBzaWd3YWl0KCZtYXNrLCAmc2lnKTsKCiAg
ICByZXR1cm4gMDsKfQo=

------_=_NextPart_001_01C835BF.88D6B289--

