Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C866B7.BAD4D8D8"
Date: Sun, 3 Feb 2008 15:54:27 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768BF@slcmail.slc.mew.int>
In-Reply-To: <18342.13282.822800.458093@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768BB@slcmail.slc.mew.int>
	<18342.13282.822800.458093@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_read and pthread_cancel()
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
Cc: xenomai@xenomai.org


This is a multi-part message in MIME format.

------_=_NextPart_001_01C866B7.BAD4D8D8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This example behaves as expected. There must be some issue with my main
application causing a problem. I have the same model set up, but
sometimes the thread won't cancel and instead waits forever in
rt_queue_read().

I realize with async cancels, there is no reason for the call to
pthread_testcancel().

I've solved the main app's problem by putting
rt_task_set_mode(T_PRIMARY, 0, 0); before the call to rt_queue_read()
which forces it into the secondary domain. However, this seems real
strange to me... the problem happens about 50% of the time but becomes
100% if I put a printf() after rt_queue_read() returns.=20

Again, the example works perfectly.

Here's the code from the app with the issue and the "hack" to fix it:

rt_task_set_mode(T_PRIMARY, 0, 0);
pthread_testcancel(); //cancellation point
r =3D rt_queue_read(&treatment_meas_queue, &meas, sizeof(meas),
TM_INFINITE);
rt_task_set_mode(T_PRIMARY, 0, 0);
pthread_testcancel(); //cancellation point

The timing of this thread (pthread, shadowed) is driven by the queue. It
will drop to the secondary domain as needed. (Not realtime critical.)=20

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, February 03, 2008 2:37 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_queue_read and pthread_cancel()
>=20
> Steven Seeger wrote:
>  > If I have a shadowed thread that was created with pthread_create()
and
>  > rt_task_shadow() that calls rt_queue_read() with an infinite
timeout,
> is
>  > there any reason it would not receive a cancellation point? I have
an
>  > intermittent lock in pthread_join() on that thread while it's
blocked
> in
>  > rt_queue_read(). I call pthread_cancel() on the thread first. I
have
> the
>  > rt_queue_read() call with a pthread_testcancel() before and after
it.
>=20
> You do not need to call pthread_testcancel(): rt_task_shadow sets the
> thread cancellation type to PTHREAD_CANCEL_ASYNCHRONOUS, which means
> that pthread_cancel will send a signal to this thread to terminate
> it. So, the reason for the deadlock is probably elsewhere. Could you
> reduce your application to a small self-contained test which wouls
show
> us what you are observing ?
>=20
> --
>=20
>=20
> 					    Gilles Chanteperdrix.

------_=_NextPart_001_01C866B7.BAD4D8D8
Content-Type: application/octet-stream;
	name="qt.c"
Content-Transfer-Encoding: base64
Content-Description: qt.c
Content-Disposition: attachment;
	filename="qt.c"

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CgojaW5jbHVkZSA8YXNzZXJ0Lmg+CiNpbmNsdWRlIDxzdHJp
bmcuaD4KCiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVkZSA8bmF0aXZlL3RpbWVyLmg+
CiNpbmNsdWRlIDxuYXRpdmUvcXVldWUuaD4KCiNpbmNsdWRlIDxwdGhyZWFkLmg+Ci8qClRoaXMg
cHJvZ3JhbSBpcyBhbiBlY2hvIHNlcnZlci4KSXQgbGlzdGVucyBvbiBwb3J0IDQ0NDQ0IGZvciBh
IGNvbm5lY3Rpb24uCldoZW4gdGV4dCBkYXRhIGlzIHJlYWQgaXQgcHJpbnRzIGl0IG9uIHRoZSBk
aXNwbGF5LCB0byBydGxvZywgYW5kIGJhY2sgb24KICAgdGhlIHBvcnQuClRoaXMgcmVxdWlyZXMg
ZWNob19jbGllbnQuYyBvbiB0aGUgcmVtb3RlIGVuZC4KVGhpcyBwcm9ncmFtIGFsc28gbGlzdGVu
cyBvbiBwb3J0IDU1NTU1LiAgV2hlbiBhIGNvbm5lY3Rpb24gaXMgZXN0YWJsaXNoZWQsCiAgaXQg
c3RhcnRzIHNlbmRpbmcgb3V0IHRoZSBzZXF1ZW5jZSBvZiBpbnRlZ2VycyB1cGRhdGVkIGV2ZXJ5
IGhhbGYgc2Vjb25kLgogIFdoZW4gdGhlIGNvbm5lY3Rpb24gaXMgdGVybWluYXRlZCwgdGhlIHNl
cXVlbmNlIHN0b3BzLCBhbmQgd2hlbiBhCiAgY29ubmVjdGlvbiBpcyByZS1lc3RhYmxpc2hlZCB0
aGUgc2VxdWVuY2UgcmVzdW1lcyB3aGVyZSBpdCBsZWZ0IG9mZi4KKi8KCnN0YXRpYyBSVF9UQVNL
IHRhc2ssIHNoYWRvdzsKc3RhdGljIFJUX1FVRVVFIHE7CnN0YXRpYyBwdGhyZWFkX3QgdDsKCnN0
YXRpYyB2b2lkIHF0X3Rhc2sodm9pZCAqYXJnKQp7CiAgICBjaGFyIHFjID0gJ3EnOwogICAgCiAg
ICBhc3NlcnQoIXJ0X3Rhc2tfc2V0X3BlcmlvZGljKCZ0YXNrLCBUTV9OT1csIHJ0X3RpbWVyX25z
MnRpY2tzKDEwMDAwMDAwMDBVTEwpKSk7CiAgICAKICAgIGZvcig7OykgewogICAgICAgIHJ0X3Rh
c2tfd2FpdF9wZXJpb2QoMCk7CiAgICAgICAgcnRfcXVldWVfd3JpdGUoJnEsICZxYywgc2l6ZW9m
KHFjKSwgUV9OT1JNQUwpOwogICAgfQp9CgpzdGF0aWMgdm9pZCAqcXRfdGhyZWFkKHZvaWQgKmFy
ZykKewogICAgYXNzZXJ0KCFydF90YXNrX3NoYWRvdygmc2hhZG93LCAic2hhZG93IiwgMSwgMCkp
OwogICAgZm9yKDs7KSB7CiAgICAgICAgY2hhciBxYzsKICAgICAgICBpbnQgcmV0ID0gcnRfcXVl
dWVfcmVhZCgmcSwgJnFjLCBzaXplb2YocWMpLCBUTV9JTkZJTklURSk7CiAgICAgICAgcHRocmVh
ZF90ZXN0Y2FuY2VsKCk7CiAgICAgICAgaWYocmV0PT1zaXplb2YocWMpKSBwcmludGYoImdvdCBx
XG4iKTsKICAgICAgICBlbHNlIHByaW50ZigiZ290ICVkXG4iLCByZXQpOwogICAgfQogICAgcmV0
dXJuIDA7Cn0KCmludCBtYWluKHZvaWQpCnsKICAgIHB0aHJlYWRfYXR0cl90IGF0dHI7CiAgICBz
dHJ1Y3Qgc2NoZWRfcGFyYW0gcyA9IHsgNTAgfTsKICAgIG1sb2NrYWxsKE1DTF9DVVJSRU5UIHwg
TUNMX0ZVVFVSRSk7CgogICAgcHRocmVhZF9hdHRyX2luaXQoJmF0dHIpOwogICAgcHRocmVhZF9h
dHRyX3NldHNjaGVkcG9saWN5KCZhdHRyLCBTQ0hFRF9GSUZPKTsKICAgIHB0aHJlYWRfYXR0cl9z
ZXRzY2hlZHBhcmFtKCZhdHRyLCAmcyk7CiAgICBwdGhyZWFkX2F0dHJfc2V0c2NoZWRwb2xpY3ko
JmF0dHIsIFNDSEVEX0ZJRk8pOwogICAgcHRocmVhZF9hdHRyX3NldHN0YWNrc2l6ZSgmYXR0ciwg
UFRIUkVBRF9TVEFDS19NSU4gKiA0KTsKICAgIAogICAgYXNzZXJ0KCFydF9xdWV1ZV9jcmVhdGUo
JnEsICJxdHEiLCAxMDI0LCAxMDI0LCBRX1VOTElNSVRFRCkpOwogICAgYXNzZXJ0KCFwdGhyZWFk
X2NyZWF0ZSgmdCwgJmF0dHIsIHF0X3RocmVhZCwgTlVMTCkpOwogICAgYXNzZXJ0KCFydF90YXNr
X3NwYXduKCZ0YXNrLCAicXQiLCAxNjM4NCwgNzAsIDAsIHF0X3Rhc2ssIDApKTsKICAgIAogICAg
c2xlZXAoNSk7CiAgICBwcmludGYoImNhbmNlbGxpbmdcbiIpOwogICAgcHRocmVhZF9jYW5jZWwo
dCk7CiAgICBwdGhyZWFkX2pvaW4odCwgMCk7CiAgICAKICAgIHByaW50Zigiam9pbmVkIVxuIik7
CiAgICAgICAgCiAgICByZXR1cm4gMDsKfQo=

------_=_NextPart_001_01C866B7.BAD4D8D8--

